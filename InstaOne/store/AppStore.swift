//
//  AppStore.swift
//  InstaOne
//
//  Created by Alexander Skorulis on 23/1/21.
//

import Foundation
import CombineRex
import SwiftRex
import Combine

struct AppState {
    var users: [UserDetails] = []
}

enum AppAction {
    case storeUsers(user: [UserDetails])
    case getUsers(String)
    case gotError(Error)
}

class AppStore: ReduxStoreBase<AppAction, AppState> {
    
    init() {
        let userMiddleware = AppStore.getUsersMiddleware.inject(MainAPI())
        
        super.init(
            subject: .combine(initialValue: AppState()),
            reducer: AppStore.mainReducer,
            middleware: userMiddleware
        )
    }
    
    private static var mainReducer: Reducer<AppAction, AppState> {
        let reducer = Reducer<AppAction, AppState> { action, state in
            var tmpState = state
            switch action {
            case .storeUsers(let users):
                tmpState.users =  users
                return tmpState
            case .getUsers(_):
                return tmpState
            case .gotError(_):
                return tmpState
            }
        }
        return reducer
    }
    
    static let getUsersMiddleware = EffectMiddleware<AppAction, AppAction, AppState, MainAPI>.onAction { incomingAction, dispatcher, getState in
        switch incomingAction {
        case .getUsers(let query):
            return Effect(token: "get users \(query)") { (context) -> AnyPublisher<DispatchedAction<AppAction>, Never> in
                let api  = context.dependencies
                let req =  Endpoints.search(query: query)
                
                let result: AnyPublisher<DispatchedAction<AppAction>, Never> = api.execute(req)
                    .map { DispatchedAction( AppAction.storeUsers(user: $0)) }
                    .catch { error -> AnyPublisher<DispatchedAction<AppAction>, Never> in
                        let action = DispatchedAction(AppAction.gotError(error))
                        return Just(action).eraseToAnyPublisher()
                    }
                    .eraseToAnyPublisher()
                return result
            }
        default:
            return .doNothing
        }
    }
    
}
