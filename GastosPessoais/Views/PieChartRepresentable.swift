//
//  PieChartRepresentable.swift
//  GastosPessoais
//
//  Created by Formando on 11/09/2024.
//

import SwiftUI
import DGCharts  // Importando a biblioteca DGCharts

struct PieChartRepresentable: UIViewRepresentable {
    var data: [Double]  // Os dados que serão exibidos no gráfico
    var labels: [String]  // Os rótulos correspondentes aos dados

    // Este método cria a instância do gráfico
    func makeUIView(context: Context) -> PieChartView {
        let chartView = PieChartView()
        chartView.centerText = "Resumo"  // Texto central no gráfico de pizza
        return chartView
    }

    // Este método atualiza a interface do gráfico sempre que os dados mudam
    func updateUIView(_ uiView: PieChartView, context: Context) {
        var entries: [PieChartDataEntry] = []  // Lista de entradas para o gráfico

        // Preenche as entradas com os dados fornecidos
        for (index, value) in data.enumerated() {
            let entry = PieChartDataEntry(value: value, label: labels[index])
            entries.append(entry)
        }

        // Cria o conjunto de dados para o gráfico de pizza
        let dataSet = PieChartDataSet(entries: entries, label: "")  // Conjunto de dados sem rótulo principal
        dataSet.colors = ChartColorTemplates.material()  // Aplicação de cores predefinidas ao gráfico

        // Configura os dados no gráfico
        let pieData = PieChartData(dataSet: dataSet)
        uiView.data = pieData
    }
}
