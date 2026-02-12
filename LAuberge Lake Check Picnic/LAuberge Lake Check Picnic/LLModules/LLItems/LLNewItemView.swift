//
//  LLNewItemView.swift
//  LAuberge Lake Check Picnic
//
//


import SwiftUI

struct LLNewItemView: View {
    @ObservedObject var viewModel: LLRelaxationViewModel
    let onNewTypeCreated: () -> ()
    
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    @State private var title: String = ""
    @State private var quantity: String = ""
        
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
    ]
    
    @State private var selectedTypeIDs: Set<UUID> = []

    var body: some View {
        VStack(spacing: 16) {
            Text("Add item")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.linenBase)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if let uiImage = selectedImage {
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
                    .onTapGesture {
                        showingImagePicker = true
                    }
            } else {
                Image("imagePlaceholderLL")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
                    .padding(.vertical, 20).padding(.horizontal, 65)
                    .background(.pineShade)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                            .foregroundStyle(.regalAccent)
                    }
                    .onTapGesture {
                        showingImagePicker = true
                    }
            }
            
            textFiled(title: "Name:") {
                TextField("Name", text: $title)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.linenBase)
                    .padding(.vertical, 5).padding(.horizontal, 8)
                    .background(.pineShade)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
            }
            
            textFiled(title: "Quantity:") {
                TextField("Quantity", text: $quantity)
                    .font(.system(size: 14, weight: .regular))
                    .keyboardType(.numberPad)
                    .foregroundStyle(.linenBase)
                    .padding(.vertical, 5).padding(.horizontal, 8)
                    .background(.pineShade)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
            }
            
            textFiled(title: "Types of recreation:") {
                MultiSelectDropdown(
                    options: viewModel.types,
                    selectedIDs: $selectedTypeIDs
                )
            }
            
            Button {
                if isValidate() {
                    let item = Item(name: title, quantity: quantity, typesOfRecreation: [], check: false)
                    viewModel.add(item: item)
                    viewModel.addItemToSelectedTypes(selectedTypeIDs: selectedTypeIDs, item: item)
                    onNewTypeCreated()
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
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(selectedImage: $selectedImage, isPresented: $showingImagePicker)
        }
    }
    
    func loadImage() {
        if let selectedImage = selectedImage {
            print("Selected image size: \(selectedImage.size)")
        }
    }
    
    func isValidate() -> Bool {
        !title.isEmpty && !quantity.isEmpty
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
    LLNewItemView(viewModel: LLRelaxationViewModel(), onNewTypeCreated: {})
}

struct MultiSelectDropdown: View {
    let options: [TypeModel]

    @Binding var selectedIDs: Set<UUID>
    @State private var isOpen = false

    var body: some View {
        ZStack(alignment: .topLeading) {

            // "Поле"
            Button {
                withAnimation(.spring(response: 0.25, dampingFraction: 0.9)) {
                    isOpen.toggle()
                    UIApplication.shared.hideKeyboard()
                }
            } label: {
                HStack {
                    let selectedTypes = options.filter { selectedIDs.contains($0.id) }.map(\.name)
                    let list = selectedTypes.sorted()

                    Text(!selectedIDs.isEmpty ? list.count <= 2 ? list.joined(separator: ", ") : "\(list[0]), \(list[1]) +\(list.count - 2)" : "Type of recreation")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.slateTone)
                        .padding(.vertical, 5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: isOpen ? "chevron.up" : "chevron.down")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.linenBase)
                }
                .padding(.horizontal, 8)
                .background(.pineShade)
                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 8, bottomLeadingRadius: isOpen ? 0 : 8, bottomTrailingRadius: isOpen ? 0 : 8, topTrailingRadius: 8))
            }
            .buttonStyle(.plain)

            if isOpen {

                dropdownList
                    .padding(.top, 25)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
    }

    private var dropdownList: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(options, id: \.self) { option in
                        optionRow(option)
                        Divider().background(Color.white.opacity(0.18))
                    }
                }
            }
            .frame(maxHeight: 240)
        }
        .background(
            UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 10, bottomTrailingRadius: 10, topTrailingRadius: 0)
                .fill(Color.pineShade)
        )
    }

    private func optionRow(_ option: TypeModel) -> some View {
        Button {
            toggle(option)
        } label: {
            HStack(spacing: 12) {
                Text(option.name)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.linenBase)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Circle()
                    .fill(.clear)
                    .frame(height: 14)
                    .overlay {
                        Circle()
                            .stroke(lineWidth: 1)
                            .foregroundStyle(.regalAccent)
                    }
                    .overlay {
                        if selectedIDs.contains(option.id) {
                            Image(systemName: "checkmark")
                                .frame(height: 7)
                                .foregroundStyle(.green)
                                .bold()
                        }
                    }
               
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
        }
        .buttonStyle(.plain)
    }

    private func checkbox(isChecked: Bool) -> some View {
        Image(systemName: isChecked ? "checkmark.square.fill" : "square")
            .foregroundColor(isChecked ? .white : .white.opacity(0.85))
            .font(.system(size: 18, weight: .semibold))
    }

    private func toggle(_ option: TypeModel) {
        if selectedIDs.contains(option.id) {
            selectedIDs.remove(option.id)
        } else {
            selectedIDs.insert(option.id)
        }
    }
}
