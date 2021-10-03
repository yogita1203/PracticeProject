//
//  SelectedUserView.swift
//  PracticeProject
//
//  Created by Arpita More on 02/10/21.
//

import SwiftUI

struct SelectedUserView: View {
    var user : User
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name : \(user.name)")
                .font(.body)
                .fontWeight(.bold)
            Text("ID : \(user.id)")
                .font(.body)
                .fontWeight(.bold)
        }
    }
}


