//
//  CalculatorView.swift
//  iCalculator
//
//  Created by Iker Perea on 5/7/24.
//

import SwiftUI

struct CalculatorItem: View {
    @State var item: ButtonString
    var body: some View {
        Button {
            
        } label: {
            Text(item.rawValue)
        }
    }
}

#Preview {
    CalculatorItem(item: .five)
}
