//
//  ContentView.swift
//  PracticeProject
//
//  
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userListViewModel : UserListViewModel

    var body: some View {
        NavigationView{
            VStack{
                if(self.userListViewModel.selectedUser != nil)
                {
                    SelectedUserView(user: self.userListViewModel.selectedUser!)
                }
                List(selection: self.$userListViewModel.selectedUser) { 
                    ForEach(Array(userListViewModel.users.enumerated()), id: \.element) { index, item in
                                    UserRowView(user: item)
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
        ContentView().environmentObject(UserListViewModel())
    }
}
