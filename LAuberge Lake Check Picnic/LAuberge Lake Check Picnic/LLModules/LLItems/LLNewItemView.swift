import SwiftUI

struct LLNewItemView: View {
    @ObservedObject var viewModel: LLRelaxationViewModel
    let onNewTypeCreated: () -> ()
    
    @State private var title: String = ""
    @State private var mood: String = "moodImgLL1"
    @State private var allMoods: [String] =
    [
        "moodImgLL1",
        "moodImgLL2",
        "moodImgLL3",
        "moodImgLL4",
        "moodImgLL5",
        "moodImgLL6",
        "moodImgLL7",
        "moodImgLL8",
        "moodImgLL9",
        "moodImgLL10",
        "moodImgLL11",
        "moodImgLL12",
        "moodImgLL13",
        "moodImgLL14",
        "moodImgLL15",
        "moodImgLL16",
        "moodImgLL17",
        "moodImgLL18",
        "moodImgLL19",
        "moodImgLL20",
    ]
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Create Type")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.linenBase)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            textFiled(title: "Name") {
                TextField("Name", text: $title)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.linenBase)
                    .padding(.vertical, 5).padding(.horizontal, 8)
                    .background(.pineShade)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
            }
            
            textFiled(title: "Mood") {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(allMoods, id: \.self) { mood in
                        Image(mood)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                            .padding(3)
                            .background(self.mood == mood ? .regalAccent : .clear)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .onTapGesture {
                                self.mood = mood
                            }
                    }
                }
                .padding(.vertical, 6).padding(.horizontal, 10)
                .background(.pineShade)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
            }
            
            Button {
                if isValidate() {
                    let type = TypeModel(name: title, mood: mood, items: [], activities: [])
                    viewModel.add(type: type)
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
    }
    
    func isValidate() -> Bool {
        !title.isEmpty && !mood.isEmpty
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
    LLNewTypeView(viewModel: LLRelaxationViewModel(), onNewTypeCreated: {})
}