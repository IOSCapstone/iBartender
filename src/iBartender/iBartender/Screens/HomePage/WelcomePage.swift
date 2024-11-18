//
//  HomePage.swift
//  iBartender
//
//  Created by Amin Carbonell on 11/9/24.
//

import SwiftUICore
import SwiftUI

struct WelcomePage: View {
    var body: some View {
            VStack(spacing: 20) {
                Text("iBartender")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)
                
                VStack {
                    NavigationLink(destination: LoginView()) {
                        Text("Log in")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: RegistrationView()) {
                        Text("Register")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                }
            }
        }
}


#Preview {
    NavigationStack {
        WelcomePage()
    }
}
