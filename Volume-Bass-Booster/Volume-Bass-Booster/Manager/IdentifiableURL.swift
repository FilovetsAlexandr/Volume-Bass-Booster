//
//  IdentifiableURL.swift
//  Volume-Bass-Booster
//
//  Created by Alexandr Filovets on 3.08.24.
//

import Foundation

struct IdentifiableURL: Identifiable {
    let id = UUID()
    let url: URL
}
