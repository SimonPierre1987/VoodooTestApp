//
//  UserBioView.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import SwiftUI

struct UserBioView: View {
    let bio: String?
    var body: some View {
        Text(self.bio ?? "")
            .font(.caption2)
            .opacity(self.bio == nil ? 0 : 1)
            .padding(
                EdgeInsets(top: 0, leading: UserLayoutConstant.margin,
                           bottom: 0,
                           trailing: UserLayoutConstant.margin
                          )
            )
    }
}
