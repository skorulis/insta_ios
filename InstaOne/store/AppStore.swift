//
//  AppStore.swift
//  InstaOne
//
//  Created by Alexander Skorulis on 23/1/21.
//

import Foundation
import CombineRex
import SwiftRex

struct AppState {
    var users: [InstaUser] = []
}

enum AppAction {
    case storeUsers(user: [InstaUser])
}

class AppStore: ReduxStoreBase<AppAction, AppState> {
    
    init() {
        super.init(
            subject: .combine(initialValue: AppState()),
            reducer: AppStore.mainReducer,
            middleware: IdentityMiddleware()
        )
    }
    
    private static var mainReducer: Reducer<AppAction, AppState> {
        let reducer = Reducer<AppAction, AppState> { action, state in
            var tmpState = state
            switch action {
            case .storeUsers(let users):
                tmpState.users =  users
                return tmpState
            }
        }
        return reducer
    }
    
}
