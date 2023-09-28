//
//  ProductTableViewCell.swift
//  SephoraExercice
//
//  Created by Firas on 27/09/2023.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var isSpecialIcon: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    internal func updateView(_ product: ProductViewModel) {
        titleLabel.text = product.name
        descriptionLabel.text = product.description
        priceLabel.text =  "\(product.price) €"
        isSpecialIcon.isHidden = !product.isSpecialBrand
        productImage.imageFromURL(urlString:  product.image)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animate(isHighlighted: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animate(isHighlighted: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animate(isHighlighted: false)
    }
    
    func animate(isHighlighted: Bool, completion: ((Bool) -> Void)?=nil) {
        
        let animationOptions: UIView.AnimationOptions =  [.allowUserInteraction]
        if isHighlighted {
            UIView.animate(withDuration: 0.8,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0,
                           options: animationOptions, animations: {
                self.transform = .init(scaleX: 0.95, y: 0.95)
            }, completion: completion)
        } else {
            UIView.animate(withDuration: 0.8,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0,
                           options: animationOptions, animations: {
                self.transform = .identity
            }, completion: completion)
        }
    }
}
