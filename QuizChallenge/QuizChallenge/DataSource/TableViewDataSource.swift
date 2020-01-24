//
//  TableViewDataSource.swift
//  QuizChallenge
//
//  Created by Rodrigo Pacheco on 24/01/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import UIKit

class TableViewDataSource<CellType, Presenter>: NSObject,
UITableViewDataSource where CellType: UITableViewCell {

    weak var delegate: UITableView?
    private var items: [Presenter] = []
    private let configureCell: (CellType, Presenter) -> Void

    // MARK: - Init
    init(delegate: UITableView? = nil, configureCell: @escaping (CellType, Presenter) -> Void) {
        self.delegate = delegate
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CellType = tableView.dequeueReusableCell(cellForItemAt: indexPath)
        let viewModel = items[indexPath.row]
        configureCell(cell, viewModel)
        return cell
    }

    func updateItems(_ items: [Presenter]) {
        self.items = items
        self.delegate?.reloadData()
    }

    func model(at index: Int) -> Presenter {
        return items[index]
    }
}
