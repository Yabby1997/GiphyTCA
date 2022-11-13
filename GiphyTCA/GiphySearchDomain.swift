//
//  GiphySearchStore.swift
//  GiphyTCA
//
//  Created by USER on 2022/11/13.
//

import Foundation
import ComposableArchitecture
import GiphyDomainLayer

struct GiphySearchState: Equatable {
    var giphies: [GiphyEntity] = []
    var isLoading: Bool = false
}

enum GiphySearchAction {
    case search(query: String)
    case searchResult(Result<[GiphyEntity], Never>)
    case clear
}

struct GiphySearchEnvironment {
    let giphyClient: GiphyUseCaseProtocol
}

let giphySearchReducer = AnyReducer<GiphySearchState, GiphySearchAction, GiphySearchEnvironment> { state, action, environment in
    switch action {
    case .search(query: let query):
        state.isLoading = true
        return Effect.task {
            try await environment.giphyClient.search(query: query)
        }
        .catchToEffect()
        .map(GiphySearchAction.searchResult)
    case let .searchResult(.success(entities)):
        state.giphies = entities
        state.isLoading = false
        return .none
    case .clear:
        state.giphies = []
        return .none
    }
}

extension GiphyEntity: Equatable {
    public static func == (lhs: GiphyEntity, rhs: GiphyEntity) -> Bool {
        lhs.originalUrl == rhs.originalUrl
    }
}
