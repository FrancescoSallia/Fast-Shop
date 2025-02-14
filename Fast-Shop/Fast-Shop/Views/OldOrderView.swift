//
//  OldOrderView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 14.02.25.
//

import SwiftUI

struct OldOrderView: View {
    @ObservedObject var viewModelFirestore: FirestoreViewModel
    
    var body: some View {
                    
        List(viewModelFirestore.oldOrderList, id: \.oldOrderID) { item in
            Text(item.date ?? "No Date")
        }
        .navigationTitle("Old-Orders")
    }
}

#Preview {
    OldOrderView(viewModelFirestore: FirestoreViewModel())
}
