//
//  AppStoreComp.swift
//  InstaOne
//
//  Created by Alexander Skorulis on 23/1/21.
//

import Foundation
import ComposableArchitecture

struct AppEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

/*struct StoreHelpers {
    
    static var appReducer: Reducer<AppState, AppAction, AppEnvironment> {
        Reducer<AppState, AppAction, AppEnvironment> {
          state, action, environment in
          switch action {
          case .storeUsers(let users):
            state.users = users
            return .none
          }
        }
    }
    
    static func makeStore() -> Store<AppState, AppAction> {
        let env = AppEnvironment(mainQueue: DispatchQueue.main.eraseToAnyScheduler())
        let store = Store(initialState: AppState(), reducer: appReducer, environment: env)
        return store
    }
    
}*/
