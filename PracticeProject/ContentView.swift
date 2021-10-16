//
//  ContentView.swift
//  PracticeProject
//
//  
//

import SwiftUI

struct ContentView: View {
    @StateObject var userListViewModel = UserListViewModel()

    var body: some View {
        NavigationView{
            VStack{
                if(self.userListViewModel.selectedUser != nil)
                {
                    SelectedUserView(user: self.userListViewModel.selectedUser!)
                }
                List() {
                    ForEach(Array(userListViewModel.users.enumerated()), id: \.element) { index, item in
                        UserRowView(user: item).onTapGesture {
                            userListViewModel.selectedUser = item
                        }
                    }
                }
            }
            .navigationTitle(Text("Users"))
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.secondary)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
