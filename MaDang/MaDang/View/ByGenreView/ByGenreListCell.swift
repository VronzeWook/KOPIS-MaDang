//
//  ByGenreListCell.swift
//  MaDang
//
//  Created by 추서연 on 8/20/24.
//

import SwiftUI

struct ByGenreListCell: View {
    @State private var selectedGenre: Genre = .All
    @State private var performances: [Performance] = []
    @State private var isLoading = false
    @State private var error: String? = nil

    private let genres: [Genre] = Genre.allCases

    var body: some View {
        NavigationView {
            VStack {
                Picker("Select Genre", selection: $selectedGenre) {
                    ForEach(genres, id: \.self) { genre in
                        Text(genre.rawValue).tag(genre)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                if isLoading {
                    ProgressView()
                } else if let error = error {
                    Text("Error: \(error)").foregroundColor(.red)
                } else {
                    List(performances, id: \.id) { performance in
                        VStack(alignment: .leading) {
                            Text(performance.title)
                                .font(.headline)
                            Text("Location: \(performance.area)")
                                .font(.subheadline)
                            Text("Dates: \(performance.startDate, formatter: dateFormatter) to \(performance.endDate, formatter: dateFormatter)")
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Performances")
            .onChange(of: selectedGenre) { _ in
                fetchPerformances()
            }
            .onAppear {
                fetchPerformances()
            }
        }
    }

    private func fetchPerformances() {
        isLoading = true
        error = nil

        let startDate = "2024-08-01"
        let endDate = "2024-08-01"

        KopisNetworkingManager.shared.fetchPerformList(startDate: startDate, endDate: endDate, row: 10) { result in
//        KopisNetworkingManager.shared.fetchPerformList(startDate: startDate, endDate: endDate, row: 10, genreCode: selectedGenre.code) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedPerformances):
                    self.performances = fetchedPerformances
                case .failure(let networkError):
                    self.error = networkError.localizedDescription
                }
                self.isLoading = false
            }
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()

struct GenreView_Previews: PreviewProvider {
    static var previews: some View {
        ByGenreListCell()
    }
}
