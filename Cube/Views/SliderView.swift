//
//  SliderView.swift
//  Cube
//
//  Created by Alper Karatas on 30/07/2025.
//

import SwiftUI

struct SliderView: View {
    @Binding var sliderValue: Double

    var body: some View {
        GeometryReader { geo in
            ZStack {
                AppColors.darkBlue
                    .cornerRadius(geo.size.height / 2)
                HStack(spacing: 10) {
                    PositionView()
                    CustomSlider(value: $sliderValue, range: -2...2)
                    Button(action: {
                        sliderValue = 0
                    }) {
                        Text("Reset")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .fill(AppColors.lightBlue)
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(10)
            }
        }.frame(height: 80)
    }
}

// MARK: - Custom Slider Components

struct PositionView: View {
    var body: some View {
        HStack {
            Image(systemName: "arrow.up.and.down.and.arrow.left.and.right")
                .foregroundColor(AppColors.darkYellow)
                .font(.system(size: 12))
                .padding(8)
                .background(
                    ZStack {
                        Circle()
                            .fill(AppColors.lightBlue)
                        Circle()
                            .stroke(AppColors.darkYellow, lineWidth: 1)
                    }
                )
            Text("POSITION")
                .foregroundColor(.white)
                .font(.system(size: 10, weight: .semibold))
        }
    }
}

struct CustomSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    var width: CGFloat = 180

    var body: some View {
        VStack(spacing: 2) {
            Text(String(format: "%+.1f", value))
                .foregroundColor(AppColors.darkYellow)
                .font(.system(size: 10, weight: .bold))

            ZStack(alignment: .leading) {
                Capsule()
                    .fill(AppColors.lightBlue)
                    .frame(width: width, height: 8)

                Circle()
                    .fill(AppColors.darkYellow)
                    .frame(width: 14, height: 14)
                    .overlay(
                        Circle()
                            .stroke(AppColors.lightYellow, lineWidth: 2)
                    )
                    .offset(x: thumbOffset(width: width))
                    .gesture(
                        DragGesture().onChanged { gesture in
                            let newValue = range.lowerBound +
                                Double(gesture.location.x / width) * (range.upperBound - range.lowerBound)
                            value = min(max(newValue, range.lowerBound), range.upperBound)
                        }
                    )
                VStack {
                    HStack {
                        ForEach(0 ..< 13) { i in
                            Spacer(minLength: 0)
                            Rectangle()
                                .fill(AppColors.lightBlue)
                                .frame(width: 2, height: 12)
                            Spacer(minLength: 0)
                        }
                    }
                    .frame(width: width)
                    Spacer().frame(height: 22)
                }
            }
        }
    }

    private func normalizedValue() -> Double {
        (value - range.lowerBound) / (range.upperBound - range.lowerBound)
    }

    private func thumbOffset(width: CGFloat) -> CGFloat {
        CGFloat(normalizedValue()) * (width - 28)
    }
}

struct ContentView1: View {
    @State private var sliderValue: Double = 0

    var body: some View {
        CustomSlider(value: $sliderValue, range: -10...10)
    }
}

#Preview {
    VStack {
        SliderView3()
    }
}

struct SliderView3: View {
    @State var sliderValue: Double = 0

    var body: some View {
        VStack {
            SliderView(sliderValue: $sliderValue)
        }
    }
}
