//
//  DatePickerView.swift
//  SwiftUICells
//
//  Created by Aleksandr on 04.06.2025.
//

import UIKit

class DatePickerView: UIView {
    
    var onAgeChanged: ((Int) -> Void)?
    
    private let ageTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter age"
        tf.borderStyle = .roundedRect
        tf.textAlignment = .center
        return tf
    }()
    
    private let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.maximumDate = Date()
        dp.minimumDate = Calendar.current.date(byAdding: .year, value: -120, to: Date())
        dp.preferredDatePickerStyle = .wheels
        return dp
    }()
    
    private let toolbar: UIToolbar = {
        let tb = UIToolbar()
        tb.sizeToFit()
        return tb
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupPicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(ageTextField)
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ageTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            ageTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            ageTextField.topAnchor.constraint(equalTo: topAnchor),
            ageTextField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupPicker() {
        let done = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(donePressed))
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelPressed))
        toolbar.setItems([cancel, flex, done], animated: false)
        
        ageTextField.inputView = datePicker
        ageTextField.inputAccessoryView = toolbar
    }
    
    @objc private func donePressed() {
        let birthDate = datePicker.date
        let age = calculateAge(from: birthDate)
        ageTextField.text = "\(age) лет"
        onAgeChanged?(age)
        ageTextField.resignFirstResponder()
    }
    
    @objc private func cancelPressed() {
        ageTextField.resignFirstResponder()
    }
    
    private func calculateAge(from birthDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: birthDate, to: Date())
        return components.year ?? 0
    }
    
}
