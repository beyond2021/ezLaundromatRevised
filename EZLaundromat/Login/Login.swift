//
//  Login.swift
//  SohoSuccess
//
//  Created by KEEVIN MITCHELL on 3/5/24.
//

import SwiftUI
import Firebase
import Lottie

struct Login: View {
    // View Properties
    @State private var activeTab: Tab = .login
    @State private var isLoading: Bool = false
    @State private var showEmailVerificationView: Bool = false
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @State private var reEnterPassword: String = ""
    /// Alert Properties
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    // Forgot Password Properties
    @State private var showResetAlert: Bool = false
    @State private var resetEmailAddress: String = ""
    // Userdefaults
    @AppStorage("log_status") private var logStatus: Bool = false
    var body: some View {
                ZStack {
                    NavigationStack {
                        List {
                            Section {
                                TextField("Email Address", text: $emailAddress)
                                    .keyboardType(.emailAddress)
                                    .customTextField("person")
                                
                                SecureField("Password", text: $password)
                                    .customTextField("person", 0, activeTab == .login ? 10 : 0)
                                if activeTab == .signUp {
                                    SecureField("Re-Enter Password", text: $reEnterPassword)
                                        .customTextField("person", 0, activeTab != .login ? 10 : 0)
                                    
                                }
                                
                            } header: {
                                Picker("", selection:  $activeTab) {
                                    ForEach(Tab.allCases, id:\.rawValue) {
                                        Text($0.rawValue)
                                            .tag($0)
                                    }
                                }
                                .pickerStyle(.segmented)
                                .listRowInsets(.init(top: 15, leading: 0, bottom: 10, trailing: 0))
                                .listRowSeparator(.hidden)
                            } footer: {
                                VStack(alignment: .trailing, spacing: 12, content: {
                                    if activeTab == .login {
                                        Button("Forgot Password?") {
                                            showResetAlert = true
                                            
                                        }
                                        .font(.caption)
                                        .tint(Color.accentColor)
                                    }
                                    Button(action: loginAndSignUp, label: {
                                        HStack(spacing: 12, content: {
                                            Text(activeTab == .login ? "Login" : "Create Account")
                                            Image(systemName: "arrow.right")
                                                .font(.callout)
                                        })
                                        .padding(.horizontal, 10)
                                    })
                                    .buttonStyle(.borderedProminent)
                                    .buttonBorderShape(.capsule)
                                    .showLoadingIndicator(isLoading)
                                    .disabled(buttonStatus)
                                    
                                    
                                    
                                })
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .listRowInsets(.init(top: 15, leading: 0, bottom: 0, trailing: 0))
                            }
                            .disabled(isLoading) // Disable the view when isLoading is true
                        }
                        .animation(.snappy, value: activeTab)
                        .listStyle(.insetGrouped)
                        .navigationTitle("EZLaundromat")
                        .font(.custom(customFont, size: 20))
                    }
                    .sheet(isPresented: $showEmailVerificationView, content: {
                        EmailVerificationView()
                            .presentationDetents([.height(350)])
                            .presentationCornerRadius(25)
                            .interactiveDismissDisabled()
                    })
                    .alert(alertMessage, isPresented: $showAlert, actions: {
                        
                    })
                    .alert("Reset Password", isPresented: $showResetAlert, actions: {
                        TextField("Email Address", text: $resetEmailAddress)
                        
                        Button("Send Rest Link", role: .destructive, action: sendResetLink)
                        Button("Cancel", role: .cancel) {
                            resetEmailAddress = ""
                        }
                    }, message: {
                        Text("Enter the email address.")
                    })
                    .onChange(of: activeTab, initial: false) { oldValue, newValue in
                        password = ""
                        reEnterPassword = ""
                    }
                }
            }

