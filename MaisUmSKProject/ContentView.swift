//
//  ContentView.swift
//  MaisUmSKProject
//
//  Created by Francisco Miranda Soares on 29/11/24.
//

import SwiftUI
import SpriteKit

struct ContentView: View {

    var scene: GameScene = {
        guard let scene = GameScene(fileNamed: "GameScene") else {
            fatalError("Could not load scene 'GameScene' from .sks file.")
        }
        scene.scaleMode = .aspectFill
        return scene
    }()

    @ObservedObject var score: Score = Score()

    var body: some View {
        SpriteView(scene: scene)
            .overlay {
                HUD(score: score)
            }
            .onAppear {
                score.delegate = scene
                // replaces the scene's internal
                // score with this observed one
                scene.score = score
            }
    }
}

#Preview {
    ContentView()
}
