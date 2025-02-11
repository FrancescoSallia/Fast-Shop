//
//  IsSuccessfullSheet.swift
//  Fast-Shop
//
//  Created by Francesco Sallia on 05.02.25.
//

import SwiftUI
import Toast

struct IsSuccessfullSheet: View {
    @ObservedObject var viewModel: ProductViewModel
//    let toast = Toast.default(
//        image: UIImage(systemName: "checkmark.circle.fill")!,
//        imageTint: .systemGreen,
//        title: "Zum Warenkorb hinzugefügt",
//        config: .init(
//            direction: .bottom
//        ))
    
    let toast = Toast.text(
        "Zum Warenkorb Hinzugefügt!",
        config: .init(
            direction: .bottom
           )
        )
    
//    let toast = Toast.default(
//        image: UIImage(systemName: "checkmark.circle.fill")!,
//        title: "Zum Warenkorb hinzugefügt",
//        subtitle: ""
//    )
    
    var body: some View {
        
        ZStack {
//            Color.green.opacity(0.4)
            Color.clear
            Rectangle()
                .frame(maxWidth: 406, maxHeight: 100)
                .foregroundStyle(.clear)
            VStack {
                HStack {
//                    Image(systemName: "checkmark.circle.fill")
//                    Text("Zum Warenkorb hinzugefügt")
//                    Button("Ansehen") {
//                        
//                    }
//                    .padding(.leading)
                    Spacer()
                    Text("test \(toast.show())")
                        .padding(.top, 2000)
                    
                }
//                .padding(.top, 30)
//                Spacer()
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
