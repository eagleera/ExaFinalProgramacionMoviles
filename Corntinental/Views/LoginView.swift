//
//  LoginView.swift
//  Corntinental
//
//  Created by Noel Aguilera Terrazas on 19/05/20.
//  Copyright © 2020 Daniel Aguilera. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    
    var loginButton: some View {
        NavigationLink(destination: DetailView(), isActive: .constant(viewModel.authenticated)) {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("Iniciar sesión").foregroundColor(.white).fontWeight(.bold)
                    Spacer()
                }
                Spacer()
            }.frame(minHeight: 55.0, maxHeight: 55.0)
                .background(Color.red)
                .cornerRadius(2.5)
                .padding(.top, 77.0)
        }.simultaneousGesture(TapGesture().onEnded{
            self.loginUser()
        })
    }
    
    var placeHolderTextView: some View {
        PlaceholderTextField(placeholder: Text("Correo"), text: $viewModel.email)
            .padding(.top, 32.0)
    }
    
    var passwordTextView: some View {
        SecurePlaceholderTextField(placeholder: Text("Contraseña"), text: $viewModel.password)
            .padding(.top, 32.0)
    }
    
    var titleView: some View {
        VStack(alignment: .leading) {
            Text("Bienvenido a")
                .tracking(1.0)
            Text("Corntinental").fontWeight(.bold)
        }.padding(EdgeInsets(top: 44.0, leading: .zero, bottom: .zero, trailing: .zero))
    }
    
    var body: some View {
        NavigationView {
            LoadingView(isShowing: .constant(viewModel.isLoading)) {
                VStack(alignment: .leading) {
                    self.titleView
                    self.placeHolderTextView
                    self.passwordTextView
                    self.loginButton
                    Spacer()
                    Spacer()
                }.padding(22.0)
            }
        }
    
    }
    
    private func loginUser() {
        viewModel.login()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
