//
//  ChartView.swift
//  Presentation_SwiftUI_iOS16
//
//  Created by iMac on 22.05.2024.
//

import SwiftUI
import Charts

struct ChartData: Identifiable {
    let id = UUID()
    let day: String
    let value: Double
    
    static let mockData2022: [ChartData] = [
        .init(day: "Jun 1", value: 94),
        .init(day: "Jun 2", value: 106),
        .init(day: "Jun 3", value: 44),
        .init(day: "Jun 4", value: 66),
        .init(day: "Jun 5", value: 54)
    ]
    
    static let mockData2023: [ChartData] = [
        .init(day: "Jun 1", value: 111),
        .init(day: "Jun 2", value: 14),
        .init(day: "Jun 3", value: 86),
        .init(day: "Jun 4", value: 54),
        .init(day: "Jun 5", value: 93)
    ]
}

struct ChartView: View {
    var body: some View {
        Chart {
            ForEach(ChartData.mockData2022) { item in
                LineMark(
                    x: .value(Text("Day"), item.day),
                    y: .value(Text("Value"), item.value),
                    series: .value("Year", "2022")
                )
                .interpolationMethod(.cardinal)
                .foregroundStyle(by: .value("Year", "2022"))
                .symbol(by: .value("Year", "2022"))
            }
            
            ForEach(ChartData.mockData2023) { item in
                LineMark(
                    x: .value(Text("Day"), item.day),
                    y: .value(Text("Value"), item.value),
                    series: .value("Year", "2023")
                )
                .interpolationMethod(.cardinal)
                .foregroundStyle(by: .value("Year", "2023"))
                .symbol(by: .value("Year", "2023"))
            }
        }
        .frame(height: 300)
        .padding(20)
    }
}

#Preview {
    ChartView()
}
