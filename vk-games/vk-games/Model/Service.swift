//
//  Services.swift
//  vk-games
//
//  Created by Алексей Шевченко on 10.05.2023.
//

import UIKit

struct Service: Hashable {
    var id = UUID()
    let name: String
    let nameImage: String
}

let servicesItem: [Service] = [Service(name: "VK", nameImage: "vk"),
                               Service(name: "Одноклассники", nameImage: "odnoclass"),
                               Service(name: "Geek Brains", nameImage: "geekbrains"),
                               Service(name: "Delivery", nameImage: "delivery"),
                               Service(name: "Юла", nameImage: "yula"),
                               Service(name: "VK Teams", nameImage: "teams"),
                               Service(name: "Dzen", nameImage: "dzen"),
                               Service(name: "Skillbox", nameImage: "skillbox"),
                               Service(name: "VK Play", nameImage: "play"),
                               Service(name: "VK Music", nameImage: "music"),
                               Service(name: "Маруся", nameImage: "marusya"),
                               Service(name: "Mail", nameImage: "mail"),
                               Service(name: "VK Cloud", nameImage: "cloud"),
                               Service(name: "Atom", nameImage: "atom"),
                               Service(name: "VK Messege", nameImage: "messege")]
