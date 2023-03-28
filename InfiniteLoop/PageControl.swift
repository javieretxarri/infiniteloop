//
//  PageControl.swift
//  InfiniteLoop
//
//  Created by Javier Etxarri on 28/3/23.
//

import SwiftUI

struct PageControl: UIViewRepresentable {
    var totalPages: Int
    var currentPage: Int

    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = totalPages
        control.currentPage = currentPage
        control.backgroundStyle = .prominent
        control.allowsContinuousInteraction = false

        return control
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.numberOfPages = totalPages
        uiView.currentPage = currentPage
    }
}
