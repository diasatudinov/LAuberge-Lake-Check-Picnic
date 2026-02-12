//
//  ActivitiesBottomSheet.swift
//  LAuberge Lake Check Picnic
//
//

import SwiftUI

struct ActivitiesBottomSheet: View {
    @ObservedObject var viewModel: LLRelaxationViewModel
    let type: TypeModel
    let activities: [Activity]

    @State private var name: String = ""
    @State private var participants: String = ""
    @State private var duration: String = ""
    @State private var selectedActivity: Activity?
    
    var body: some View {
        ZStack {
            Color.deepPine.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 12) {
                    ForEach(activities, id: \.id) { activity in
                        HStack(spacing: 0) {
                            
                            Text(activity.name)
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(.linenBase)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("\(activity.participants) \(activity.participants == "1" ? "person": "people") · \(activity.duration) min")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(.linenBase)
                                
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 13)
                        .background(.pineShade)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .onTapGesture {
                            selectedActivity = activity
                            name = activity.name
                            participants = activity.participants
                            duration = activity.duration
                        }
                    }
                }
                .padding(.horizontal, 20).padding(.vertical)
                .padding(.bottom, 140)
            }
            
            if let selectedActivity = selectedActivity {
                Color.black.opacity(0.5).ignoresSafeArea()
                    .onTapGesture {
                        self.selectedActivity = nil
                    }
                
                VStack(spacing: 16) {
                    Text("Edit Activity")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.linenBase)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    textFiled(title: "Name:") {
                        TextField("Name", text: $name)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.linenBase)
                            .padding(.vertical, 5).padding(.horizontal, 8)
                            .background(.pineShade)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    textFiled(title: "Participants:") {
                        TextField("Participants", text: $participants)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.linenBase)
                            .keyboardType(.numberPad)
                            .padding(.vertical, 5).padding(.horizontal, 8)
                            .background(.pineShade)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    textFiled(title: "Duration:") {
                        TextField("Duration", text: $duration)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.linenBase)
                            .keyboardType(.numberPad)
                            .padding(.vertical, 5).padding(.horizontal, 8)
                            .background(.pineShade)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                    }
                    
                    Button {
                        if isValidate() {
                            var activity = selectedActivity
                            activity.name = name
                            activity.participants = participants
                            activity.duration = duration
                            viewModel.addActivityType(type: type, activity: activity)
                            self.selectedActivity = nil
                            name = ""
                            participants = ""
                            duration = ""
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
    ActivitiesBottomSheet(viewModel: LLRelaxationViewModel(), type: TypeModel(name: "", mood: "", items: [], activities: []),
                          activities: LLRelaxationViewModel().activities)
}
