//
//  LLTypeCellView.swift
//  LAuberge Lake Check Picnic
//
//

import SwiftUI

struct LLTypeCellView: View {
    let type: TypeModel
    var body: some View {
        VStack {
            Image(type.mood)
                .resizable()
                .scaledToFit()
            
            Text(type.name)
                .font(.system(size: 11, weight: .bold))
                .foregroundStyle(.white)
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(10)
        .background(Color.pineShade)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .foregroundStyle(.regalAccent)
        }
    }
}

#Preview {
    LLTypeCellView(type:
                    TypeModel(
                        name: "Picnic by the Lake",
                        mood: "typeImageLL1",
                        items: [],
                        activities: []
                    )
    )
}
