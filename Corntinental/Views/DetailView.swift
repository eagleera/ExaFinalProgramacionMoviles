//
//  DogView.swift
//  Corntinental
//
//  Created by Noel Aguilera Terrazas on 19/05/20.
//  Copyright © 2020 Daniel Aguilera. All rights reserved.
//

import SwiftUI
import Combine

struct DetailView: View {
    @ObservedObject var viewModel = RecordViewModel()

    
    var body: some View {
        VStack(alignment: .center) {
            Text("Eres \(viewModel.name)")
            List(viewModel.records, id: \.id) { record in
                RecordRow(record: record)
            }
        }.onAppear(perform: getRecord)
    }
    private func getRecord(){
        viewModel.getRecord()
    }
    struct RecordRow: View {
        var record: Record

        var body: some View {
            HStack {
                Text("Alias: \(record.alias)")
                Text("Puntos: \(record.points)")
                Text("Lugar: \(record.place)")
                Text("Juegos ganados: \(record.won)")
            }
        }
    }
}