        //MARK: Email Verification View
        @ViewBuilder
        func EmailVerificationView() -> some View {
            VStack( spacing: 6, content: {
                GeometryReader { _ in
                    if let bundle = Bundle.main.path(forResource: "EmailAnimation", ofType: "json") {
                        LottieView {
                            await LottieAnimation.loadedFrom(url: URL(filePath: bundle))
                        }
                        .playing(loopMode: .loop)
                    }
                }
                Text("Verification")
                    .font(.custom(customFont, size: 20))
                    .fontWeight(.semibold)
                Text("We have sent a verification email to your email address.\nPlease verify to continue.")
                    .multilineTextAlignment(.center)
                    .font(.custom(customFont, size: 14))
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 25)
            })
            .overlay(alignment: .topTrailing, content: {
                Button("Cancel") {
                    // YOU CAN DELETE THE UNVERIFIEND EMAIL FROM FIREBASE HERE
                    showEmailVerificationView = false
                    isLoading = false
                    
                    //                if let user = Auth.auth().currentUser {
                    //                    user.delete { _ in
                    //
                    //                    }
                    //                }
                }
                .padding(15)
            })
            .padding(.bottom, 15)
            // bugging the user every 2 seconds fo verify email
            .onReceive(Timer.publish(every: 2, on: .main, in: .default).autoconnect(), perform: { _ in
                if let user = Auth.auth().currentUser {
                    user.reload()
                    if user.isEmailVerified {
                        // Email Sucessfully Verified
                        showEmailVerificationView = false
                        logStatus = true
                    }
                }
            })
            
        }
        func sendResetLink() {
            Task {
                do {
                    if resetEmailAddress.isEmpty {
                        await presentAlert("Please enter a valid email address")
                        return
                    }
                    isLoading = true
                    try await Auth.auth().sendPasswordReset(withEmail: resetEmailAddress)
                    await presentAlert("Please check your email inbox and follow the steps to reset your password.")
                    resetEmailAddress = ""
                    isLoading = false
                } catch {
                    await presentAlert(error.localizedDescription)
                }
            }
        }
        
        //MARK: Action
        func loginAndSignUp() {
            Task {
                isLoading = true
                do {
                    /// Login btn press -> check if email is verified of not Verified send user to EZHome
                    /// otherwise send user a verification Email address
                    if activeTab == .login {
                        // Logging in...
                        let result = try await Auth.auth().signIn(withEmail: emailAddress, password: password)
                        if result.user.isEmailVerified {
                            /// Verified User
                            /// redirect to home view
                            logStatus = true
                        } else {
                            /// Signing Up...
                            ///  Send Verification email  and present Verification View
                            try await result.user.sendEmailVerification()
                            showEmailVerificationView = true
                        }
                        
                    } else {
                        /// Create New Account
                        if password == reEnterPassword {
                            let result = try await  Auth.auth().createUser(withEmail: emailAddress, password: password)
                            /// sending Verification email
                            try await result.user.sendEmailVerification()
                            /// Showing Email Verification View
                            showEmailVerificationView = true
                        } else {
                            await presentAlert("Mismatching Password")
                        }
                    }
                    
                } catch {
                    // Error Alert Body
                    await presentAlert(error.localizedDescription)
                }
            }
            
        }
        //MARK: Presenting Alert LOGIC MAIN THREAD
        func presentAlert(_ message: String) async {
            await MainActor.run {
                alertMessage = message
                showAlert = true
                isLoading = false
            }
        }
        //MARK: Tab Type SWITCHING
        enum Tab: String, CaseIterable {
            case login = "Login"
            case signUp = "Sign Up"
        }
        //MARK: Button Status
        var buttonStatus: Bool {
            /// enable the button whether field are full
            if activeTab == .login {
                // Login
                return emailAddress.isEmpty || password.isEmpty
            }
            // Sign Up
            return emailAddress.isEmpty || password.isEmpty || reEnterPassword.isEmpty
        }
    }

// Customization
fileprivate extension View {
    @ViewBuilder
    func showLoadingIndicator(_ status: Bool) -> some View {
        self
            .animation(.snappy) { content in
                content
                    .opacity(status ? 0 : 1)
            }
            .overlay {
                if status {
                    Capsule()
                        .fill(.bar)
                    ProgressView()
                }
            }
    }
    @ViewBuilder
    func customTextField(_ icon: String? = nil, _ paddingTop: CGFloat = 0,  _ paddingBottom: CGFloat = 0) -> some View {
        HStack(spacing: 12) {
            if let icon {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(.gray)
            }
            self
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
        .background(.bar, in:.rect(cornerRadius: 10))
        .padding(.horizontal, 15)
        .padding(.top, paddingTop)
        .padding(.bottom, paddingBottom)
        .listRowInsets(.init(top: 10, leading: 0, bottom: 0, trailing: 0))
        .listRowSeparator(.hidden)
    }
}

#Preview {
    ContentView()
}

