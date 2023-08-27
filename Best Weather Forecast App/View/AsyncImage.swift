//
//  AsyncImage.swift
//  Best Weather Forecast App
//
//  Created by Ian Castillo on 27/08/23.
//

import SwiftUI

struct AsyncImage: View {
    @ObservedObject private var loader: ImageLoader
    private var placeholder: Image

    init(url: String, placeholder: Image = Image(systemName: "cloud")) {
        loader = ImageLoader(url: url)
        self.placeholder = placeholder
    }

    var body: some View {
        if let image = loader.image {
            Image(uiImage: image).resizable()
        } else {
            placeholder
        }
    }
}
