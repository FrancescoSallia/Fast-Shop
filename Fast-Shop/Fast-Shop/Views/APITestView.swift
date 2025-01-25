//
//  APITestView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 20.01.25.
//

import SwiftUI

struct APITestView: View {
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack {
                LazyVGrid(columns: columns ) {
                    ForEach(0...10, id: \.self) { filteredProduct in
                        
                            VStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(minWidth: 210, minHeight: 290)
                                    .foregroundStyle(.orange)
                                HStack {
                                    Text("\(filteredProduct)")
                                        .font(.footnote)
                                        .frame(width: 150)
                                    Image(systemName: "bookmark")
                                }

                                HStack {
                                    Text("\(filteredProduct)€")
                                        .font(.footnote)
                                        .frame(width: 150)
                                        .padding(.bottom, 30)

                                    Spacer()
                                }
                                .padding(.horizontal)
                            }
                        }
                }
            }
        }
        
        
        
        
        
        
  }
}
#Preview {
    APITestView()
}



