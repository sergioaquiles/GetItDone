//
//  NewCheckBoxStyle.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 17/09/21.
//

import SwiftUI

struct NewCheckBoxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack{
            Image(systemName: configuration.isOn ? "checkmark.square" : "square" )
                .foregroundColor(configuration.isOn ? Color.theme.darkYellow : Color.theme.accent)
                .font(.system(size: 30))
                .onTapGesture {
                    configuration.isOn.toggle()
                    feedback.notificationOccurred(.success)
                }
            configuration.label
        }
    }
}

struct NewCheckBoxStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle("Task Here", isOn: .constant(true))
            .toggleStyle(NewCheckBoxStyle())
            .padding()
    }
}
