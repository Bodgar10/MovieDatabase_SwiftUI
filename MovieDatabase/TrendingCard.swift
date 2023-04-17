//
//  TrendingCard.swift
//  MovieDatabase
//
//  Created by Bodgar Jair Espinosa Miranda on 17/04/23.
//

import SwiftUI

struct TrendingCard: View {
    
    let trendingItem: TrendingItem
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: trendingItem.poster_path.getImageURL()) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 350, height: 240)
            } placeholder: {
                Rectangle().fill(Color(red: 61/255, green: 61/255, blue: 88/255))
                    .frame(width: 340, height: 240)
            }
            
            VStack {
                HStack {
                    Text(trendingItem.title)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
                HStack {
                    Image(systemName: "hand.thumbsup.fill")
                    Text(String(format: "%.1f", trendingItem.vote_average))
                    Spacer()
                }
                .foregroundColor(.yellow)
                .fontWeight(.heavy)
            }
            .padding()
            .frame(width: 350, height: 70)
            .background(Color(red: 61/255, green: 61/255, blue: 88/255))
        }
        .cornerRadius(15)
    }
}

struct TrendingCard_Previews: PreviewProvider {
    static var previews: some View {
        let item = TrendingItem(adult: false, id: 1, poster_path: "", title: "Test movie", vote_average: 5.6)
        TrendingCard(trendingItem: item)
    }
}
