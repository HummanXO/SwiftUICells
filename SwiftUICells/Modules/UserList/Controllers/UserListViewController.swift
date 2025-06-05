//
//  UserListViewController.swift
//  SwiftUICells
//
//  Created by Aleksandr on 03.06.2025.
//

import UIKit
import SwiftUI

class UserListViewController: UIViewController {
    
    private let viewModel = UserListViewModel()
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await loadUsers()
        }
        viewModel.onDataChange = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        setupUI()
        
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UserListTableViewCell.self, forCellReuseIdentifier: "UserListTableViewCell")
        
        [tableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    private func loadUsers() async {
        await viewModel.fetchUsers()
    }

}

extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell", for: indexPath) as! UserListTableViewCell
        cell.update(with: self.viewModel.users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let host = UIHostingController(rootView: DeteiledCellSwiftUIView(user: self.viewModel.users[indexPath.row], onSave: {
            self.navigationController?.popViewController(animated: true)
        }))
        navigationController?.pushViewController(host, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
