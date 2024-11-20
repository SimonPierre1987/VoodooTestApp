//
//  FullSizePhotoView.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import SwiftUI

struct FullSizePhotoView: View {
    @Environment(\.dismiss) var dismiss

    @Binding var photoToDisplayFullScreen: PhotoEntity?

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                AsyncImage(
                    url: self.photoToDisplayFullScreen?.contentSource.imageUrl,
                    content: { image in  image.resizable().aspectRatio(contentMode: .fit) },
                    placeholder: { ProgressView().progressViewStyle(.circular) })
                Spacer()
            }
        }
        .background(Color.black)
        .ignoresSafeArea()
        .onTapGesture {
            withAnimation {
                self.dismiss()
            }
        }
    }
}
