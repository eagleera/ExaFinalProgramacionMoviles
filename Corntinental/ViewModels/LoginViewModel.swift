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
    
    @Published var username = ""
    @Published var password = ""
    
    @Published var isLoggedIn = false
    @Published var isLoading = false
    
    @Published var shouldNavigate = false
    
    private var disposables: Set<AnyCancellable> = []
    
    var loginHandler = LoginHandler()
    
    @Published var woofUrl = ""
    
    private var isLoadingPublisher: AnyPublisher<Bool, Never> {
        loginHandler.$isLoading
            .receive(on: RunLoop.main)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    private var isAuthenticatedPublisher: AnyPublisher<String, Never> {
        loginHandler.$woofResponse
            .receive(on: RunLoop.main)
            .map { response in
                guard let response = response else {
                    return ""
                }
                
                return response.url ?? ""
        }
        .eraseToAnyPublisher()
    }
    
    init() {
        isLoadingPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: self)
            .store(in: &disposables)
        
        isAuthenticatedPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.woofUrl, on: self)
            .store(in: &disposables)
    }
    
    func getRandomDog() {
        loginHandler.getRandomDog()
    }
    
}
