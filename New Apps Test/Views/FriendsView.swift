//
//  FriendsView.swift
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

struct FriendsView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()

                NavigationLink {
                    // ...
                } label: {
                    Image(systemName: "plus")
                        .font(.title)
                }
            }

            Grid {
                GridRow {
                    Image(.user2)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(.circle)
                    Image(.user3)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(.circle)
                }
                GridRow {
                    Image(.user4)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(.circle)
                }
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    FriendsView()
}
