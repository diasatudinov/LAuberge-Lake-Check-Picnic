//
//  PicturesBottomSheet.swift
//  LAuberge Lake Check Picnic
//
//

import SwiftUI

struct ItemsBottomSheet: View {
    @ObservedObject var viewModel: LLRelaxationViewModel
    let type: TypeModel
    let items: [Item]
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    @State private var quantity: String = ""
    @State private var selectedItem: Item?
    
    var body: some View {
        ZStack {
            Color.deepPine.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(items, id: \.id) { item in
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
                        .onTapGesture {
                            selectedItem = item
                        }
                    }
                }
                .padding(.horizontal, 20).padding(.vertical)
                .padding(.bottom, 140)
            }
            
            if let selectedItem = selectedItem {
                Color.black.opacity(0.5).ignoresSafeArea()
                    .onTapGesture {
                        self.selectedItem = nil
                    }
                
                VStack(spacing: 16) {
                    Text(selectedItem.name)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.linenBase)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if let uiImage = selectedItem.uiImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / 2)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 1)
                                    .foregroundStyle(.regalAccent)
                            }
                    } else {
                        Image("itemImgLL21")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / 2)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 1)
                                    .foregroundStyle(.regalAccent)
                            }
                    }
                    
                    textFiled(title: "Quantity:") {
                        TextField("Quantity", text: $quantity)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.linenBase)
                            .keyboardType(.numberPad)
                            .padding(.vertical, 5).padding(.horizontal, 8)
                            .background(.pineShade)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                    }
                    
                    Button {
                        if isValidate() {
                            var item = selectedItem
                            item.quantity = quantity
                            viewModel.addItemType(type: type, item: item)
                            self.selectedItem = nil
                            quantity = ""
                        }
                    } label: {
                        Text("Save")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 62)                    .background(isValidate() ? .regalAccent : .slateTone)
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                    }
                }
                .padding()
                .background(.deepPine)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(.regalAccent)
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
        !quantity.isEmpty
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
    ItemsBottomSheet(viewModel: LLRelaxationViewModel(), type: TypeModel(name: "", mood: "", items: [], activities: []), items: LLRelaxationViewModel().items
    )
}
