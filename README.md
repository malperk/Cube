# Cube AR Application

An iOS Augmented Reality application that displays a cube in the real world with a custom UI slider to control its vertical position.

## Features

- **AR Cube Display**: Shows a blue cube in the real world using ARKit and RealityKit
- **Custom Slider UI**: Implements the exact design specification from the design
- **Real-time Position Control**: Adjust the cube's Y-axis position in real-time using the slider
- **Reset Functionality**: Reset the cube position to center with the Reset button

## Technical Implementation

### AR Components
- Uses `ARKit` and `RealityKit` for AR scene management
- Creates a 3D cube entity with blue material
- Positions the cube at a fixed distance from the camera

### UI Components
- **Custom Slider**: Matches the design specification with:
  - Position indicator icon (four-directional arrows)
  - "POSITION" label
  - Tick marks on the slider track
  - Yellow circular handle
  - Real-time value display
  - Reset button

### Architecture
- Built with SwiftUI for all UI elements
- Uses `UIViewRepresentable` to integrate ARKit's `ARView`
- State management with `@State` and `@Binding` properties

## Requirements

- iOS 14.0+
- Xcode 12.0+
- Device with ARKit support (iPhone 6s or later)

## Setup

1. Open the project in Xcode
2. Build and run on a physical device (AR features require camera access)
3. Grant camera permissions when prompted
4. Use the slider at the bottom of the screen to control the cube's vertical position

Video: https://streamable.com/iv265o