//
//  ContentView.swift
//  MovieDatabase
//
//  Created by Bodgar Jair Espinosa Miranda on 12/04/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MovieDBViewModel()
    var body: some View {
        VStack {
            
        }
        .padding()
        .onAppear {
            viewModel.loadTrending()
        }
    }
}

class MovieDBViewModel: ObservableObject {
    @Published var homeScreen: [TrendingItem] = []
    
    init(){}
    
    func loadTrending() {
        Task {
            
        }
    }
}

struct TrendingItem: Identifiable, Decodable {
    let adult: Bool
    let id: Int
    let poster_path: String
    let title: String
    let vote_average: Float
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
