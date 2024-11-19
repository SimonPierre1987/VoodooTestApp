//
//  UserProfileView.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import Foundation
import SwiftUI

struct UserProfileView: View {
    let user: UserEntity

    var body: some View {
        VStack {
            UserProfilePictureView(user: self.user, profileSize: .large)
        }
    }
}
