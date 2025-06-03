//
//  UserListViewController.swift
//  SwiftUICells
//
//  Created by Aleksandr on 03.06.2025.
//

import UIKit
import SwiftUI

class UserListViewController: UIViewController {
    
    private var users = [User(name: "Alex", isPremium: true), User(name: "Tom", isPremium: false), User(name: "Nick", isPremium: true)]
    
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserTableViewCell")
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        
        [tableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func refreshAction() {
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    }
    
    @objc private func reloadData() {
        tableView.reloadData()
        refreshControl.endRefreshing()
        
    }
    
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bindingUser = Binding(
            get: { self.users[indexPath.row] },
            set: {
                self.users[indexPath.row] = $0
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        )
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        cell.update(with: bindingUser)
        return cell
    }
}
