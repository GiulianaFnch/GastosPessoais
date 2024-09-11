//
//  HomeView.swift
//  GastosPessoais
//
//  Created by Formando on 10/09/2024.
//

import SwiftUI
import Charts

struct TransactionSummary: Identifiable {
    let id = UUID()
    let type: String  // Exemplo: "Despesas", "Receitas"
    let amount: Double
}

struct CategorySummary: Identifiable {
    let id = UUID()
    let category: String
    let amount: Double
}

struct HomeView: View {
    // Estado para armazenar transações e saldo disponível
    @State private var transactions: [Transaction] = []
    @State private var saldoDisponivel: Double = 0.0
    
    // Computa o resumo de despesas e receitas
    var summary: [TransactionSummary] {
        let totalDespesas = transactions.filter { $0.isExpense }.map { $0.amount }.reduce(0, +)
        let totalReceitas = transactions.filter { !$0.isExpense }.map { $0.amount }.reduce(0, +)
        
        return [
            TransactionSummary(type: "Despesas", amount: totalDespesas),
            TransactionSummary(type: "Receitas", amount: totalReceitas)
        ]
    }
    
    // Computa o resumo por categoria
    var categorySummary: [CategorySummary] {
        let groupedByCategory = Dictionary(grouping: transactions, by: { $0.category.name })
        return groupedByCategory.map { category, transactions in
            CategorySummary(category: category, amount: transactions.map { $0.amount }.reduce(0, +))
        }
    }
    
    var body: some View {
        NavigationView {
            VStack (alignment: .center) {
                HStack {
                    Text("Resumo")
                        .font(.title)
                        .bold()
                        .padding()
                    
                    Spacer()
                    
                    NavigationLink(destination: ConfigView()) {
                        Image(systemName: "gear")
                            .font(.title2)
                            .padding()
                    }
                }
                // Mostra o saldo disponível
                Text("Saldo Disponível: \(saldoDisponivel, specifier: "%.2f") €")
                    .font(.title2)
                    .bold()
                
                // Gráfico de Resumo
                
                
                // Gráfico de Barras usando Swift Charts
                Chart(summary) { item in
                    BarMark(
                        x: .value("Tipo", item.type),
                        y: .value("Valor", item.amount)
                    )
                    .foregroundStyle(by: .value("Tipo", item.type))
                }
                .frame(height: 250)
                .padding()
                
                
                // Gráfico por Categoria
                VStack {
                    Text("Resumo por Categoria")
                        .font(.title2)
                        .bold()
                    
                    // Gráfico de Barras usando Swift Charts
                    Chart(categorySummary) { item in
                        BarMark(
                            x: .value("Categoria", item.category),
                            y: .value("Valor", item.amount)
                        )
                        .foregroundStyle(by: .value("Categoria", item.category))
                    }
                    .frame(height: 200)
                    .padding()
                }
            }
            .onAppear {
                loadTransactions()
                calculateSaldoDisponivel()
            }
        }
    }
    
    
    // Função para carregar as transações salvas
    private func loadTransactions() {
        transactions = DataManager.shared.loadTransactions()
    }
    
    // Função para calcular o saldo disponível
    private func calculateSaldoDisponivel() {
        let totalReceitas = transactions.filter { !$0.isExpense }.map { $0.amount }.reduce(0, +)
        let totalDespesas = transactions.filter { $0.isExpense }.map { $0.amount }.reduce(0, +)
        saldoDisponivel = totalReceitas - totalDespesas
    }
}

#Preview {
    HomeView()
}

