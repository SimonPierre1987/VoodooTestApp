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
    var imageUrl: URL? {
        switch self {
        case .url(let url):
            return url
        case .image:
            return nil
        case .embeddedAsset:
            return nil
        }
    }

    var image: Image? {
        switch self {
        case .url:
            return nil
        case .image(let image):
            return image
        case .embeddedAsset(let string):
            return Image(string)
        }
    }
}

extension ContentSource {
    static func toImageUrlDTO(contentSource: ContentSource) -> ImageUrlDTO {
        switch contentSource {
        case .url(let url):
            return ImageUrlDTO(regular: url.absoluteString)
        case .image:
            return ImageUrlDTO(regular: "")
        case .embeddedAsset:
            return ImageUrlDTO(regular: "")
        }
    }
}
