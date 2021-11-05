//
//  InfoView.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 02/10/21.
//

import SwiftUI

struct InfoView: View {
    
    private let defaultUrl = URL(string: "https://www.google.com")
    private let url = URL(string: "https://unsplash.com")
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            ScrollView {
                VStack{
                    Spacer(minLength: 60)
                    VStack(alignment: .leading) {
                        Text("APP INFO")
                            .font(.title)
                            .fontWeight(.medium)
                            .foregroundColor(Color.theme.darkYellow)
                            .padding(.bottom, 30)
                        
                        rowInfoView(title: "Compatibility", subtitle: "Iphone - IOS 13 or Above")
                        rowInfoView(title: "Version", subtitle: "1.0.0")
                        rowInfoView(title: "Developer", subtitle: "Sergio Aquiles")
                        rowInfoView(title: "Designer", subtitle: "Sergio Aquiles")
                    }
                    
                    VStack(alignment: .leading){
                        Text("CREDITS")
                            .font(.title)
                            .fontWeight(.medium)
                            .foregroundColor(Color.theme.darkYellow)
                            .padding(.bottom, 30)
                            .padding(.top, 30)
                        
                        HStack{
                            Text("Photos:")
                                .font(.callout)
                                .foregroundColor(Color.theme.secondaryText)
                            Spacer()
                            Link("Unsplash", destination: url ?? defaultUrl!)
                                .accentColor(.blue)
                                .font(.callout)
                        }
                        Divider()
                        Text("Photographers:")
                            .font(.callout)
                            .padding(.bottom, 2)
                            .foregroundColor(Color.theme.secondaryText)
                        Text("Sunbeam Photography and Gaelle Marcel")
                            .foregroundColor(Color.theme.secondaryText)
                    }
                    
                    Spacer(minLength: UIScreen.main.bounds.height / 4)
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        VStack(spacing: -5) {
                            Image(systemName: "chevron.compact.down")
                            Image(systemName: "chevron.compact.down")
                             
                        }
                        .font(.system(size: 60))
                        .foregroundColor(Color.theme.darkYellow)
                    }
                }
                .padding(.horizontal, 15)
            }
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
            .preferredColorScheme(.dark)
    }
}

struct rowInfoView: View {
    
    var title: String
    var subtitle: String
    
    var body: some View {
        
        HStack{
            Text(title)
                .font(.callout)
            
            Spacer()
            Text(subtitle)
                .font(.callout)
        }
        .foregroundColor(Color.theme.secondaryText)
        Divider()
    }
}
