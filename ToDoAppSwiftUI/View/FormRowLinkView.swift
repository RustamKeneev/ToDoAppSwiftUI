//
//  FormRowLinkView.swift
//  ToDoAppSwiftUI
//
//  Created by Rustam Keneev on 8/4/24.
//

import SwiftUI

struct FormRowLinkView: View {
    //MARK: - PROPERTIES
    var icon: String
    var color: Color
    var text: String
    var link: String
    
    //MARK: - BODY
    var body: some View {
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundColor(Color.white)
            }//: ZSTACK
            .frame(width: 36, height: 36, alignment: .center)
            Text(text).foregroundColor(Color.gray)
            Spacer()
            Button(action: {
                //: OPEN LINK
                guard let url = URL(string: self.link), UIApplication.shared.canOpenURL(url) else {
                    return
                }
                UIApplication.shared.open(url as URL)
            }){
               Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
            }
            .accentColor(Color(.systemGray2))
        }//: HSTACK
    }
}


//MARK: - PREVIEW
#Preview {
    FormRowLinkView(icon: "globe", color: Color.pink, text: "gitHub", link: "https://github.com/RustamKeneev")
        .previewLayout(.fixed(width: 376, height: 60))
        .padding()
}
