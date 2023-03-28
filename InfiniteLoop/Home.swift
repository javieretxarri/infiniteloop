//
//  Home.swift
//  InfiniteLoop
//
//  Created by Javier Etxarri on 28/3/23.
//

import SwiftUI

struct Home: View {
    @State private var currentPage = ""
    @State private var listOfPages: [Page] = []
    @State private var fakePages: [Page] = []
    var body: some View {
        GeometryReader {
            let size = $0.size

            TabView(selection: $currentPage) {
                ForEach(fakePages) { page in
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(page.color.gradient)
                        .frame(width: 300, height: size.height)
                        .tag(page.id.uuidString)
                        .offsetX(currentPage == page.id.uuidString) { rect in
                            let minX = rect.minX
                            let pageOffset = minX - (size.width * CGFloat(fakeIndex(page)))

                            print(pageOffset)
                            print(size)

                            let pageProgress = pageOffset / size.width
                            print(pageProgress)
                            if -pageProgress < 1.0 {
                                // Moving to the last page
                                // which is actually the first ducplicated page
                                // safe check
                                if fakePages.indices.contains(fakePages.count - 1) {
                                    currentPage = fakePages[fakePages.count - 1].id.uuidString
                                }
                            }

                            if -pageProgress > CGFloat(fakePages.count - 1) {
                                // Moving to the first page
                                // which is actually the last ducplicated page
                                // safe check
                                if fakePages.indices.contains(1) {
                                    currentPage = fakePages[1].id.uuidString
                                }
                            }
                        }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .overlay(alignment: .bottom) {
                PageControl(totalPages: listOfPages.count, currentPage: originalIndex(currentPage))
                    .offset(y: -15)
            }
        }
        .frame(height: 400)
        .onAppear {
            guard fakePages.isEmpty else { return }
            for color in [Color.blue, Color.red, Color.green, Color.gray, Color.yellow] {
                listOfPages.append(.init(color: color))
            }

            fakePages.append(contentsOf: listOfPages)

            if var firstPage = listOfPages.first, var lastPage = listOfPages.last {
                currentPage = firstPage.id.uuidString
                firstPage.id = .init()
                lastPage.id = .init()

                fakePages.append(firstPage)
                fakePages.insert(lastPage, at: 0)
            }
        }
    }

    func fakeIndex(_ of: Page) -> Int {
        fakePages.firstIndex(of: of) ?? 0
    }

    func originalIndex(_ id: String) -> Int {
        listOfPages.firstIndex { page in
            page.id.uuidString == id
        } ?? 0
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
