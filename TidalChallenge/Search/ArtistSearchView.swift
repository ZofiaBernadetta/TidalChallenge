//
//  ContentView.swift
//  TidalChallenge
//
//  Created by Zofia Drabek on 06.04.23.
//

import SwiftUI

struct ArtistSearchView: View {

    @StateObject private var model = ArtistSearchViewModel()

    var body: some View {
        Group {
            if model.failedToLoadArtists {
                EmptyContentView {
                    Image(systemName: "exclamationmark.triangle")
                    Text("Failed to load Artists.")
                }
            } else {
                List {
                    ForEach(model.artists) { artist in
                        NavigationLink {
                            ArtistAlbumsView(artist: artist)
                        } label: {
                            ArtistCellView(artist: artist)
                        }
                    }
                }
                .listStyle(.plain)
                .overlay {
                    if model.artists.isEmpty {
                        if model.isLoading {
                            ProgressView()
                        } else if model.queryString.isEmpty {
                            EmptyContentView {
                                Image(systemName: "magnifyingglass")
                                Text("Search Artists")
                            }
                        } else {
                            EmptyContentView {
                                Text("No results for “\(model.queryString)”.")
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        .navigationTitle("Artists")
        .searchable(
            text: $model.queryString,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search"

        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistSearchView()
    }
}
