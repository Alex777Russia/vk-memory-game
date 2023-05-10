//
//  ListServices.swift
//  vk-games
//
//  Created by Алексей Шевченко on 10.05.2023.
//

import SwiftUI

struct ListSrevices: View {
    var body: some View {
        VStack {
            Text("Сервисы")
                .font(.title)
            List (servicesItem, id: \.self) { service in
                HStack {
                    Image(service.nameImage)
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text (service.name)
                        .padding(5)
                        .font(.title3)
                }
            }
        }
        .padding(.vertical)
    }
}

struct ListServices_Previews: PreviewProvider {
    static var previews: some View {
        ListSrevices()
    }
}
