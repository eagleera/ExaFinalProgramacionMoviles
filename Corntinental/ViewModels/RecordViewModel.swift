//
//  RecordViewModel.swift
//  Corntinental
//
//  Created by Noel Aguilera Terrazas on 26/05/20.
//  Copyright © 2020 Daniel Aguilera. All rights reserved.
//

import SwiftUI
import Combine

class RecordViewModel: ObservableObject, Identifiable {
    
    @Published var recordResponse: RecordResponse?
    @Published var name: String = ""
    @Published var records: [Record] = []
    
    private var disposables: Set<AnyCancellable> = []
    
    var gameHandler = GameHandler()
    
    private var isNamePublisher: AnyPublisher<String, Never> {
        gameHandler.$name
            .receive(on: RunLoop.main)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    private var isRecordPublisher: AnyPublisher<[Record], Never> {
        gameHandler.$records
            .receive(on: RunLoop.main)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    init() {
        isNamePublisher
            .receive(on: RunLoop.main)
            .assign(to: \.name, on: self)
            .store(in: &disposables)
        isRecordPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.records, on: self)
            .store(in: &disposables)
    }
    func getRecord() {
        gameHandler.getRecord()
    }
}
