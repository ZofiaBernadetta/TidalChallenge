# Tidal Challenge

## Running the Project

- Select the TidalChallenge scheme.
- Run.

In case you are running on a real device and on the Simulator, you may need to set your personal developer team under the "Signing & Capabilities" tab for the TidalChallenge target.

## About the App

The TidalChallenge app is written in Swift and uses the SwiftUI framework for its UI. Each sub-feature of the app (like the search screen or the tracks list) has been separated into its own group/folder in the project. Any program logic associated with a view has been separated out into an accompanying view model.

While development I focused on modularity of the codebase. You should be able to connect the various sub-features to form a bigger feature, like a entire artist search feature.

The model objects used by the app have been tweaked to better suit the needs of the UI, and therefore aren't a 1:1 match to the Deezer API's json. This means that we have to perform some object mapping in the DeezerClient. If I had more time, I would more thoughtfully consider the trade-offs of this approach and potentially have a 1:1 matching model with some conveniences built on top to better suit our needs.

This project does not use any third party code or libraries.

I spent about 8 hours in total on this project.

