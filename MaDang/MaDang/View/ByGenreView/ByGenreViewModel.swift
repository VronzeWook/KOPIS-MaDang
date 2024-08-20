//
//  ByGenreViewModel.swift
//  MaDang
//
//  Created by 추서연 on 8/20/24.
//


import SwiftUI
import Combine

final class ByGenreViewModel: ObservableObject {
    @Published var performances: [Performance] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchPerformances(for genre: Genre) {
        isLoading = true
        errorMessage = nil
        
        let startDate = getCurrentDateString()
        let endDate = startDate
        
//        KopisNetworkingManager.shared.fetchPerformList(startDate: startDate, endDate: endDate, row: 20, genreCode: genre.code) { [weak self] result in
        KopisNetworkingManager.shared.fetchPerformList(startDate: startDate, endDate: endDate, row: 20) { [weak self] result in
        DispatchQueue.main.async {
                switch result {
                case .success(let performances):
                    self?.performances = performances
                case .failure(let error):
                    self?.errorMessage = self?.mapErrorToMessage(error)
                }
                self?.isLoading = false
            }
        }
    }
    
    private func getCurrentDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter.string(from: Date())
    }
    
    private func mapErrorToMessage(_ error: NetworkError) -> String {
        switch error {
        case .networkingError:
            return "Network error. Please try again later."
        case .dataError:
            return "Data error. Please try again later."
        case .parseError:
            return "Parsing error. Please try again later."
        }
    }
}
