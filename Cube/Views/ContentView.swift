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
            // AR View
            ARViewContainer(cubeYPosition: $sliderValue)
                .edgesIgnoringSafeArea(.all)

            // Custom Slider UI
            VStack {
                Spacer()
                SliderView(sliderValue: $sliderValue)
                    .padding(10)
            }
        }    }
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
        // Update cube Y position
//        context.coordinator.cubeEntity?.position.y = Float(cubeYPosition)
        context.coordinator.cubeEntity?.move(to: Transform(translation: [0, Float(cubeYPosition), -1]),
                                             relativeTo: nil,
                                             duration: 0.2)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator {
        var cubeEntity: ModelEntity?
    }
}

// MARK: - Custom Slider Components

struct SliderTrackView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.gray.opacity(0.3))
            .frame(height: 8)
    }
}

struct TickMarksView: View {
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0 ..< 11, id: \.self) { index in
                Rectangle()
                    .fill(Color.white.opacity(0.5))
                    .frame(width: 1, height: 12)
                if index < 10 {
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 4)
    }
}

struct SliderHandleView: View {
    @Binding var value: Float
    @Binding var cubeYPosition: Float

    private let minValue: Float = -2.0
    private let maxValue: Float = 2.0

    var body: some View {
        Circle()
            .fill(Color.yellow)
            .frame(width: 24, height: 24)
            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
            .offset(x: CGFloat((value - minValue) / (maxValue - minValue) * 200 - 100))
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        let newValue = Float(gesture.location.x / 200) * (maxValue - minValue) + minValue
                        value = max(minValue, min(maxValue, newValue))
                        cubeYPosition = value
                    }
            )
    }
}

struct ValueDisplayView: View {
    let value: Float

    var body: some View {
        HStack {
            Spacer()
            Text(String(format: "%+.1f", value))
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .medium))
            Spacer()
        }
    }
}

struct ResetButtonView: View {
    @Binding var value: Float
    @Binding var cubeYPosition: Float

    var body: some View {
        HStack {
            Spacer()
            Button("Reset") {
                value = 0.0
                cubeYPosition = 0.0
            }
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.gray.opacity(0.5))
            )
        }
    }
}

struct CustomSliderView: View {
    @Binding var value: Float
    @Binding var cubeYPosition: Float

    var body: some View {
        VStack(spacing: 8) {
            // Slider track with ticks
            ZStack {
                SliderTrackView()
                TickMarksView()
                SliderHandleView(value: $value, cubeYPosition: $cubeYPosition)
            }
            .frame(height: 24)

            // Value display
            ValueDisplayView(value: value)

            // Reset button
            ResetButtonView(value: $value, cubeYPosition: $cubeYPosition)
        }
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black.opacity(0.7))
        )
        .onAppear {
            value = 0.0
            cubeYPosition = 0.0
        }
    }
}

#Preview {
    ContentView()
}
