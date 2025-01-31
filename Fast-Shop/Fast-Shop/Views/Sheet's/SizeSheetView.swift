//
//  SizeSheetView.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 31.01.25.
//

import SwiftUI

struct SizeSheetView: View {
    @ObservedObject var viewModel: ProductViewModel
    let columns = [(GridItem(.flexible())), (GridItem(.flexible()))]

    var body: some View {
        Text("Wählen Sie eine Größe aus")
            .shadow(radius: 2, x: 0, y: 3)
        LazyVGrid(columns: columns) {
            ForEach(SizesEnum.allCases, id: \.self) { item in
                ZStack {
                    Rectangle()
                        .frame(width: 190, height: 60)
                        .foregroundStyle(item.rawValue == viewModel.selectedSize ? .black : .white)
                        .border(.black)
                        .shadow(radius: 2, x: 0, y: 3)
                    Text(item.rawValue)
                        .bold()
                        .foregroundStyle(item.rawValue == viewModel.selectedSize ? .white : .black)

                }
                .onTapGesture {
                    viewModel.selectedSize = item.rawValue
                    viewModel.showSizes = false

                }
                
            }
            
        }
    }
}

#Preview {
    SizeSheetView(viewModel: ProductViewModel())
}



//Text("Wählen Sie eine Größe aus")
//    .shadow(radius: 2, x: 0, y: 3)
//LazyVGrid(columns: columns) {
//    ForEach(SizesEnum.allCases, id: \.self) { item in
//        ZStack {
//            Rectangle()
//                .frame(width: 190, height: 60)
//                .foregroundStyle(.white)
//                .border(.black)
//                .shadow(radius: 2, x: 0, y: 3)
//            Text(item.rawValue)
//                .bold()
//        }
//    }
//    
//}
