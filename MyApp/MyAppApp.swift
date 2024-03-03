//
//  MyAppApp.swift
//  MyApp
//
//  Created by Paul on 1/5/24.
//
import SwiftUI

@main
struct DirectV: App {
    var body: some Scene {
        WindowGroup {
            if UIDevice.current.userInterfaceIdiom == .phone {
                ContentView()
            }
            else {
                iPadView()
            }
        }
    }
}
