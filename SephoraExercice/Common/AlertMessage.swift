//
//  AlertMessage.swift
//  SephoraExercice
//
//  Created by Firas on 27/09/2023.
//

public struct AlertMessage {
    public var title = ""
    public var message = ""
    public var isShowing = false
    
    init(error: Error) {
        self.title = "Error"
        let message = error.localizedDescription
        self.message = message
        self.isShowing = !message.isEmpty
    }

    init() {
    }
}
