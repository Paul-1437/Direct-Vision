//
//  ContentView.swift
//  MyApp
//
//  Created by Paul on 1/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showHelp = false
    @State private var Select = false
    var body: some View {
        NavigationView {
            List {
                // iPhone-specific code
                Text("Direct Vision helps you with image recognition. You can select a photo or use your camera.")
                NavigationLink(destination: DirectVision.ImageSelectn()){
                    Text(LocalizedStringKey("Select Photo"))
                }
                NavigationLink(destination: DirectVision.CameraView()){
                    Text(LocalizedStringKey("Image Recognition via Camera"))
                }
                SysCameraView()
            }
            .navigationTitle("Direct Vision")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
