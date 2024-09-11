//
//  RegistroView.swift
//  GastosPessoais
//
//  Created by Formando on 10/09/2024.
//

import SwiftUI

struct RegistroView: View {
    @State private var amount: String = ""
    @State private var category: String = ""
    @State private var date: String = ""
    @State private var note: String = ""
    @State private var isExpense: Bool = true
    
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .center) {
                    
                    Text("Novo Registro")
                        .font(.title)
                        .bold()
                        .padding()
                    
                    Text("Adicione uma nova transação")
                        .font(.title)
                    
                    Form {
                        Label("Valor da transação", systemImage: "eurosign.circle")
                        TextField("€", text: $amount)
                            .keyboardType(.decimalPad)
                        
                        Label("Categoria", systemImage: "list.bullet.circle")
                        TextField("Contas, viagem...", text: $category)
                        
                        Label("Data", systemImage: "calendar.circle")
                        TextField("dd/mm/aaaa", text: $date)
                            .keyboardType(.numbersAndPunctuation)
                        
                        Label("Nota", systemImage: "square.and.pencil")
                        TextField("Opcional", text: $note)
                        
                        Label("Despesa", systemImage: "plusminus.circle")
                        Toggle(isOn: $isExpense) {
                            Text(isExpense ? "Despesa" : "Receita")
                        }
                        
                        Button("Enviar") {
                            saveTransaction()
                        }
                    }
                }
                .padding()}
        }
    }
    
    private func saveTransaction() {
        // Converter o valor e a data para os tipos apropriados
        guard let amountValue = Double(amount),
              let dateValue = dateFormatter.date(from: date) else {
            // Handle error: invalid amount or date
            return
        }
        
        let categoryObj = Category(name: category)
        let newTransaction = Transaction(
            id: UUID(),
            amount: amountValue,
            category: categoryObj,
            date: dateValue,
            note: note,
            isExpense: isExpense
        )
        
        var transactions = DataManager.shared.loadTransactions()
        transactions.append(newTransaction)
        DataManager.shared.saveTransactions(transactions)
        
        
        // Clear the form
        amount = ""
        category = ""
        date = ""
        note = ""
        isExpense = true
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }
}

#Preview {
    RegistroView()
}
