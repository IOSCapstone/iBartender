import SwiftUICore
import SwiftUI

extension Color {
    static let burgundy = Color(red: 80/255, green: 5/255, blue: 0/255)
}

struct WelcomePageView: View {
    var body: some View {
        ZStack {
            Color.burgundy
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                
                HStack {
                    Text("iBartender")
                    Image(systemName: "wineglass")
                }
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)
                .foregroundColor(.white)
       
                
                
                VStack {
                    NavigationLink(destination: LoginView()) {
                        Text("Log in")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: RegistrationView()) {
                        Text("Register")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                }
        }
        }

    }
}


#Preview {
    NavigationStack {
        WelcomePageView()
    }
}
