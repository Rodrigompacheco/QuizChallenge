//
//  UITableViewExtension.swift
//  QuizChallenge
//
//  Created by Rodrigo Pacheco on 24/01/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    func register<T: UITableViewCell>(of type: T.Type) {
        let nib = UINib(nibName: T.identifier, bundle: nil)
        register(nib, forCellReuseIdentifier: T.identifier)
    }

    
    func dequeueReusableCell<T: UITableViewCell>(cellForItemAt indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath)
        guard let resultCell = cell as? T else {
            fatalError("Couldn't load cell with \(T.identifier) identifier")
        }
        return resultCell
    }
}

