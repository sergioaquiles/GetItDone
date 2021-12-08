//
//  SectionHeaderView.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 08/12/21.
//

import SwiftUI

struct SectionHeaderView: View {
    
    var title: String
    
    var body: some View {
        HStack(alignment:.center, spacing: 5) {
            Image(systemName: "calendar")
            Text(title)
                
        }
        .font(.caption)
        .foregroundColor(Color.theme.accent)
    }
}

struct SectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeaderView(title: "20 Mar 2021")
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
