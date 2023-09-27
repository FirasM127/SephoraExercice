//
//  Environment.swift
//  SephoraExercice
//
//  Created by Firas on 27/09/2023.
//

enum Server {
    case developement
    case staging
    case production
}

class Environment {
    
    static let server: Server = .developement
    class func APIBasePath() -> String {
        switch self.server {
        case .developement:
            return "https://sephoraios.github.io/"
        case .staging:
            return "https://sephoraios.github.io/"
        case .production:
            return "https://sephoraios.github.io/"
        }
    }
}
