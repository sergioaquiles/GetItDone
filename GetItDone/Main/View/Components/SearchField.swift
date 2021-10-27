//
//  SearchField.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 11/10/21.
//

import SwiftUI

struct SearchField: View {
    
    @Binding var searchField: String
    
    var body: some View {
        
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(searchField.isEmpty ? .gray : Color.theme.darkYellow)
                
                TextField("Search...", text: $searchField)
                    .foregroundColor(Color.gray)
                    .overlay(
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color.theme.secondaryText)
                            .font(.body)
                            .padding(.trailing, 2)
                            .opacity(searchField.isEmpty ? 0 : 1)
                            .onTapGesture {
                                searchField = ""
                                UIApplication.shared.endEditing()
                            }
                        ,alignment: .trailing
                    )
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(Color.theme.background).opacity(0.7)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.4), radius: 10, x: 2, y: 5)
    }
}

struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        SearchField(searchField: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
