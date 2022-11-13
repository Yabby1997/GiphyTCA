//
//  GiphySearchView.swift
//  GiphyTCA
//
//  Created by USER on 2022/11/13.
//

import SwiftUI
import NukeUI
import ComposableArchitecture

struct GiphySearchView: View {

    let store: Store<GiphySearchState, GiphySearchAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack {
                if viewStore.state.isLoading {
                    Color.black.opacity(0.3)
                        .edgesIgnoringSafeArea(.all)
                }
                VStack {
                    HStack {
                        Button("Search") {
                            viewStore.send(.search(query: "spongebob"))
                        }
                        Button("Clear") {
                            viewStore.send(.clear)
                        }
                    }
                    .padding()
                    ScrollView(showsIndicators: true) {
                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: 1),
                                GridItem(.flexible(), spacing: 1),
                                GridItem(.flexible(), spacing: 1),
                            ],
                            spacing: 1
                        ) {
                            ForEach(viewStore.state.giphies, id: \.name) { giphy in
                                LazyImage(url: giphy.originalUrl)
                                    .scaledToFit()
                            }
                        }
                    }
                }
            }
        }
    }
}

//struct GiphySearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        let giphySearchStore = Store(
//            initialState: GiphySearchState(),
//            reducer: giphySearchReducer
//        )
//
//        GiphySearchView(store: giphySearchStore)
//    }
//}
