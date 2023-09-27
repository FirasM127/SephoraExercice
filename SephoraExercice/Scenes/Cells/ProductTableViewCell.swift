//
//  ProductTableViewCell.swift
//  SephoraExercice
//
//  Created by Firas on 27/09/2023.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet private weak var productName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    internal func updateView(_ product: ProductViewModel) {
        productName.text = product.name
    }
}
