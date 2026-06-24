//
//  SearchLocationsView.swift
//  Weatherly
//
//  Created by Esraa Ehab on 23/06/2026.
//

import SwiftUI
import SwiftData

struct SearchLocationsView: View {
    @Environment (\.modelContext) private var modelContext
    @Query private var savedLocations: [SavedLocations]
    
    @StateObject private var searchViewModel = SearchViewModel()
    
    @State private var showDeleteAlert = false
    @State private var locationToDelete: SavedLocations?
    
    var currentTimeOfDay : TimeOfDay {
        Date().timeOfDay
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(currentTimeOfDay.backgroundImageName)
                    .resizable()
                    .ignoresSafeArea()
                
                List {
                    if !searchViewModel.searchText.isEmpty {
                        Section("Search Results") {
                            if searchViewModel.isLoading {
                                ProgressView()
                                    .frame(maxWidth: .infinity, alignment: .center)
                            } else {
                                ForEach(searchViewModel.searchResults) { location in
                                    Button(action: {
                                        saveLocation(location)
                                    }) {
                                        HStack {
                                            Text(location.name)
                                                .foregroundColor(.primary)
                                            Spacer()
                                            Text(location.country)
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    else {
                        Section("Saved Locations") {
                            ForEach(savedLocations) { location in
                                NavigationLink(destination: Text("Details for \(location.name)")) {
                                    SavedLocationRow(location: location)
                                }
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .buttonStyle(PlainButtonStyle())
                            }
                            .onDelete(perform: confirmDelete)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("Favorites")
                .searchable(text: $searchViewModel.searchText, prompt: "Search for a city...")
                .safeAreaPadding(.bottom, 100)
                .toolbarBackground(.hidden, for: .navigationBar)
                                .toolbarBackground(Color.clear, for: .navigationBar)
            }
            .alert("Delete Location", isPresented: $showDeleteAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    if let location = locationToDelete {
                        deleteLocation(location)
                    }
                }
            } message: {
                Text("Are you sure you want to remove \(locationToDelete?.name ?? "this city") from your favorites?")
            }
        } 
        
    }
        
    private func saveLocation(_ searchLoc: SearchLocation) {
        let newLocation = SavedLocations(name: searchLoc.name, country: searchLoc.country, lat: searchLoc.lat, lon: searchLoc.lon)
        modelContext.insert(newLocation)
        searchViewModel.searchText = ""
    }
    
    private func confirmDelete(offsets: IndexSet) {
        if let index = offsets.first {
            locationToDelete = savedLocations[index]
            showDeleteAlert = true
        }
    }
    
    private func deleteLocation(_ location: SavedLocations) {
        modelContext.delete(location)
        locationToDelete = nil
    }
} 

#Preview {
    SearchLocationsView()
}
