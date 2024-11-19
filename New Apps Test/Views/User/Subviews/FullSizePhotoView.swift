//
//  FullSizePhotoView.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import SwiftUI

struct FullSizePhotoView: View {
    let image: Image

    @Binding var photoToDisplayFullScreen: Image?

    var body: some View {
        image
            .resizable()
            .scaledToFill()
            .background(Color.white)
            .onTapGesture {
                withAnimation {
                    self.photoToDisplayFullScreen = nil
                }
            }
    }
}
