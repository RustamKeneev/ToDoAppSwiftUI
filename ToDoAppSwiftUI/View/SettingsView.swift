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
    @EnvironmentObject var iconSettings: IconNames


    //MARK: - BOBY
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 0){
                //MARK: - FORM
                Form{
                    //MARK: - SECTION 1
                    Section(header: Text("Choose the app icon")) {
                        Picker(selection: $iconSettings.currentIndex, label:
                                HStack{
                            ZStack {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .strokeBorder(Color.primary, lineWidth: 2)
                                Image(systemName: "paintbrush")
                                    .font(.system(size: 28, weight: .regular, design: .default))
                                .foregroundColor(Color.primary)
                            }
                            .frame(width: 44, height: 44)
                            Text("App icons".uppercased())
                                .fontWeight(.bold)
                                .foregroundColor(Color.primary)
                        }//: HSTACK
                        ){
                            ForEach(0..<iconSettings.iconNames.count){ index in
                                HStack{
                                    Image(uiImage: UIImage(named: self.iconSettings.iconNames[index] ?? "Blue")?.scaleToFill(size: CGSize(width: 44, height: 44)) ?? UIImage())
                                        .renderingMode(.original)
                                        .resizable()
                                        .cornerRadius(8)

                                    Spacer()
                                        .frame(width: 8)
                                    Text(self.iconSettings.iconNames[index] ?? "Blue")
                                        .frame(alignment: .leading)
                                }//: HSTACK
                                .padding(4)
                            }//: LOOP
                        }//: PICKER
                        .onReceive([self.iconSettings.currentIndex].publisher.first()){(value) in
                            let index = self.iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                            if index != value{
                                UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value]){ error in
                                    if let error = error{
                                        print(error.localizedDescription)
                                    }else{
                                        print("Succces! You have change the app icon. ")
                                    }
                                }
                            }
                        }
                    }//: SECTION 1
                    .padding(.vertical, 4)
                    

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
        .environmentObject(IconNames())
}


extension UIImage {
    func scaleToFill(size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
