////
////  NavigationBarColor.swift
////  Gradual
////
////  Created by Mason Dierkes on 1/20/22.
////
//
//import SwiftUI
//import UIKit
//
//struct NavigationBarColor: ViewModifier {
//
//  init(backgroundColor: Color, tintColor: UIColor) {
//    let coloredAppearance = UINavigationBarAppearance()
//    coloredAppearance.configureWithOpaqueBackground()
//    coloredAppearance.backgroundColor = UIColor(backgroundColor)
//    coloredAppearance.titleTextAttributes = [.foregroundColor: tintColor]
//    coloredAppearance.largeTitleTextAttributes = [.foregroundColor: tintColor]
//                   
//    UINavigationBar.appearance().standardAppearance = coloredAppearance
//    UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
//    UINavigationBar.appearance().compactAppearance = coloredAppearance
//    UINavigationBar.appearance().tintColor = tintColor
//  }
//
//  func body(content: Content) -> some View {
//    content
//  }
//}
//
//
//extension View {
//  func navigationBarColor(backgroundColor: Color, tintColor: UIColor) -> some View {
//    self.modifier(NavigationBarColor(backgroundColor: backgroundColor, tintColor: tintColor))
//  }
//}
