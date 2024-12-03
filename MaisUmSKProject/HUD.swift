//
//  HUD.swift
//  MaisUmSKProject
//
//  Created by Francisco Miranda Soares on 02/12/24.
//

import SwiftUI

struct HUD: View {

    @ObservedObject var score: Score
    @Binding var isPaused: Bool

    var body: some View {
        if isPaused {
            pausedHUD
        } else {
            runningHUD
        }
    }

    var pausedHUD: some View {
        VStack(spacing: 48) {
            Text("Paused!")
                .font(.title)
                .padding(.horizontal, 48)
            Button(action: {
                isPaused.toggle()
            }) {
                Text("Resume")
                    .foregroundStyle(.black)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.yellow)
                            .border(.white, width: 2)
                    }
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(.blue)
                .border(.white, width: 2)
        }
    }

    var runningHUD: some View {
        VStack {
            ZStack {
                HStack {
                    drawBalls(for: score.scoreP1)
                    Spacer()
                    drawBalls(for: score.scoreP2)
                }
                .foregroundStyle(.red)
                .frame(maxWidth: .infinity)
                .frame(minHeight: 48)
                .padding(48)
                Text("X")
                    .frame(maxWidth: .infinity)
            }
            .foregroundStyle(.white)
            Spacer()
            Button("Pause", systemImage: "pause.circle.fill") {
                isPaused.toggle()
            }
            .padding(.bottom, 48)
        }
    }

    private func drawBalls(for score: Int) -> some View {
        ForEach(0..<10) { scoreNumber in
            let show = scoreNumber < score
            if show {
                Image(systemName: "tennisball.fill")
            }
        }
    }
}

#Preview {
    ContentView()
}
