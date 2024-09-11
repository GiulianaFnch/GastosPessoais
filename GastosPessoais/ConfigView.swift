//
//  ConfigView.swift
//  GastosPessoais
//
//  Created by Formando on 11/09/2024.
//

import SwiftUI

struct ConfigView: View {
    // Estado para mostrar um alerta de confirmação
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Configurações")
                    .font(.title)
                    .bold()
                    .padding()
                
                
                Button(action: {
                    showAlert = true
                }) {
                    Text("Limpar Registros")
                        .font(.title2)
                        .foregroundColor(.red)
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Confirmar"),
                        message: Text("Você tem certeza de que deseja limpar os registros?"),
                        primaryButton: .destructive(Text("Limpar")) {
                            clearRecords()
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
        }
    }
    
    private func clearRecords() {
        // Função para limpar os registros
        DataManager.shared.saveTransactions([])
    }
}

#Preview {
    ConfigView()
}
