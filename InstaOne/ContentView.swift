//
//  ContentView.swift
//  InstaOne
//
//  Created by Alexander Skorulis on 23/1/21.
//

import SwiftUI
import Combine
import SwiftRex
import CombineRex

class SearchViewModel: ObservableObject {
    
    var projection: ObservableViewModel<ViewAction, ViewState>
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
                self.projection.dispatch(.gotUsers(users))
            }.store(in: &subscibers)
        }
    }
    
    init(store: AppStore) {
        self.projection = store.projection(action: SearchViewModel.transform(viewAction:), state: SearchViewModel.transform(appState:))
            .asObservableViewModel(initialState: .empty, emitsValue: .always)
    }
    
    struct ViewState {
        let users: [InstaUser]
        
        static var empty: ViewState {
            return ViewState(users: [])
        }
    }
    
    enum ViewAction {
        case gotUsers([InstaUser])
    }
    
    private static func transform(viewAction: ViewAction) -> AppAction? {
        switch viewAction {
        case .gotUsers(let users): return .storeUsers(user: users)
        }
    }
    
    private static func transform(appState: AppState) -> ViewState {
        ViewState(users: appState.users)
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
    
    @ObservedObject private var viewModel: SearchViewModel
    
    init(store: AppStore) {
        self.viewModel = SearchViewModel(store: store)
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
        let store = AppStore()
        
        ContentView(store: store)
    }
}
