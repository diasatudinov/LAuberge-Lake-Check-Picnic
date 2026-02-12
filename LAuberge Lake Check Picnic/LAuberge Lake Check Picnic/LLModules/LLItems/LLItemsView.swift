//
//  LLItemsView.swift
//  LAuberge Lake Check Picnic
//
//

import SwiftUI

struct LLItemsView: View {
    @ObservedObject var viewModel: LLRelaxationViewModel
    
    @State private var showCreateItem = false
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    @State private var selectedItem: Item?
    @State private var showDeleteBtn = false
    var body: some View {
        VStack {
            Text("Items")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.linenBase)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
                .background(.pineShade)
            
            ScrollView(showsIndicators: false) {
                
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(viewModel.items, id: \.id) { item in
                        VStack(spacing: 0) {
                            itemImage(item)
                                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 10, topTrailingRadius: 10))
                            
                            Text(item.name)
                                .font(.system(size: 11, weight: .bold))
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 12)
                                .padding(.top, 8)
                                .padding(.bottom, 12)
                                .background(.pineShade)
                                .clipShape(UnevenRoundedRectangle(bottomLeadingRadius: 10, bottomTrailingRadius: 10))
                        }
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                                .foregroundStyle(.regalAccent)
                        }
                        .overlay(content: {
                            if let selectedItem = selectedItem, selectedItem == item {
                                Color.black.opacity(0.5)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                Button {
                                    viewModel.delete(item: item)
                                } label: {
                                    Circle()
                                        .fill(.red)
                                        .frame(height: 50)
                                        .overlay {
                                            Image(systemName: "trash")
                                                .foregroundStyle(.white)
                                        }
                                }
                            }
                        })
                        .onLongPressGesture {
                            selectedItem = item
                            showDeleteBtn.toggle()
                        }
                    }
                }
                .padding(.horizontal, 20).padding(.vertical)
                .padding(.bottom, 140)
            }
            
            
            
        }
        .background(.deepPine)
        .overlay(alignment: .bottomTrailing) {
            Button {
                showCreateItem = true
            } label: {
                Text("+ Add Item")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 32)                    .background(.regalAccent)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 150)
        }
        .overlay {
            if showCreateItem {
                Color.black.opacity(0.6).ignoresSafeArea()
                    .onTapGesture {
                        showCreateItem = false
                    }
                LLNewItemView(viewModel: viewModel) {
                    showCreateItem = false
                }
                .padding(.horizontal, 48)
            }
        }

    }
    
    @ViewBuilder
    private func itemImage(_ item: Item) -> some View {
        if let uiImage = item.uiImage {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width / 2 - 30)
        } else {
            Image("itemImgLL21")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width / 2 - 30)
        }
    }
    
    func isValidate() -> Bool {
        true
    }
    
    @ViewBuilder func textFiled<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 8)  {
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.linenBase)
            
            content()
        }
    }
}

#Preview {
    LLItemsView(viewModel: LLRelaxationViewModel())
}
