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
    
    private let currentUser = UserEntity.currentUser

    // MARK: - State
    @State var selectedUser: UserEntity?

    // MARK: - Navigation
    @State private var navigationPath = NavigationPath()

    // MARK: - Services
    private let singlePhotoDownloader = SinglePhotoDownloader()

    var body: some View {
        NavigationStack(path: self.$navigationPath) {
            Form {
                Section {
                    UserProfilePictureView(user: self.currentUser, profileSize: .large, selectedUser: self.$selectedUser)
                        .padding(.horizontal, 40)
                        .containerRelativeFrame(.horizontal)
                    HStack {
                        Spacer()
                        Text(self.currentUser.firstName)
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
            .navigationDestination(for: UserEntity.self) { user in
                UserProfileView(user: user, singlePhotoDownloader: self.singlePhotoDownloader)
            }
            .onChange(of: self.selectedUser, { _, _ in
                self.navigateTo(selectedUser: self.selectedUser)
            })
        }
    }
}

// MARK: - Navigation
private extension SettingsView {
    private func navigateTo(selectedUser: UserEntity?) {
        guard let selectedUser else { return }
        self.navigationPath.append(selectedUser)
        self.selectedUser = nil
    }
}

private struct SettingsEntryLine: View {
    
    let systemImage: String
    let title: String

    var body: some View {
        Label(self.title, systemImage: self.systemImage)
    }
}

#Preview {
    SettingsView()
}
