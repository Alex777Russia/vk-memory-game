//
//  Menu.swift
//  vk-games
//
//  Created by Алексей Шевченко on 10.05.2023.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack {
            Label(title: { Text("VK memory game").customTitleText() },
                  icon: { Image(systemName: "heart.fill") }
            ).padding(20)
            Text("Author: Alexey Shevchenko").customAuthorText()
                .padding(20)
            Text("Summer Internship 2023").customAuthorText()
                .padding(20)
        }
    }
}

extension Text {
    func customTitleText() -> some View {
        self.bold().italic().lineLimit(1)
            .font(.custom("Open Sans", size: 33))
            .foregroundColor(.black)
    }
    
    func customAuthorText()-> some View {
        self.bold().lineLimit(2)
            .font(.custom("Open Sans", size: 23))
            .foregroundColor(.black)
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
