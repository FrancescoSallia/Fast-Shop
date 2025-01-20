//
//  SearchView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 20.01.25.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""

    var body: some View {
        NavigationStack {
            List(0...40, id: \.self) { item in
                Text("\(item)")
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always) ,prompt: "Search")
    }
}

#Preview {
    SearchView()
}
