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

struct ContentView: View {
    
    let store: AppStore
    
    init(store: AppStore) {
        self.store = store;
    }
    
    var body: some View {
        return TabView {
            UserSearchView(store: store)
                .tabItem {
                    Text("Search")
                }
            BadFollowingView(store: store)
                .tabItem {
                    Text("Bad followers")
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
