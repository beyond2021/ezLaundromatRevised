//
//  AboutUS.swift
//  EZLaundromat
//
//  Created by KEEVIN MITCHELL on 3/12/24.
//

import SwiftUI

struct AboutUS: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 5) {
                Group {
                    Text("Welcome to EZLaundromat!")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                        .padding(.top, 20)
                    Text("At EZLaundromat, we're more than just a place to do laundry – we're a community hub dedicated to making your laundry experience convenient, efficient, and enjoyable.")
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                    Text("Our Story.")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                    Text("Founded in 2019, EZLaundry has been proudly serving the Fairfield community for 5 years. Our journey began with a vision to provide a clean, modern, and welcoming environment where customers could tackle their laundry needs with ease.")
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                    Text("Our Mission.")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                    Text("At EZLaundromat, our mission is simple: to exceed our customers' expectations by delivering exceptional service, quality, and value. We believe that every load of laundry represents an opportunity to make a positive impact on our customers' lives, and we're committed to upholding the highest standards of cleanliness, efficiency, and customer care.")
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                    Text("Our Team.")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                    Text("Behind every successful laundromat is a dedicated team of professionals, and at EZLaundromat, we're proud to have some of the best in the business. From our friendly attendants who are always ready to assist you to our skilled technicians who ensure our machines are in top-notch condition, each member of our team plays a crucial role in delivering the outstanding service you deserve.")
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                    Text("Our Services.")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                    Text("Whether you're a busy professional looking to save time on laundry day or a family in need of a convenient solution for large loads, [Your Laundromat's Name] has you covered. With a wide range of state-of-the-art machines, including washers, dryers, and specialty equipment, we offer everything you need to get your laundry done quickly and efficiently.")
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                }
                Group {
                    Text("Community Involvement.")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                    Text("Whether you're a busy professional looking to save time on laundry day or a family in need of a convenient solution for large loads, [Your Laundromat's Name] has you covered. With a wide range of state-of-the-art machines, including washers, dryers, and specialty equipment, we offer everything you need to get your laundry done quickly and efficiently.")
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                    Text("Community Involvement.")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                    Text("At [Your Laundromat's Name], we're proud to be an active member of the [Your Location] community. From sponsoring local events to participating in charitable initiatives, we're always looking for ways to give back and make a positive impact on the neighborhoods we serve.")
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                    Text("Visit Us Today!")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                    Text("Ready to experience the difference at EZLaundry? Stop by our convenient location at 427 Anderson Avenue, Fairview NJ 07022 and discover why we're [Your Location]'s premier destination for all your laundry needs. We can't wait to welcome you!")
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                    
                    
                }
                
            }
        }
    }
}

#Preview {
    AboutUS()
}
