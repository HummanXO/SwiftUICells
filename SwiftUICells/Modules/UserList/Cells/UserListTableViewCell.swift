//
//  UserListTableViewCell.swift
//  SwiftUICells
//
//  Created by Aleksandr on 03.06.2025.
//

import UIKit
import SwiftUI

class UserListTableViewCell: UITableViewCell {
    
    private var host: UIHostingController<SwiftUIView>?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with observableObject: User) {
        if let host = host {
            host.rootView = SwiftUIView(user: observableObject)
        } else {
            let controller = UIHostingController(rootView: SwiftUIView(user: observableObject))
            controller.view.backgroundColor = .clear
            host = controller
            
            contentView.addSubview(controller.view)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                controller.view.topAnchor.constraint(equalTo: contentView.topAnchor),
                controller.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                controller.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                controller.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }
    }
    
}
