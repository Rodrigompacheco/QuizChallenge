//
//  NSObjectExtension.swift
//  QuizChallenge
//
//  Created by Rodrigo Pacheco on 24/01/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import Foundation

extension NSObject {    
    static var className: String {
        return String(describing: self)
    }
}
