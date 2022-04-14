//
//  IkeaAppViewController.swift
//  ARLearn
//
//  Created by MERT on 31.10.2021.
//

import Foundation
import UIKit
import RealityKit
import ARKit


class IkeaAppViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var arView: ARView!
    
    //MARK: Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        arView.session.delegate = self
        setUpCustomObjectView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(onTap))
        arView.addGestureRecognizer(tapGesture)
    }
    func setUpCustomObjectView () {
        arView.automaticallyConfigureSession = false
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        configuration.environmentTexturing = .automatic
        arView.session.run(configuration)
    }
    @IBAction func onTap(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: arView)
        let result = arView.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
        if let firstResult = result.first {
            let anchor = ARAnchor(name: "cup_saucer_set", transform: firstResult.worldTransform)
            arView.session.add(anchor: anchor)
        }else {
            print("Object placement failed")
        }
    }
    func placeObject(named entityName: String, for anchor: ARAnchor) {
        let entity = try! ModelEntity.loadModel(named: entityName)
        entity.generateCollisionShapes(recursive: true)
        arView.installGestures([.rotation, .translation], for: entity)
        
        let  anchorEntity = AnchorEntity()
        anchorEntity.addChild(entity)
        arView.scene.addAnchor(anchorEntity)
    }
}
extension IkeaAppViewController: ARSessionDelegate {
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let anchorObject = anchor.name, anchorObject == "cup_saucer_set" {
                placeObject(named: anchorObject, for: anchor)
            }
        }
    }
    
}
