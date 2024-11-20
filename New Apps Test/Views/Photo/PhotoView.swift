//
//  PhotoView.swift
//  New Apps Test
//
//  Created by Pierre Simon on 20/11/2024.
//

import SwiftUI

struct PhotoView: View {
    // MARK: - Services
    let singlePhotoDownloader: SinglePhotoDownloader

    // MARK: - Geometry
    let width: CGFloat
    let height: CGFloat

    // MARK: - States
    @Binding var photo: SharedPhoto
    @State var photoImage: Image? = nil

    var body: some View {
        if let image = self.photoImage {
            image
                .resizable()
                .scaledToFill()
                .frame(width: self.width, height: self.height)
                .clipShape(.rect(cornerRadius: 20))
        } else {
            ProgressView()
                .frame(width: self.width, height: self.height)
                .clipShape(.rect(cornerRadius: 20))
                .task {
                    self.photoImage = await self.singlePhotoDownloader.image(for: self.photo)
                }
        }
    }
}
