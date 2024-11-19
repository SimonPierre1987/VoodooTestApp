//
//  SharePhotoView.swift
//  New Apps Test
//
//  Created by Michel-Andre Chirita on 28/06/2024.
//

/*
 --------------------------------------------------
 -- Voodoo New Apps Tech Test
 -- BOOSTRAP FILE
 -- Feel free to modify or dismiss it as you like !
 --------------------------------------------------
 */

import SwiftUI
import PhotosUI

struct SharePhotoView: View {

    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    let completionAction: (Image) -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text("Share")
                .font(.title)

            Spacer()

            PhotosPicker("Pick a picture", selection: $pickerItem, matching: .images)

            selectedImage?
                .resizable()
                .scaledToFit()
                .padding()

            Spacer()

            Button {
                guard let selectedImage = selectedImage else { return }
                completionAction(selectedImage)
                dismiss()
            } label: {
                Text("Share to friends")
            }
            .buttonStyle(BorderedButtonStyle())
            .padding()
            .disabled(selectedImage == nil)

        }
        .onChange(of: pickerItem) {
            Task {
                selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
            }
        }
    }
}

#Preview {
    SharePhotoView { _ in }
}
