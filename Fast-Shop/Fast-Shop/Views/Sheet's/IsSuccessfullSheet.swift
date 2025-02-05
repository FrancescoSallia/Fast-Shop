//
//  IsSuccessfullSheet.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 05.02.25.
//

import SwiftUI

struct IsSuccessfullSheet: View {
    @ObservedObject var viewModel: ProductViewModel
    var body: some View {
        
        ZStack {
            Color.green.opacity(0.4)
            Rectangle()
                .frame(maxWidth: 406, maxHeight: 100)
                .foregroundStyle(.clear)
            VStack {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                    Text("Zum Warenkorb hinzugefügt")
                    Button("Ansehen") {
                        
                    }
                    .padding(.leading)
                }
                .padding(.top, 30)
                Spacer()
            }
        }
        .ignoresSafeArea()
       
        
//        VStack {
//            ZStack {
//                Rectangle()
//                    .frame(width: 420, height: 50)
//                    .foregroundStyle(.green)
//                
//                Text("Zum Warenkorb hinzugefügt")
//                    .foregroundStyle(.white)
//                    .padding(.trailing, 70)
//                Image(systemName: "checkmark.circle.fill")
//                    .resizable()
//                    .frame(width: 20, height: 20)
//                    .offset(x: -165)
//                    .foregroundStyle(.white)
//                Button("Ansehen"){
//                    //placeholder
//                }
//                .bold()
//                .offset(x: 145)
//                .tint(.white)
//            }
//        }
//        .animation(.easeInOut, value: viewModel.showAlertSuccessfullAdded)
    }
}

#Preview {
    IsSuccessfullSheet(viewModel: ProductViewModel())
}
