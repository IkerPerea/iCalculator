//
//  ContentView.swift
//  iCalculator
//
//  Created by Iker Perea on 5/7/24.
//

import SwiftUI

struct ContentView: View {
    @State var buttons: [[ButtonString]] = [[.clear, .negative, .delete, .divide], [.seven, .eight, .nine, .multiply], [.four, .five, .six, .substract], [.one, .two, .three, .add], [.zero, .decimal, .equal]]
    @State var value = "0"
    @State var savedNumber: Double = 0
    @State var operation: Operation = .none
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundStyle(.white)
                }
                ForEach(buttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { item in
                            customButton(item: item)
                        }
                    }
                }
            }
        }
    }
    fileprivate func customButton(item: ButtonString) -> some View {
        return Button {
            withAnimation(.easeIn) {
                buttonAction(button: item)
            }
        } label: {
            Text(item.rawValue)
                .font(.system(size: 32))
                .bold()
                .frame(
                    width: self.buttonWidth(item: item),
                    height: self.buttonHeight()
                )
                .background(item.buttonColor)
                .foregroundColor(.white)
                .cornerRadius(self.buttonWidth(item: item)/2)
        }
    }
    func buttonWidth(item: ButtonString) -> CGFloat {
         if item == .zero {
             return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
         }
         return (UIScreen.main.bounds.width - (5*12)) / 4
     }
    func buttonHeight() -> CGFloat {
           return (UIScreen.main.bounds.width - (5*12)) / 4
       }
    func buttonAction(button: ButtonString) {
        switch button {
        case .add, .substract, .multiply, .divide, .equal:
            if button == .add {
                operation = .add
                savedNumber = Double(value) ?? 0
            } else if button == .substract {
                operation = .substract
                savedNumber = Double(value) ?? 0
            } else if button == .multiply {
                operation = .multiply
                savedNumber = Double(value) ?? 0
            } else if button == .divide {
                operation = .divide
                savedNumber = Double(value) ?? 0
            } else if button == .equal {
                let actualValue = Double(self.value) ?? 0
                if operation == .add {
                    let addition = savedNumber + actualValue
                    value = "\(addition.clean)"
                    operation = .none
                } else if operation == .substract {
                    let substraction = savedNumber - actualValue
                    value = "\(substraction.clean)"
                    operation = .none
                } else if operation == .multiply {
                    let multiplication = savedNumber * actualValue
                    value = "\(multiplication.clean)"
                    operation = .none
                } else if operation == .divide {
                    let division = savedNumber / actualValue
                    value = "\(division.clean)"
                    operation = .none
                }
            }
            if button != .equal {
                value = "0"
            }
        case .clear:
            value = "0"
        case .decimal, .negative, .delete:
            var actualValue = Double(self.value) ?? 0
            if button == .negative {
                actualValue = actualValue * -1
                value = "\(actualValue.clean)"
            }
            if button == .decimal {
                if value.contains(".") {
                } else {
                    value = "\(value)."
                }
            }
            if button == .delete {
                if value.isEmpty {
                } else {
                    value.removeLast()
                }
            }
        default:
            let number = button.rawValue
            if value == "0" {
                value = number
            } else {
                value = "\(value)\(number)"
            }
        }
        
    }
}
#Preview {
    ContentView()
}

enum Operation {
    case add, substract, multiply, divide, none
}
enum ButtonString: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case substract = "-"
    case multiply = "x"
    case divide = "÷"
    case clear = "AC"
    case decimal = "."
    case delete = "⌫"
    case negative = "-/+"
    case equal = "="
    
    var buttonColor: Color {
        switch self {
        case .add, .substract, .divide, .multiply, .equal:
            return .orange
        case .clear, .negative, .delete:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}
extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
