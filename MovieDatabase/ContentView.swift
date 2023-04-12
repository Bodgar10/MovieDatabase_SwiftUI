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

@MainActor
class MovieDBViewModel: ObservableObject {
    @Published var trending: [TrendingItem] = []
    static let apiKey = "fd7c94cdd8ba3bf4a5d9f472cd23f345"
    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmZDdjOTRjZGQ4YmEzYmY0YTVkOWY0NzJjZDIzZjM0NSIsInN1YiI6IjYwOTA2NTE1Y2FhYjZkMDA0MDhkY2JhZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.urS4iLEhBOKN-LM7ejqJzNAvRCRyN0whglWgLZ4--ls"
    
    init(){}
    
    func loadTrending() {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/movie/550?api_key=\(MovieDBViewModel.apiKey)")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                trending = trendingResults.results
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct TrendingResults: Decodable {
    let page: Int
    let results: [TrendingItem]
    let total_pages: Int
    let total_results: Int
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
