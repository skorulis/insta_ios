//
//  ContentView.swift
//  InstaOne
//
//  Created by Alexander Skorulis on 23/1/21.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    
    private let api = MainAPI()
    private var subscibers: Set<AnyCancellable> = []
    @Published var users: [InstaUser] = []
    
    @Published var query: String = "" {
        didSet {
            let req = Endpoints.search(query: query)
            api.execute(req).sink { x in
                print("Finished \(x)")
            } receiveValue: { (users) in
                self.users = users
            }.store(in: &subscibers)
        }
    }
    
}

struct UserRow: View {
    
    private let user: InstaUser
    
    init(user: InstaUser) {
        self.user = user
    }
    
    var body: some View  {
        return HStack {
            Text(user.username)
            Text(user.liked).multilineTextAlignment(.trailing)
        }
    }
    
}

struct ContentView: View {
    
    @ObservedObject private var viewModel: ContentViewModel
    
    init() {
        self.viewModel = ContentViewModel()
    }
    
    var body: some View {
        List  {
            Section  {
                SearchBar(text: $viewModel.query)
                ForEach(viewModel.users) { (user) in
                    UserRow(user: user)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
