//
//  OnboardingItem.swift
//  SHOPPING-APP
//
//  Created by AKIN on 25.10.2022.
//

import UIKit

struct OnboardingItem {
    let title: String
    let detail: String
    let image: UIImage?
    
    static let items: [OnboardingItem] = [
        .init(title: "HISTORY, PURPOSE AND USAGE",
              detail: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              image: UIImage(named: "onboarding1")),
        .init(title: "HEDONIST ROOTS",
              detail: "Until recently, the prevailing view assumed lorem ipsum was born as a nonsense text. “It's not Latin, though it looks like it, and it actually says nothing,” Before & After magazine answered a curious reader, “Its ‘words’ loosely approximate the frequency with which letters occur in English, which is why at a glance it looks pretty real.”",
              image: UIImage(named: "onboarding2")),
        .init(title: "REMIXING A CLASSIC",
              detail: "So how did the classical Latin become so incoherent? According to McClintock, a 15th century typesetter likely scrambled part of Cicero's De Finibus in order to provide placeholder text to mockup various fonts for a type specimen book.",
              image: UIImage(named: "onboarding3"))
    ]
}
