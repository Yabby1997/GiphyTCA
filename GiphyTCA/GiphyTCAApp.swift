//
//  GiphyTCAApp.swift
//  GiphyTCA
//
//  Created by USER on 2022/11/13.
//

import SwiftUI
import ComposableArchitecture
import GiphyDomainLayer
import GiphyDataLayer
import URLRequestDataSourceLayer

@main
struct GiphyTCAApp: App {
    var body: some Scene {
        let networkService = URLRequestBuilderNetworkService()
        let giphyRepository = GiphyRepository(
            apiKey: "rEDEvI1fNspJPNdMNscfdzwLsC3zZRx5",
            networkService: networkService
        )

        let giphyClient = GiphyUseCase(repository: giphyRepository)
        let giphySearchStore = Store(
            initialState: GiphySearchState(),
            reducer: giphySearchReducer,
            environment: GiphySearchEnvironment(giphyClient: giphyClient)
        )

        WindowGroup {
            GiphySearchView(store: giphySearchStore)
        }
    }
}
