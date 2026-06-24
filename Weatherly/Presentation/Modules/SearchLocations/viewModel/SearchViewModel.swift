//
//  SearchViewModel.swift
//  Weatherly
//
//  Created by Esraa Ehab on 23/06/2026.
//

import Foundation

@MainActor
class SearchViewModel : ObservableObject{
    @Published var searchText = ""{
        didSet{
            if searchText.count > 2{
             performSearch()
            }else{
                searchResults = []
            }
        }
    }
    @Published var searchResults : [SearchLocation] = []
    @Published var isLoading = false
    private let networkManager = WeatherNetworkManager()
    
    func performSearch(){
        isLoading = true
        Task{
            do{
                searchResults = try await networkManager.searchCity(query: searchText)
                isLoading = false
            }catch{
                print("Search error : \(error.localizedDescription)")
                isLoading = false
            }
        }
    }
}
