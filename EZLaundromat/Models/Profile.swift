//
//  Profile.swift
//  EZLaundromat
//
//  Created by KEEVIN MITCHELL on 4/10/24.
//

import Foundation
import SwiftData

@Model
final class Profile {
    var name: String
    @Attribute(.externalStorage)
    var profileImage: Data?
    init(name: String, profileImage: Data? = nil) {
        self.name = name
        self.profileImage = profileImage
    }
    
}
