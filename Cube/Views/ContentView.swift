//
//  ContentView.swift
//  Cube
//
//  Created by Alper Karatas on 30/07/2025.
//

import ARKit
import RealityKit
import SwiftUI

struct ContentView: View {
    @State private var sliderValue: Double = 0.0

    var body: some View {
        ZStack {
            ARViewContainer(cubeYPosition: $sliderValue)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                SliderView(sliderValue: $sliderValue)
                    .padding(10)
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    @Binding var cubeYPosition: Double

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)

        // Create a simple cube entity
        let cubeMesh = MeshResource.generateBox(size: 0.1)
        let cubeMaterial = SimpleMaterial(color: UIColor(AppColors.lightBlue), isMetallic: false)
        let cubeEntity = ModelEntity(mesh: cubeMesh, materials: [cubeMaterial])

        // Create anchor and add cube
        let anchor = AnchorEntity(world: [0, 0, -1])
        anchor.addChild(cubeEntity)
        arView.scene.addAnchor(anchor)

        // Store reference to cube entity for position updates
        context.coordinator.cubeEntity = cubeEntity

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        context.coordinator.cubeEntity?.move(
            to: Transform(translation: [0, Float(cubeYPosition), -1]),
            relativeTo: nil,
            duration: 0.2
        )
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator {
        var cubeEntity: ModelEntity?
    }
}

#Preview {
    ContentView()
}
