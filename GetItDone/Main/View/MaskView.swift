//
//  MaskView.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 16/09/21.
//

import SwiftUI

struct MaskView: View {
    
    var bg: Color
    var bgOpacity: Double
    
    var body: some View {
        VStack{
            Spacer()
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(bg)
        .opacity(bgOpacity)
        .edgesIgnoringSafeArea(.all)
    }
}

struct MaskView_Previews: PreviewProvider {
    static var previews: some View {
        MaskView(bg: Color.theme.background, bgOpacity: 0.3)
    }
}
