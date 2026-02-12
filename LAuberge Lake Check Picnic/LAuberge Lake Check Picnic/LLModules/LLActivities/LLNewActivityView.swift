struct LLNewActivityView: View {
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