//
//  PieChartView.swift
//  GastosPessoais
//
//  Created by Formando on 11/09/2024.
//

import SwiftUI
import DGCharts

struct PieChartRepresentable: UIViewRepresentable {
    var data: [Double]
    var labels: [String]

    func makeUIView(context: Context) -> PieChartView {
        let chartView = PieChartView()
        chartView.centerText = "Resumo"
        return chartView
    }

    func updateUIView(_ uiView: PieChartView, context: Context) {
        var entries: [PieChartDataEntry] = []
        
        for (index, value) in data.enumerated() {
            let entry = PieChartDataEntry(value: value, label: labels[index])
            entries.append(entry)
        }
        
        let dataSet = PieChartDataSet(entries: entries, label: "")
        dataSet.colors = ChartColorTemplates.material()
        let pieData = PieChartData(dataSet: dataSet)
        
        uiView.data = pieData
    }
}
