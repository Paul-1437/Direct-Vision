//
//  Buttons.swift
//  MyApp
//
//  Created by Paul on 1/13/24.
//
//Depercated

import Foundation
import SwiftUI

struct Buttons: View {
    @State private var showHelp = false
    var body: some View {
        if showHelp {
            Text("Text.")
                .padding()
        }
        HStack{
            Button("Help") {
                showHelp.toggle()
            }
            // Add padding for styling
        }
        .padding()
    }
}

#Preview {
    Buttons()
}
