//
//  UserNameView.swift
//  New Apps Test
//
//  Created by Pierre Simon on 19/11/2024.
//

import SwiftUI

struct UserNameView: View {
    let firstName: String
    let lastName: String?

    var body: some View {
        Text(self.firstName + " " + (self.lastName ?? ""))
            .font(.title)
            .padding(
                EdgeInsets(top: 0, 
                           leading: UserLayoutConstant.margin,
                           bottom: 0,
                           trailing: UserLayoutConstant.margin
                          )
            )
    }
}
