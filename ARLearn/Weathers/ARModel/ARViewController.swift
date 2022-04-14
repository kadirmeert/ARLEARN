//
//  ARViewController.swift
//  ARLearn
//
//  Created by MERT on 28.11.2021.
//

import Foundation
import ARKit
import RealityKit
import SwiftUI


class ARViewController: ObservableObject {
    
    static var shared = ARViewController()
    private var weatherModelAnchor: AnchorEntity?
    
    @Published var arView: ARView
    
    init(){
        arView = ARView(frame: .zero)
    }
    public func startARsession() {
        
        startPlanedetection()
        startTapDetection()
    }
    
    private func startPlanedetection() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        configuration.environmentTexturing = .automatic
        
        arView.session.run(configuration)
    }
    private func startTapDetection() {
        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:))))
    }
    @objc private func handleTap(recognizer: UITapGestureRecognizer) {
        // Touch Location
        let tapLocation = recognizer.location(in: arView)
        let results = arView.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
        
        if let firstResult = results.first {
            let worldPosition = simd_make_float3(firstResult.worldTransform.columns.3)
            
            
            let mesh = MeshResource.generateSphere(radius: 0.03)
            let material = SimpleMaterial(color: .black, isMetallic: true)
            let model = ModelEntity(mesh: mesh, materials: [material])
            
            placeObject(object: model, at: worldPosition)
            
//            if(isWeatherObjectPlaced == false) {
//
//                let weatherBall = weatherModelGenerator.generateWeatherARModel(condition: receivedWeatherData.contionName, temperature: receivedWeatherData.temperature)
//
//                placeObject(object: weatherBall, at: worldPosition)
//
//                isWeatherObjectPlaced = true
//            }
        }
        
    }
    private func placeObject(object modelEntity: ModelEntity, at position: SIMD3<Float>) {
        
        weatherModelAnchor = AnchorEntity(world: position)
        
        weatherModelAnchor!.addChild(modelEntity)
        arView.scene.addAnchor(weatherModelAnchor!)
    }
    
}
