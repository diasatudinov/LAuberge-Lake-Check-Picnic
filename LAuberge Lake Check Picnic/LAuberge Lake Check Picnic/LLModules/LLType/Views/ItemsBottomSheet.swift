//
//  PicturesBottomSheet.swift
//  LAuberge Lake Check Picnic
//
//

import SwiftUI

struct ItemsBottomSheet: View {
    let items: Item

    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()

            ScrollView {
                LazyVStack(spacing: 12) {
//                    ForEach(pictures, id: \.self) { name in
//                        HStack(spacing: 12) {
//                            Image(systemName: name) // or Image(name) for assets
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 44, height: 44)
//
//                            Text(name)
//                                .font(.headline)
//
//                            Spacer()
//                        }
//                        .padding(12)
//                        .background(.ultraThinMaterial)
//                        .clipShape(RoundedRectangle(cornerRadius: 14))
//                        .padding(.horizontal, 16)
//                    }
                }
                .padding(.vertical, 16)
            }
        }
    }
}
