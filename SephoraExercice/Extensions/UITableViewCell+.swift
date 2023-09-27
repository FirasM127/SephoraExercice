//
//  UITableViewCell+.swift
//  SephoraExercice
//
//  Created by Firas on 28/09/2023.
//

import Foundation
import UIKit

extension UITableViewCell {
    // MARK: - Class Properties
    static var identifier: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
