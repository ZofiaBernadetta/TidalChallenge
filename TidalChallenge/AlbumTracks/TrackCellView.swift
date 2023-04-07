//
//  TrackCellView.swift
//  TidalChallenge
//
//  Created by Zofia Drabek on 07.04.23.
//

import SwiftUI

struct TrackCellView: View {
    var track: Track
    var body: some View {
        HStack {
            Text(track.index.formatted())
                .monospacedDigit()
                .foregroundStyle(.secondary)
            VStack(alignment: .leading) {
                Text(track.title)
                Text(track.artist)
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(Duration.seconds(track.duration), format: .time(pattern: .minuteSecond))
                .foregroundStyle(.secondary)
        }
    }
}

struct TrackView_Previews: PreviewProvider {
    static var previews: some View {
        TrackCellView(track: Track(id: 123, index: 1, title: "Title", duration: 123, artist: "Prince"))
    }
}
