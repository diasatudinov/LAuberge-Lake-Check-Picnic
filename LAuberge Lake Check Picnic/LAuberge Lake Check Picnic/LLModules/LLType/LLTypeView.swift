//
//  LLTypeView.swift
//  LAuberge Lake Check Picnic
//
//

import SwiftUI

struct LLTypeView: View {
    @ObservedObject var viewModel: LLRelaxationViewModel
    var body: some View {
        VStack {
            Text("Types")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.linenBase)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
                .background(.pineShade)
            
            if viewModel.types.isEmpty {
                    VStack(spacing: 12) {
                        VStack(spacing: 12) {
                            Text("Create Your First Lake Getaway")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(.linenBase)
                            
                            Text("Pick a ready-made scenario or create your own - we’ll prepare everything for your day by the water.")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxHeight: .infinity, alignment: .center)
                        .padding(.bottom)
                    }
                    .padding(.horizontal, 16)
                } else {
                    ScrollView(showsIndicators: false) {
                    }
                }
            
        }
        .background(.deepPine)
        .overlay(alignment: .bottomTrailing) {
            Button {
                
            } label: {
                Text("+ Create Type")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 32)                    .background(.regalAccent)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .padding(.horizontal, 20)
                    .padding(.bottom, 150)
            }
        }
    }
}

#Preview {
    LLTypeView(viewModel: LLRelaxationViewModel())
}
