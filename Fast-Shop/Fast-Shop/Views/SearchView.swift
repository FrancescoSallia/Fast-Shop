//
//  SearchView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 20.01.25.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    @State var searchNumber: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
       

    var body: some View {
        NavigationStack {
            List(searchNumber, id: \.self) { item in
                Text("\(item)")
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always) ,prompt: "Search")
    }
}
#Preview {
    SearchView()
}
