//
//  ProductViewModel.swift
//  SHOPPING-APP
//
//  Created by AKIN on 30.10.2022.
//

import Foundation

enum ProductViewModel: Int, CaseIterable {
    case description
    
    var description: String {
        switch self {
        case .description: return "Nylon fabric. Recycled fabric. Windbreaker type. Cropped design. Straight design. Gathered details. Turtleneck. Long sleeve. Zip fastening on the front section. Inner lining.The garments labelled as Committed are products that have been produced using sustainable fibers or processes, reducing their environmental impact. Mango's goal is to support the implementation of practices more committed to the environment, and therefore increase the number of sustainable garments in the collection."
        }
    }
    
    var iconImageName: String {
        switch self {
        case .description: return "text.quote"
        }
    }
}

