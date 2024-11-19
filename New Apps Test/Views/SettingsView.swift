//
//  SettingsView.swift
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

struct SettingsView: View {
    var body: some View {
        Form {
            Section {
                Image(uiImage: UIImage(named: User.mockUser1.photo)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 40)
                    .containerRelativeFrame(.horizontal)
                    .clipShape(.circle)
                HStack {
                    Spacer()
                    Text(User.mockUser1.name)
                        .font(.title)
                    Spacer()
                }
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)

            Section {
                SettingsEntryLine(systemImage: "person", title: "Edit profile")
                SettingsEntryLine(systemImage: "person.slash.fill", title: "Blocked users")
            }

            Section {
                SettingsEntryLine(systemImage: "square.and.arrow.up", title: "Share the app")
                SettingsEntryLine(systemImage: "star.bubble", title: "Rate the app")
                SettingsEntryLine(systemImage: "envelope", title: "Contact us")
            }

            Section {
                SettingsEntryLine(systemImage: "shield", title: "Privacy policy")
                SettingsEntryLine(systemImage: "doc", title: "Terms")
            }

            Section {
                SettingsEntryLine(systemImage: "power", title: "Log out")
                SettingsEntryLine(systemImage: "trash", title: "Delete account")
            }
        }
    }
}

private struct SettingsEntryLine: View {
    
    let systemImage: String
    let title: String

    var body: some View {
        Label(title, systemImage: systemImage)
    }
}

#Preview {
    SettingsView()
}
