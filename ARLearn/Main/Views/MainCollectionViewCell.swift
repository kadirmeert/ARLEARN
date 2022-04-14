//
//  MainCollectionViewCell.swift
//  ARLearn
//
//  Created by MERT on 31.10.2021.
//

import Foundation
import UIKit
import Lottie

class MainCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    //MARK: Outlets
    @IBOutlet weak var animationView: AnimationView!
    
    //MARK: Properties
    
    override func awakeFromNib() {
        super .awakeFromNib()
        
    }
    func prepareCell(item: AnimationModel) {
        self.descriptionLabel.text = item.descriptionName
        let path = Bundle.main.path(forResource: item.animationName,
                                    ofType: "json") ?? ""
        animationView.animation = Animation.filepath(path)
        animationView.backgroundColor = .white
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        
        
    }
}
