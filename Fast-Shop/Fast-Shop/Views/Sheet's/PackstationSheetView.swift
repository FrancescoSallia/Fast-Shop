//
//  PackstationSheetView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 04.02.25.
//

import SwiftUI

struct PackstationSheetView: View {
    
    
    var body: some View {
        NavigationStack {
            Text("Packstation Auswählen")
                .textCase(.uppercase)
                .font(.callout)
            
            ForEach(0...20, id: \.self) { item in
                VStack(alignment: .leading) {
                    Text("\(item)")
                    Text("\(item)")
                    Text("\(item)")
                    Text("\(item)")
                    Divider()
                }
                //            .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    PackstationSheetView()
}
