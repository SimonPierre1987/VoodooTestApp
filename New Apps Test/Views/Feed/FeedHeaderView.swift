//
//  FeedHeaderView.swift
//  New Apps Test
//
//  Created by Pierre Simon on 21/11/2024.
//

import SwiftUI

struct FeedHeaderView: View {

    @Binding var goToShareAPhoto: Bool

    var body: some View {
        HStack {
            Spacer()
            Button {
                self.goToShareAPhoto = true
            } label: {
                Image(systemName: "plus")
                    .font(.title)
            }
        }
        .padding()
    }
}
