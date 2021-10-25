//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Rogério Tavares on 23/10/21.
//

import SwiftUI

@available(iOS 15.0, *)
extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
    
    func isTitle() -> some View {
        modifier(TitleContainer())
    }
}

@available(iOS 15.0, *)
struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Title")
                .isTitle()
            Color.blue
                .frame(width: 300, height: 200)
                .watermarked(with: "Hacking with Swift - Roger")
        }
        
    }
}

@available(iOS 15.0, *)
struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

@available(iOS 15.0, *)
struct TitleContainer: ViewModifier {
    
    func body(content: Content) -> some View {
        VStack {
            content
                .font(.largeTitle)
                .foregroundColor(.blue)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.black)
        .foregroundStyle(.primary)
    }
}


@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
