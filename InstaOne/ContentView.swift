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
import ComposableArchitecture

class SearchViewModel: ObservableObject {
    
    var projection: ObservableViewModel<ViewAction, ViewState>
    private let api = MainAPI()
    private var subscibers: Set<AnyCancellable> = []
    
    @Published var query: String = "" {
        didSet {
            self.projection.dispatch(.search(query))
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
        case search(String)
    }
    
    private static func transform(viewAction: ViewAction) -> AppAction? {
        switch viewAction {
        case .search(let query): return .getUsers(query)
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
    @ObservedObject private var reduxProjection: ObservableViewModel<SearchViewModel.ViewAction, SearchViewModel.ViewState>
    
    init(store: AppStore) {
        let vm = SearchViewModel(store: store)
        self.viewModel = vm
        reduxProjection = vm.projection;
    }
    
    var body: some View {
        List  {
            Section  {
                SearchBar(text: $viewModel.query)
                ForEach(reduxProjection.state.users) { (user) in
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
