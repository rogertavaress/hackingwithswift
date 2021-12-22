//
//  AddView.swift
//  iExpense
//
//  Created by Rogério Tavares on 22/11/21.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Pessoal"
    @State private var amount = 0.0
    
    @ObservedObject var expenses: Expenses
    
    let types = ["Profissional", "Pessoal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nome", text: $name)
                
                Picker("Tipo", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Valor", value: $amount, format: .currency(code: "BRL"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Adicionar nova despesa")
            .toolbar {
                Button("Salvar") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
