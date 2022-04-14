//
//  ChildHostingController.swift
//  ARLearn
//
//  Created by MERT on 24.11.2021.
//

import Foundation
import ARKit
import RealityKit
import SwiftUI

struct WeatherSwiftUi: View {
    @State var cityName: String = "London"
    @State var isSearchBarVisible:Bool = true
    
    @State var temp:Double = 0
    @State var condition: String = ""
    
    @ObservedObject var weatherManager = WeatherNetworkMenager()
   
    var body: some View {
        
        ZStack {
            
            ARViewDisplay()
            VStack {
                if(isSearchBarVisible) {
                    searchBar(cityName: $cityName)
                        .transition(.scale)
                }
                
                
                Spacer()
                
    //            Text("Temperature: \(temp), Condition: \(condition)")
                
                searchToggle(isSearchToggle: $isSearchBarVisible)
                
            }
            .onChange(of: cityName, perform: { value in
                weatherManager.fetchdata(cityName: cityName)
                
            })
            .onReceive(weatherManager.$recievedWeatherData, perform: {(recievedData) in
                
                temp = recievedData?.temperature ?? 0
                condition = recievedData?.conditionName ?? "Nothing Here"
            })
            
        }
        
        
    }
}

struct WeatherSwiftUi_Previews: PreviewProvider {
    static var previews: some View {
        WeatherSwiftUi()
    }
}
// MARK: - Search stuff

struct searchBar: View{
    @State var searchText: String = ""
    @ Binding var cityName: String
    var body: some View {
        
        HStack{
            
            Image(systemName: "magnifyingglass")
                .font(.system(size: 40))
            TextField( "Search", text: $searchText) {(value) in print("typing in progress") } onCommit: {
                cityName = searchText
            }
        }
        .frame(maxWidth:500)
        .padding(.all)
        .background(Color.black.opacity(0.25))
        
    }
}
struct searchToggle: View{
    @Binding var isSearchToggle: Bool
    var body: some View {
        
        Button(action: {
            withAnimation {
                isSearchToggle = !isSearchToggle
            }
           
            
        }, label: {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 40))
        })
    }
}
// MARK: AR- view

struct ARViewDisplay: View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    typealias UIViewtype = ARView
    
    func makeUIView(context: Context) -> ARView {
        ARViewController.shared.startARsession()
        
        return ARViewController.shared.arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
    
}
class ChildHostingController: UIHostingController<WeatherSwiftUi>, ObservableObject {
    
    static var shared = ARViewController()
    private var weatherModelAnchor: AnchorEntity?
    
    @Published var arView: ARView
    
    init(){
        arView = ARView(frame: .zero)
        super.init(rootView: WeatherSwiftUi())
    }
    
    @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
