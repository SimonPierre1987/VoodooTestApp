//
//  UserProfileViewSize.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import Foundation

enum UserProfileViewSize {
    case small
    case medium
    case large
}

extension UserProfileViewSize {
    var width: CGFloat {
        switch self {
        case .small:
            return 40
        case .medium:
            return 64
        case .large:
            return 128
        }
    }

    var height: CGFloat {
        switch self {
        case .small:
            return 40
        case .medium:
            return 64
        case .large:
            return 128
        }
    }
}
