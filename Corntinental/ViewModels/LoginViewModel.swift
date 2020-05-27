//
//  LoginViewModel.swift
//  Corntinental
//
//  Created by Noel Aguilera Terrazas on 19/05/20.
//  Copyright © 2020 Daniel Aguilera. All rights reserved.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject, Identifiable {
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var isLoading = false
    
    @Published var shouldNavigate = false
    
    private var disposables: Set<AnyCancellable> = []
    
    var loginHandler = LoginHandler()
    
    @Published var authenticated = false
    
    private var isLoadingPublisher: AnyPublisher<Bool, Never> {
        loginHandler.$isLoading
            .receive(on: RunLoop.main)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    private var isAuthenticatedPublisher: AnyPublisher<Bool, Never> {
        loginHandler.$authenticated
        .receive(on: RunLoop.main)
        .map { $0 }
        .eraseToAnyPublisher()
    }
    
    init() {
        isLoadingPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: self)
            .store(in: &disposables)

        isAuthenticatedPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.authenticated, on: self)
            .store(in: &disposables)
    }
    
    func login(){
        loginHandler.tryLogin(email: email, password: password)
    }
    
}
