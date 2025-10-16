//
//  SettingsView.swift
//  ToDo
//
//  Created by Labhesh Dudi on 17/09/25.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - PROPERTIES
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var iconSettings: IconNames
    
    // THEME
    
    let themes: [Theme] = themeData
    @ObservedObject var theme = ThemeSettings()
    @State private var isThemeChanged: Bool = false
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                // MARK: - FORM
                
                Form {
                    // MARK: - SECTION 1
                    
                    Section(header: Text("Choose the app icon")) {
                        Picker(selection: $iconSettings.currentIndex, label:
                                HStack {
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .strokeBorder(Color.primary, lineWidth: 2)
                                
                                Image(systemName: "paintbrush")
                                    .font(.system(size: 28, weight: .regular, design: .default))
                                    .foregroundColor(.primary)
                            }
                            .frame(width: 44, height: 44)
                            
                            Text("App Icons".uppercased())
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                        }
                        ) {
                            ForEach(0..<iconSettings.iconNames.count, id: \.self) { index in
                                HStack(spacing: 12) {
                                    Image(iconSettings.iconNames[index] ?? "Blue")
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 44, height: 44)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .clipped()
                                    Text(iconSettings.iconNames[index] ?? "Blue")
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                    
                                    Spacer()
                                }
                                .frame(height: 56)
                                .contentShape(Rectangle())
                                .tag(index)
                            }//: LOOP
                        }//: PICKER
                        .onReceive([self.iconSettings.currentIndex].publisher.first()) { (value) in
                            let index = self.iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                            if index != value {
                                UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value]) { error in
                                    if let error = error {
                                        print(error.localizedDescription)
                                    } else {
                                        print("Sucess! You have changed the app icons.")
                                    }
                                }
                            }
                            
                        }
                    }//: SECTION
                    .padding(.vertical, 3)

                    // MARK: - SECTION 2
                    
                    Section(header:
                                HStack {
                        Text("Choose the app theme")
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(themes[self.theme.themeSettings].themeColor)
                    }
                    ) {
                        List {
                            ForEach(themes, id: \.id) { item in
                                
                                Button(action: {
                                    self.theme.themeSettings = item.id
                                    UserDefaults.standard.set(self.theme.themeSettings, forKey: "Theme")
                                    self.isThemeChanged.toggle()
                                }) {
                                    HStack {
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(item.themeColor)
                                        
                                        Text(item.themeName)
                                        
                                    }
                                } //: BUTTON
                                .accentColor(Color.primary)
                            }
                        }
                    } //: SECTION 2
                    .padding(.vertical, 3)
                    .alert(isPresented: $isThemeChanged) {
                        Alert(title: Text("SUCCESS!"), message: Text("App has been changed to the \(themes[self.theme.themeSettings].themeName). Now close and restart it!"), dismissButton: .default(Text("OK")))
                    }
                    
                    
                    // MARK: SECTION 3
                    
                    Section(header: Text("Follow us on social media")) {
                        FormRowLinkView(icon: "globe", color: Color.pink, text: "Website", link: "https://swiftuimasterclass.com")
                        FormRowLinkView(icon: "link", color: Color.blue, text: "Twitter", link: "https://twitter.com/robertpetras")
                        FormRowLinkView(icon: "play.rectangle", color: Color.green, text: "Courses", link: "https://www.udemy.com/user/robert-petras")
                    } //: SECTION 3
                    
                    // MARK: SECTION 4
                    
                    Section(header: Text("About the application")) {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "John / Jane")
                        FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "Robert Petras")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                    } //: SECTION 4
                    .padding(.vertical, 3)
                }//: FORM
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                
                //MARK: - Footer
                Text("All rights reserved. © 2025 Labhesh Dudi.\n Better Apps ♡ Less Code")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(Color.secondary)
            }//: VSTACK
            .navigationBarItems(trailing:
                                    Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    
            }
            )
            .navigationBarTitle("Settings", displayMode: .inline)
            .background(Color("ColorBackground")).edgesIgnoringSafeArea(.bottom)
        } //: NAVIGATION
        .accentColor(themes[self.theme.themeSettings].themeColor)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// MARK: - Preview

#Preview {
    SettingsView().environmentObject(IconNames())
}
