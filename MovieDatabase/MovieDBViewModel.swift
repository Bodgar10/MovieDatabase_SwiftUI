//
//  MovieDBViewModel.swift
//  MovieDatabase
//
//  Created by Bodgar Jair Espinosa Miranda on 17/04/23.
//

import Foundation

@MainActor
class MovieDBViewModel: ObservableObject {
    
    @Published var trending: [TrendingItem] = []
    @Published var searchResults: [TrendingItem] = []
    
    static let apiKey = "fd7c94cdd8ba3bf4a5d9f472cd23f345"
    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmZDdjOTRjZGQ4YmEzYmY0YTVkOWY0NzJjZDIzZjM0NSIsInN1YiI6IjYwOTA2NTE1Y2FhYjZkMDA0MDhkY2JhZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.urS4iLEhBOKN-LM7ejqJzNAvRCRyN0whglWgLZ4--ls"
    
    init(){}
    
    func loadTrending() {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(MovieDBViewModel.apiKey)")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                trending = trendingResults.results
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func search(term: String) {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(MovieDBViewModel.apiKey)&language=en-US&page=1&include_adult_false&query\(term)")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                searchResults = trendingResults.results
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

extension String {
    func getImageURL() -> URL {
        return URL(string: "https://image.tmdb.org/t/p/w500/\(self)")!
    }
}
