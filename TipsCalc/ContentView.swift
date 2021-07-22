//
//  ContentView.swift
//  TipsCalc
//
//  Created by Евгений Иванов on 14.07.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmout = ""
    @State private var numberOfPeople = 1
    @State private var tipsPercent = 0
    
    let tipPercanteges = [0, 5, 10, 15, 20]
    
    // проверяем разделитель точка или запятая
    func checkDot (textCheck: String) -> (String){
        var result = ""
        for i in textCheck{
            if i == ","{
                result += "."
            }else{
                result += String(i)
            }
        }
        return result
    }
    
    var totalPerPerson: Float{
        let peopleCount = Float(numberOfPeople + 1)
        let tipSelection = Float(tipPercanteges[tipsPercent])
        let orderAmout = Float(checkDot(textCheck: checkAmout)) ?? 0
        let tipValue = orderAmout / 100 * tipSelection
        let grandTotal = orderAmout + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Bill", text: $checkAmout)
                        .keyboardType(.decimalPad)
                    Picker("Amout people", selection: $numberOfPeople) {
                        ForEach(1..<100) {
                            Text("\($0)")
                        }
                    }
                    
                }
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip Percentage", selection: $tipsPercent){
                        ForEach(0..<tipPercanteges.count) {
                            Text("\(self.tipPercanteges[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Total")){
                    Text("\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("Tell me about the tip", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
