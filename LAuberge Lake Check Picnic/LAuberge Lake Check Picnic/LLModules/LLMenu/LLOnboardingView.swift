//
//  BBOnboardingView.swift
//  LAuberge Lake Check Picnic
//
//


import SwiftUI

struct LLOnboardingView: View {
    
    var getStartBtnTapped: () -> ()
    @State var count = 0
    
    var onbImage: Image {
        switch count {
        case 0:
            Image(.onboardingImg1)
        case 1:
            Image(.onboardingImg2)
        case 2:
            Image(.onboardingImg3)
        default:
            Image(.onboardingImg1)
        }
    }
    
    var onbTitle: String {
        switch count {
        case 0:
            "Pack in Minutes"
        case 1:
            "Plan the Perfect Day"
        case 2:
            "Relax. It’s All Set"
        default:
            "Pack in Minutes"
        }
    }
    
    var onbDescription: String {
        switch count {
        case 0:
            "We’re creating a smart checklist for your lakeside escape - nothing extra, nothing forgotten."
        case 1:
            "From relaxing moments to active fun - your lakeside activities, perfectly planned."
        case 2:
            "Your plan is ready. All that’s left is to enjoy the water and the moment."
        default:
            "From relaxing moments to active fun - your lakeside activities, perfectly planned."
        }
    }
    
    var body: some View {
        VStack {
            onbImage
                .resizable()
                .scaledToFit()
                .ignoresSafeArea(edges: .top)
            
            VStack {
                Text(onbTitle)
                    .font(.system(size: 32, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.linenBase)
                
                Text(onbDescription)
                    .font(.system(size: 20, weight: .regular))
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                
            }.padding(.horizontal, 16)
            
            Spacer()
            
            VStack {
                Button {
                    if count < 2 {
                        withAnimation {
                            count += 1
                        }
                    } else {
                        getStartBtnTapped()
                    }
                } label: {
                    Text(count < 2 ? "Next" : "Get Started")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.vertical, 13)
                        .frame(maxWidth: .infinity)
                        .background(.regalAccent)
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                        .padding(.horizontal, 20)
                }
            }.padding(.bottom, 50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.deepPine)
        .ignoresSafeArea()
    }
}

#Preview {
    LLOnboardingView(getStartBtnTapped: { })
}
