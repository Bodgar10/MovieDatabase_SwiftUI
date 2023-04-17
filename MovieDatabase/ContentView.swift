//
//  ContentView.swift
//  MovieDatabase
//
//  Created by Bodgar Jair Espinosa Miranda on 12/04/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MovieDBViewModel()
    @State var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    Text("Trending")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                    Spacer()
                }.padding(.horizontal)
                
                if searchText.isEmpty {
                    if viewModel.trending.isEmpty {
                        Text("No Results")
                    } else {
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.trending) { trendingItem in
                                    TrendingCard(trendingItem: trendingItem)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }else {
                    ForEach(viewModel.searchResults) { trendingItem in
                        Text(trendingItem.title)
                    }
                }
            }
            .background(Color(red: 39/255, green: 40/255, blue: 59/255).ignoresSafeArea())
        }
        .searchable(text: $searchText)
        .onChange(of: searchText, perform: { newValue in
            if newValue.count > 0 {
                viewModel.search(term: newValue)
            }
        })
        .onAppear {
            viewModel.loadTrending()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
