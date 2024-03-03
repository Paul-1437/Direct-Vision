//
//  iPadView.swift
//  DirectVision
//
//  Created by Paul on 1/29/24.
//

import Foundation
import SwiftUI

struct iPadView: View {
    @State private var showHelp = false
    @State private var Select = false
    var body: some View {
        NavigationView {
            VStack{
                // iPad-specific code
                List{
                Text("Direct Vision helps you with image recognition. You can select a photo or use your camera.")
                    ImageSelectn()
                    SysCameraView()
                    NavigationLink(destination: DirectVision.CameraView()){
                        Text(LocalizedStringKey("Camera View"))
                    }
                }
                
                .navigationTitle("Direct Vision")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct iPadView_Previews: PreviewProvider {
    static var previews: some View {
        iPadView()
    }
}
