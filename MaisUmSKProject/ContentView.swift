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

    @State var paused = false

    @ObservedObject var score: Score = Score()

    var body: some View {
        makeSpriteView(scene: scene)
            .overlay {
                HUD(score: score, isPaused: $paused)
            }
            .onAppear {
                score.delegate = scene
                // replaces the scene's internal
                // score with this observed one
                scene.score = score
            }
            .ignoresSafeArea()
            .onChange(of: paused) { newValue in
                scene.isPaused = newValue
            }
    }

    func makeSpriteView(scene: SKScene?) -> SpriteView {
        let debugOptions: SpriteView.DebugOptions = [.showsFPS, .showsNodeCount]
        let spritesView = SpriteView(scene: scene ?? SKScene(), isPaused: paused, debugOptions: debugOptions)
        return spritesView
    }
}

#Preview {
    ContentView()
}
