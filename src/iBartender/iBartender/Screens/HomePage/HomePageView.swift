//
//  HomePage.swift
//  iBartender
//
//  Created by Amin Carbonell on 11/9/24.
//

import SwiftUICore
import SwiftUI
import SwiftUICore

struct HomePage: View {
    var body: some View {
            VStack {
                Text("Welcome to iBartender!")
                    .font(.largeTitle)
                    .padding()

                // Sign up + Login buttons in a vertical stack
                VStack(spacing: 16) {
                    // Navigate to RegistrationView
                    NavigationLink(destination: RegistrationView()) {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)   // Make button stretch horizontally
                            .padding()                    // Add padding to make the button taller
                    }
                    .buttonStyle(.borderedProminent) // Style button
                    
                    NavigationLink(destination: LoginView()) {
                        
                        Text("Login")
                            .frame(maxWidth: .infinity)   // Make button stretch horizontally
                            .padding()                    // Add padding to make the button taller
                    }
                    .buttonStyle(.bordered) // Style button
                }
                .padding(.horizontal, 40) // Add padding to the sides to control width
            }
            .padding()
    }
}




#Preview {
    NavigationStack {
        HomePage()
    }
}
