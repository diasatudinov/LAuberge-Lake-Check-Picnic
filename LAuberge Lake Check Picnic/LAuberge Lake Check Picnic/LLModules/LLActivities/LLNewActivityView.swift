//
//  LLNewActivityView.swift
//  LAuberge Lake Check Picnic
//
//
import SwiftUI

struct LLNewActivityView: View {
    @ObservedObject var viewModel: LLRelaxationViewModel
    let onNewTypeCreated: () -> ()
    
    @State private var title: String = ""
    @State private var participants: String = ""
    @State private var duration: String = ""

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
            Text("Add Activity")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.linenBase)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            textFiled(title: "Name:") {
                TextField("Name", text: $title)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.linenBase)
                    .padding(.vertical, 5).padding(.horizontal, 8)
                    .background(.pineShade)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
            }
            
            textFiled(title: "Participants:") {
                TextField("Participants", text: $participants)
                    .font(.system(size: 14, weight: .regular))
                    .keyboardType(.numberPad)
                    .foregroundStyle(.linenBase)
                    .padding(.vertical, 5).padding(.horizontal, 8)
                    .background(.pineShade)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
            }
            
            textFiled(title: "Duration:") {
                TextField("Duration", text: $duration)
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
                    let activity = Activity(name: title, participants: participants, duration: duration, typesOfRecreation: [])
                    viewModel.add(activity: activity)
                    viewModel.addActivityToSelectedTypes(selectedTypeIDs: selectedTypeIDs, activity: activity)
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
        !title.isEmpty && !participants.isEmpty && !duration.isEmpty
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
    LLNewActivityView(viewModel: LLRelaxationViewModel(), onNewTypeCreated: {})
}
