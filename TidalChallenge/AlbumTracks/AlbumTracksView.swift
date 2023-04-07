//
//  AlbumTracksView.swift
//  TidalChallenge
//
//  Created by Zofia Drabek on 07.04.23.
//

import SwiftUI

struct AlbumTracksView: View {
    var album: AlbumTracks

    var body: some View {
        List {
            Section {
                AsyncImage(url: album.coverURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .aspectRatio(1, contentMode: .fit)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.gray, lineWidth: 0.1)
                        )
                        .shadow(radius: 15)
                        .padding(30)
                } placeholder: {
                    ZStack {
                        Color(.clear)
                        ProgressView()
                    }
                }
                VStack(alignment: .center) {
                    Text(album.title)
                        .font(.headline)
                    Text(album.artist)
                        .font(.subheadline)
                }
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            }
            .listRowBackground(Color.clear)
            .listRowInsets(.init())
            .listRowSeparator(.hidden)


            Section {
                ForEach(album.tracks) {
                    TrackCellView(track: $0)
                }
            }
        }
        .navigationTitle(album.title)
    }
}

struct AlbumTracksView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumTracksView(
            album: AlbumTracks(
                id: 123,
                title: "RETURN",
                coverURL: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/fccc34e10bfd8fbe4014c83acf2e3b15/250x250-000000-80-0-0.jpg")!,
                artist: "Ed Sheeran",
                tracks: [Track(id: 1, index: 1, title: "Million $ SHow", duration: 160, artist: "Prince")]
            )
        )
    }
}
