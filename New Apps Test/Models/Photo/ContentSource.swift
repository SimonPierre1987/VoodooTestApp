//
//  ContentSource.swift
//  New Apps Test
//
//  Created by Pierre Simon on 20/11/2024.
//

import SwiftUI

enum ContentSource {
    case url(URL)
    case image(Image)
    case embeddedAsset(String)
}

extension ContentSource {
    static func toImageUrlDTO(contentSource: ContentSource) -> ImageUrlDTO {
        switch contentSource {
        case .url(let uRL):
            return ImageUrlDTO(regular: uRL.absoluteString)
        case .image(let image):
            return ImageUrlDTO(regular: "")
        case .embeddedAsset(let string):
            return ImageUrlDTO(regular: "")
        }
    }
}
