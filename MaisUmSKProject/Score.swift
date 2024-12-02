//
//  Score.swift
//  MaisUmSKProject
//
//  Created by Francisco Miranda Soares on 29/11/24.
//

import SwiftUI

class Score: ObservableObject {
    var delegate: ScoreDelegate?
    @Published var scoreP1: Int = 0 { didSet { delegate?.scoreUpdated(score: self) } }
    @Published var scoreP2: Int = 0 { didSet { delegate?.scoreUpdated(score: self) } }

    init(delegate: ScoreDelegate? = nil) {
        self.delegate = delegate
    }
}

protocol ScoreDelegate: AnyObject {
    func scoreUpdated(score: Score)
}
