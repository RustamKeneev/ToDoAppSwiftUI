//
//  SettingsView.swift
//  ToDoAppSwiftUI
//
//  Created by Rustam Keneev on 28/3/24.
//

import SwiftUI

struct SettingsView: View {
    //MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode

    //MARK: - BOBY
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 0){
                //MARK: - FORM
                Form{
                    //MARK: - SECTION 3
                    Section(header: Text("Follow us on social media")) {
                        FormRowLinkView(icon: "globe", color: Color.pink, text: "GitHub", link: "https://github.com/RustamKeneev")
                        FormRowLinkView(icon: "link", color: Color.blue, text: "LinkenIn", link: "https://linkenin.com/RustamKeneev")
                        FormRowLinkView(icon: "play.rectangle", color: Color.blue, text: "Youtube", link: "https://youtube.com/RustamKeneev")
                    }//: SECTION 3
                    .padding(.vertical, 4)
                    
                    //MARK: - SECTION 4
                    Section(header: Text("About the application")) {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "IPhone, IPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Rustam Keneev")
                        FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "Rustam Keneev")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                    }//: SECTION 4
                    .padding(.vertical, 4)
                }//: FORM
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                
                //MARK: - FOOTER
                Text("Copyright © All rights reserved. \n Cool Apps ♡")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(Color.secondary)
            }//: VSTACK
            .navigationBarItems(trailing:
                Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }){
                Image(systemName: "xmark")
            }
            )
            .navigationBarTitle("Settings", displayMode: .inline)
            .background(Color("ColorBackground"))
//            .edgesIgnoringSafeArea(.all)
        }//: NAVOGATION
    }
}

//MARK: - PREVIEW
#Preview {
    SettingsView()
}
