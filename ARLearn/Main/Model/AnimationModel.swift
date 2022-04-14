//
//  AnimationModel.swift
//  ARLearn
//
//  Created by MERT on 31.10.2021.
//

import Foundation

class AnimationModel {
    
    public var animationName: String = ""
    public var descriptionName: String = ""
    
    init(animationName: String = "", descriptionName: String = "") {
        self.animationName = animationName
        self.descriptionName = descriptionName
    }
}
