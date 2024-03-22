//
//  Login.swift
//  SohoSuccess
//
//  Created by KEEVIN MITCHELL on 3/5/24.
// Apple sing in with google
// https://firebase.google.com/docs/auth/ios/apple?hl=en&authuser=0

import SwiftUI
import Firebase
import Lottie
// Apple Pay
import AuthenticationServices
import CryptoKit

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
    // Apple Pay Properties
    @State private var errorMessage: String = ""
    @State private var showAppleErrorMessageAlert: Bool = false
    @State private var appleIsLoading: Bool = false
    @State private var nonce: String?
    @Environment(\.colorScheme) private var scheme
    //
    @State private var selectedImage: UIImage?
    @State private var image: Image?
    //pre iOS16
    @State var imagePickerPresented = false
    @Environment(\.presentationMode) var mode
    @State private var showImage: Bool = false
    var body: some View {
        ZStack {
   //         if showImage {
                NavigationStack {
                    //
                    if activeTab == .signUp {
                    if let image = image {
                        
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 140, height: 140)
                            .clipShape(Circle())
                            .foregroundColor(.white)
                        
                        
                        
                            .padding()
                        
                        
                    } else {
                        
                        Button(action: {imagePickerPresented.toggle()}) {
                            VStack {
                                Image(systemName: "plus").font(.title).padding(.bottom, 4)
                                Text("Photo").font(.headline)
                            }
                        }
                        .padding(30)
                        .foregroundColor(Color.appBlue)
                        .overlay(
                            Circle()
                                .stroke(Color.appBlue, lineWidth: 2)
                        )
                        .sheet(isPresented: $imagePickerPresented, onDismiss: loadImage) {
                            // ImagePicker(image: $selectedImage)
                            TwitImagePicker(selectedImage: $selectedImage)
                            
                        }
                        .padding()
                    }
                }
                //
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
//                    Spacer()
                    
                    VStack(alignment: .leading, content: {
                        Text("OR")
                            .font(.title3.bold())
                        SignInWithAppleButton(.signIn) { request in
                            let nonce = randomNonceString()
                            self.nonce = nonce
                            // Your Preferences
                            request.requestedScopes = [.email, .fullName]
                            request.nonce = sha256(nonce)
                            
                        } onCompletion: { result in
                            switch result {
                            case .success(let authorization):
                                appleLoginWithFirebase(authorization)
                            case .failure(let error):
                                showAppleLoginError(error.localizedDescription
                                )
                            }
                            
                        }
//                        .padding(.bottom)
                        //                                .signInWithAppleButtonStyle(scheme == .dark ? .white : .black)
                        // Custom label for light and dark schemes
                        .overlay{
                            ZStack {
                                Capsule()
                                HStack {
                                    Image(systemName: "applelogo")
                                    Text("Sign on with Apple")
                                }
                                .foregroundStyle(scheme == .dark ? .black: .white)
                            }
                            .allowsHitTesting(false)
                        }
                        .frame(height: 45)
                        .clipShape(.capsule)
                        .padding(.top, 10)
                        
                    })
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(5)
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
                    //
                    .alert("", isPresented: $showAppleErrorMessageAlert, actions: {
                        
                    })
                    // When firebase is doing the job
                    .overlay {
                        if appleIsLoading {
                            LoadingScreen()
                        }
                        
                    }
                    //
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
//                    .onChange(of: showImage, initial: false) { oldValue, newValue in
//                        withAnimation {
//                            showImage = true
//                        }
//                        
//                    }
                }
            }
    @ViewBuilder
    func LoadingScreen() -> some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
            ProgressView()
                .frame(width: 45, height: 45)
                .background(.background, in: .rect(cornerRadius: 5))
        }
        
    }
    //Apple Lohin with Fire Base
    func appleLoginWithFirebase(_ authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            /// showing loading screen until Login completes with Firebase
            appleIsLoading = true
          guard let nonce else {
//            fatalError("Invalid state: A login callback was received, but no login request was sent.")
              showAppleLoginError("Cannot process your request")
              return
          }
          guard let appleIDToken = appleIDCredential.identityToken else {
//            print("Unable to fetch identity token")
              showAppleLoginError("Cannot process your request")
            return
          }
          guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
//            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
              showAppleLoginError("Cannot process your request")
            return
          }
          // Initialize a Firebase credential, including the user's full name.
          let credential = OAuthProvider.appleCredential(withIDToken: idTokenString,
                                                            rawNonce: nonce,
                                                            fullName: appleIDCredential.fullName)
          // Sign in with Firebase.
          Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error {
              // Error. If error.code == .MissingOrInvalidNonce, make sure
              // you're sending the SHA256-hashed nonce as a hex string with
              // your request to Apple.
//              print(error.localizedDescription)
                showAppleLoginError(error.localizedDescription)
//              return
            }
            // User is signed in to Firebase with Apple.
            ///Pushing user to home view
            logStatus = true
            appleIsLoading = false
          }
        }
        
    }
    // From Apple
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      var randomBytes = [UInt8](repeating: 0, count: length)
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }

      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

      let nonce = randomBytes.map { byte in
        // Pick a random character from the set, wrapping around if needed.
        charset[Int(byte) % charset.count]
      }

      return String(nonce)
    }
    // From Apple
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }


        
    // Login With Apple Errors
    func showAppleLoginError(_ message: String ) {
        errorMessage = message
        showAppleErrorMessageAlert.toggle()
        appleIsLoading = false
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
extension Login {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
    
}


