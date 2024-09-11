//
//  HistoricoView.swift
//  GastosPessoais
//
//  Created by Formando on 10/09/2024.
//
import SwiftUI

struct HistoricoView: View {
    // Usamos o DataManager para obter as transações
    @State private var transactions: [Transaction] = []
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Histórico de Transações")
                    .font(.title)
                    .bold()
                    .padding()
                
                List(transactions) { transaction in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(transaction.category.name)
                                .font(.headline)
                            Text(transaction.note ?? "Sem nota")
                                .font(.subheadline)
                            if(transaction.isExpense == false){
                                Text("+")
                                    .font(.footnote)
                            }else{
                                Text("-")
                                    .font(.footnote)
                            }
                            Text("\(transaction.amount, specifier: "%.2f") €")
                                .font(.subheadline)
                        }
                        Spacer()
                        Text(transaction.date, style: .date)
                            .font(.footnote)
                    }
                }
                .onAppear {
                    loadTransactions()
                }
            }
        }
    }
    
    private func loadTransactions() {
        transactions = DataManager.shared.loadTransactions()
    }
}

struct HistoricoView_Previews: PreviewProvider {
    static var previews: some View {
        HistoricoView()
    }
}
