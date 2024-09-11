//
//  Transaction.swift
//  Gestão de Gastos Pessoais
//
//  Created by Formando on 10/09/2024.
//

import Foundation

struct Transaction: Codable, Identifiable {
    var id: UUID = UUID()  // Cada transação terá um identificador único
    var amount: Double     // O valor da transação
    var category: Category // A categoria associada à transação
    var date: Date         // Data da transação
    var note: String?      // Nota opcional
    var isExpense: Bool    // Indicador se é despesa (true) ou receita (false)
}
