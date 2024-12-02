//
//  HUD.swift
//  MaisUmSKProject
//
//  Created by Francisco Miranda Soares on 02/12/24.
//

import SwiftUI

struct HUD: View {

    @ObservedObject var score: Score

    var body: some View {
        VStack {
            HStack {
                Text("\(score.scoreP1)")
                Spacer()
                Text("X")
                Spacer()
                Text("\(score.scoreP2)")
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding()
            Spacer()
//                Text("\(score.scoreP1) X \(score.scoreP2)")
        }
    }
}
