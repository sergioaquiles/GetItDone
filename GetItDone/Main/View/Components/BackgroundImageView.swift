//
//  BackgroundImageView.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 14/09/21.
//

import SwiftUI

struct BackgroundImageView: View {
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Image(colorScheme == .dark ? "backgroundDark" : "backgroundLight")
            .antialiased(true)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea(.all)
    }
}

struct BackgroundImageView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImageView()
            .preferredColorScheme(.dark)
    }
}
