//
//  ApplicationsViewController.swift
//  ARLearn
//
//  Created by MERT on 23.11.2021.
//

import UIKit

class ApplicationsViewController: UIViewController {
    
    @IBOutlet weak var weatherVıew: UIView!
    @IBOutlet weak var placıngItemsVıew: UIView!
    @IBOutlet weak var gameVıew: UIView!
    @IBOutlet weak var navıgatıonVıew: UIView!
    
    @IBOutlet weak var weatherImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        weatherVıew.layer.cornerRadius = 12
        weatherImage.layer.cornerRadius = 12
        weatherVıew.addShadow(radius: 10)
        placıngItemsVıew.layer.cornerRadius = 12
        placıngItemsVıew.addShadow(radius: 10)
        gameVıew.layer.cornerRadius = 12
        gameVıew.addShadow(radius: 10)
        navıgatıonVıew.layer.cornerRadius = 12
        navıgatıonVıew.addShadow(radius: 10)
    }
    @IBAction func weatherButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "showWeatherApp", sender: self)
    }
    @IBAction func placıngButtonPresssed(_ sender: Any) {
        self.performSegue(withIdentifier: "showIkeaApp" , sender: self)
    }
    @IBAction func gameButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "showGameApp", sender: self)
    }
    
    @IBAction func navıgatıonButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "showNavigationApp", sender: self)
    }
    
}
