//
//  Sequence.swift
//  TechChallenge
//
//  Created by Dom Bryan on 01/06/2022.
//

import Foundation

extension Sequence {
    func indexed() -> Array<(offset: Int, element: Element)> {
        Array(enumerated())
    }
}
