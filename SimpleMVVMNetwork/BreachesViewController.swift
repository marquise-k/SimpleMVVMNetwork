//
//  ViewController.swift
//  SimpleMVVMExample
//
//  Created by Steven Curtis on 03/08/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class BreachesViewController: UIViewController {
    
    var tableView = UITableView()
    
    var data = [BreachModel]()
    
    var breachesViewModel = BreachViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
        
        
        breachesViewModel.fetchBreaches{ [weak self] breaches in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
    }
    
    func updateUI() {
        tableView.reloadData()
    }
}

extension BreachesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breachesViewModel.breaches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cellData = breachesViewModel.breaches[indexPath.row]
        cell.textLabel?.text = cellData.title
        
        return cell
    }
}

extension BreachesViewController: UITableViewDelegate { }

