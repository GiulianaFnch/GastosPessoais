//
//  DataManager.swift
//  Gestão de Gastos Pessoais
//
//  Created by Formando on 10/09/2024.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private let transactionsKey = "transactions"
    
    // Função para salvar as transações usando UserDefaults
    func saveTransactions(_ transactions: [Transaction]) {
        if let encoded = try? JSONEncoder().encode(transactions) {
            UserDefaults.standard.set(encoded, forKey: transactionsKey)
        }
    }
    
    // Função para carregar as transações salvas
    func loadTransactions() -> [Transaction] {
        if let savedTransactions = UserDefaults.standard.object(forKey: transactionsKey) as? Data {
            if let decodedTransactions = try? JSONDecoder().decode([Transaction].self, from: savedTransactions) {
                return decodedTransactions
            }
        }
        return []  // Retorna uma lista vazia se não houver transações salvas
    }
}
