//
//  FormRowStaticView.swift
//  ToDoAppSwiftUI
//
//  Created by Rustam Keneev on 8/4/24.
//

import SwiftUI

struct FormRowStaticView: View {
    //MARK: - PROPERTIES
    var icon: String
    var firstText:  String
    var secondText: String

    //MARK: - BODY
    var body: some View {
        HStack {
            ZStack{
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.gray)
                Image(systemName: icon)
                    .foregroundColor(Color.white)
            }//: ZSTACK
            .frame(width: 36, height: 36, alignment: .center)
            Text(firstText).foregroundColor(Color.gray)
            Spacer()
            Text(secondText)
        }//: HSTACK
    }
}

//MARK: - PREVIEW
#Preview {
    FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
        .previewLayout(.fixed(width: 376, height: 60))
        .padding()
}
