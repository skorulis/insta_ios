//
//  ContentView.swift
//  InstaOne
//
//  Created by Alexander Skorulis on 23/1/21.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    
    @Published var query: String = ""
    
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
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
