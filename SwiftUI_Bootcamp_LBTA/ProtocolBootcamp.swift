//
//  ProtocolBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 07.11.2023.
//

import SwiftUI

struct DefaultColorTheme: ColorThemeProtocol {
    let primary: Color = .blue
    let secondary: Color = .white
    let tertiary: Color = .gray
}

struct OtherColorTheme: ColorThemeProtocol {
    let primary: Color = .red
    let secondary: Color = .white
    let tertiary: Color = .green
}

protocol ColorThemeProtocol {
    var primary: Color { get }
    var secondary: Color { get }
    var tertiary: Color { get }
}

protocol DataSourceProtocol {
    var buttonText: String { get }
    
    func didTap()
}

final class DataSource: DataSourceProtocol {
    var buttonText: String = "Protocol are awesome."
    
    func didTap() {
        buttonText = "Data Source!!"
    }
}

final class OtherDataSource: DataSourceProtocol {
    var buttonText: String = "Protocol are lame."
    
    func didTap() {
        buttonText = "Other Data Source!!"
    }
}

struct ProtocolBootcamp: View {
    
    let colorTheme1: ColorThemeProtocol
    //    let colorTheme2: ProtocolColorTheme
//    let dataSource1: DataSource
    let dataSource2: DataSourceProtocol
    
    var body: some View {
        ZStack {
            colorTheme1.primary
                .ignoresSafeArea()
            
            Text(dataSource2.buttonText)
                .font(.headline)
                .foregroundStyle(colorTheme1.secondary)
                .padding()
                .background(colorTheme1.tertiary)
                .clipShape(.rect(cornerRadius: 10))
                .onTapGesture {
                    dataSource2.didTap()
                }
        }
    }
}

#Preview {
    ProtocolBootcamp(colorTheme1: OtherColorTheme(), dataSource2: OtherDataSource())
}
