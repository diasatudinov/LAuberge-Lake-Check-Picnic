//
//  LLMenuView.swift
//  LAuberge Lake Check Picnic
//
//

import SwiftUI

struct BBMenuContainer: View {
    
    @AppStorage("firstOpenBB") var firstOpen: Bool = true
    var body: some View {
        NavigationStack {
            ZStack {
                if firstOpen {
                    LLOnboardingView(getStartBtnTapped: {
                        firstOpen = false
                    })
                } else {
                    LLMenuView()
                }
            }
        }
    }
}

struct LLMenuView: View {
    @State var selectedTab = 0
    @StateObject var relaxationViewModel = LLRelaxationViewModel()
    private let tabs = ["My dives", "Calendar", "Stats"]
        
    var body: some View {
        ZStack {
            
            switch selectedTab {
            case 0:
                LLTypeView(viewModel: relaxationViewModel)
            case 1:
                LLItemsView(viewModel: relaxationViewModel)
            case 2:
                LLActivitiesView(viewModel: relaxationViewModel)
            default:
                Text("default")
            }
            VStack {
                Spacer()
                
                HStack(spacing: 60) {
                    ForEach(0..<tabs.count) { index in
                        Button(action: {
                            selectedTab = index
                        }) {
                            VStack {
                                Image(selectedTab == index ? selectedIcon(for: index) : icon(for: index))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 44)
                                
                                Text(text(for: index))
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundStyle(selectedTab == index ? .regalAccent : .deepPine)
                            }
                            
                        }
                        
                    }
                }
                .padding(.top, 10).padding(.bottom, 22)
                .frame(maxWidth: .infinity)
                .background(.pineShade)
                .clipShape(RoundedRectangle(cornerRadius: 0))
                
            }
            .ignoresSafeArea()
            
            
        }
    }
    
    private func icon(for index: Int) -> String {
        switch index {
        case 0: return "tab1Icon"
        case 1: return "tab2Icon"
        case 2: return "tab3Icon"
        default: return ""
        }
    }
    
    private func selectedIcon(for index: Int) -> String {
        switch index {
        case 0: return "tab1IconSelected"
        case 1: return "tab2IconSelected"
        case 2: return "tab3IconSelected"
        default: return ""
        }
    }
    
    private func text(for index: Int) -> String {
        switch index {
        case 0: return "Types"
        case 1: return "Items"
        case 2: return "Activities"
        default: return ""
        }
    }
}


#Preview {
    LLMenuView()
}
