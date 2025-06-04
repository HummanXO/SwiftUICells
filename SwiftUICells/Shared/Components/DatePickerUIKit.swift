//
//  DatePickerUIKit.swift
//  SwiftUICells
//
//  Created by Aleksandr on 04.06.2025.
//

import Foundation
import UIKit
import SwiftUI

struct DatePickerUIKit: UIViewRepresentable {
    @Binding var age: Int
    
    func makeUIView(context: Context) -> UIView {
        let view = DatePickerView()
        view.onAgeChanged = { newAge in
            self.age = newAge
        }
        return view
    }
    
    func updateUIView(_ datePicker: UIView, context: Context) {
    }
}
