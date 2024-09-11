//
//  ContentView.swift
//  GastosPessoais
//
//  Created by Formando on 10/09/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            HistoricoView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("Histórico")
                }
            
            RegistroView()
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text("Registro")
                }
            
        }
    }
}


