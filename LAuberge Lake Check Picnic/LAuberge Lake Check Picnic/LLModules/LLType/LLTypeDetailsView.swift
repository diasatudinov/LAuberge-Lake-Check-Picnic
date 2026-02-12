//
//  LLTypeDetailsView.swift
//  LAuberge Lake Check Picnic
//
//

import SwiftUI

struct LLTypeDetailsView: View {
    private enum TypeState: String, CaseIterable, Identifiable {
        case items
        case activities
        
        var id: String { rawValue }
        var text: String {
            switch self {
            case .items:
                "Items"
            case .activities:
                "Activities"
            }
        }
    }
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: LLRelaxationViewModel
    let type: TypeModel
    @State private var state: TypeState = .items
    @State private var showItemsList = false
    @State private var showActivitiesList = false
    var body: some View {
        VStack(spacing: 20) {
           
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.linenBase)
                    
                    
                    Image(type.mood)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 25)
                    
                    Text(type.name)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.linenBase)
                }
                
                Spacer()
                
                Button {
                    viewModel.delete(type: type)
                    dismiss()
                } label: {
                    Image(systemName: "trash")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                        .foregroundStyle(.white)
                    
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.bottom, 10)
            .background(.pineShade)
            
            HStack(spacing: 0) {
                ForEach(TypeState.allCases, id: \.id) { state in
                    Text(state.text)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(self.state == state ? .pineShade : .white )
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 6)
                        .background(self.state == state ? .regalAccent : .clear)
                        .clipShape(
                            UnevenRoundedRectangle(
                                topLeadingRadius: self.state == .items ? 100 : 0,
                                bottomLeadingRadius: self.state == .items ? 100 : 0,
                                bottomTrailingRadius: self.state == .activities ? 100 : 0,
                                topTrailingRadius: self.state == .activities ? 100 : 0,
                                style: .circular
                            )
                        )
                        .onTapGesture {
                            self.state = state
                        }
                }
            }
            .frame(maxWidth: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 100)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.regalAccent)
            }
            .padding(.horizontal, 95)
            
            if state == .items {
                if type.items.isEmpty {
                    VStack(spacing: 12) {
                        VStack(spacing: 12) {
                            Text("No items yet")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(.linenBase)
                            
                            Text("Add what you need, we’ll build a checklist for you.")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxHeight: .infinity, alignment: .center)
                        .padding(.bottom)
                    }
                    .padding(.horizontal, 16)
                } else {
                    List {
                        ForEach(type.items, id: \.id) { item in
                            HStack {
                                Circle()
                                    .fill(.clear)
                                    .frame(height: 24)
                                    .overlay {
                                        Circle()
                                            .stroke(lineWidth: 1)
                                            .foregroundStyle(.regalAccent)
                                    }
                                    .overlay {
                                        if item.check {
                                            Image(systemName: "checkmark")
                                                .foregroundStyle(.green)
                                                .bold()
                                        }
                                    }
                                
                                Text(item.name)
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundStyle(.linenBase)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                
                                Text("x\(item.quantity)")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundStyle(.linenBase)
                            }
                            .padding(.vertical, 10).padding(.horizontal, 12)
                            .background(.pineShade)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 12, trailing: 16))
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    viewModel.deleteItemType(type: type, item: item)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .onTapGesture {
                                viewModel.checkItemToggle(type: type, item: item)
                            }
                        }
                    }
                    .listStyle(.plain)
                    
                    
                }
                
                HStack {
                    Button {
                        showItemsList = true
                    } label: {
                        Text("Add Item")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(.vertical, 21)
                            .frame(maxWidth: .infinity)
                            .background(.regalAccent)
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                    }
                    
                    Button {
                        viewModel.generateChecklistOfItems(type: type)
                    } label: {
                        Text("Generate Checklist")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(.vertical, 21)
                            .frame(maxWidth: .infinity)
                            .background(.regalAccent)
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                    }
                }
                .padding(.horizontal, 20)

            } else {
                if type.activities.isEmpty {
                    VStack(spacing: 12) {
                        VStack(spacing: 12) {
                            Text("No activities planned")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(.linenBase)
                            
                            Text("Choose how you want to spend your day by the water.")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxHeight: .infinity, alignment: .center)
                        .padding(.bottom)
                    }
                    .padding(.horizontal, 16)
                } else {
                    List {
                        ForEach(type.activities, id: \.id) { activity in
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
                            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 12, trailing: 16))
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    viewModel.deleteActivityType(type: type, activity: activity)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    
                    
                }
                
                HStack {
                    Button {
                        showActivitiesList = true
                    } label: {
                        Text("Add Activity")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(.vertical, 21)
                            .frame(maxWidth: .infinity)
                            .background(.regalAccent)
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                    }
                    
                    Button {
                        viewModel.generateChecklistOfActivities(type: type)
                    } label: {
                        Text("Generate Activity Plan")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(.vertical, 21)
                            .frame(maxWidth: .infinity)
                            .background(.regalAccent)
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                    }
                }
                .padding(.horizontal, 20)

            }
            
        }
        .background(.deepPine)
        .sheet(isPresented: $showItemsList) {
            ItemsBottomSheet(viewModel: viewModel, type: type, items: viewModel.items)
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showActivitiesList) {
            ActivitiesBottomSheet(viewModel: viewModel, type: type, activities: viewModel.activities)
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
        
    }
    
    private func delete(at offsets: IndexSet) {
        //            items.remove(atOffsets: offsets)
    }
}

#Preview {
    LLTypeDetailsView(viewModel: LLRelaxationViewModel(), type:
                        TypeModel(
                            name: "Picnic by the Lake",
                            mood: "typeImageLL1",
                            items: [
                                Item(name: "Towel", quantity: "1", typesOfRecreation: [], check: false),
                                
                                
                            ],
                            activities: []
                        )
    )
}
