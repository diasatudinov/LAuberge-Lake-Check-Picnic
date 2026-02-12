//
//  LLActivitiesView.swift
//  LAuberge Lake Check Picnic
//
//

import SwiftUI

struct LLActivitiesView: View {
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
            Text("Activities")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.linenBase)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
                .background(.pineShade)
            
            VStack {
                List {
                    ForEach(viewModel.activities, id: \.id) { activity in
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
                                viewModel.delete(activity: activity)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }.padding(.bottom, 80)
            
        }
        .background(.deepPine)
        .overlay(alignment: .bottomTrailing) {
            Button {
                showCreateItem = true
            } label: {
                Text("+ Add Activity")
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
                LLNewActivityView(viewModel: viewModel) {
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
    LLActivitiesView(viewModel: LLRelaxationViewModel())
}
