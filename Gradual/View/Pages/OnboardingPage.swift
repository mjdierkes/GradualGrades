//
//  OnboardingPage.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/20/22.
//

import SwiftUI


struct OnboardingPage: View {
    
    let notificationService = NotificationService()
    var screenSize: CGSize
    @State var offset: CGFloat = 0
    @Binding var presentingView: Bool
    @AppStorage("isNewUser") var isNewUser = true

    
    var intros : [Intro] = [
        Intro(image: "Relax", title: "Learning Made Simple", description: "Check your grades at a glance, and easily see grade changes and updates."),
        Intro(image: "Trophy", title: "Raise the Bar", description: "With Live GPA calculations, you can be sure to stay on top of your game."),
        Intro(image: "Notifications", title: "Stay in the Loop", description: "With notifications, you can see your new test scores as soon as they're put in.", isBeta: true)
    ]
    
    var body: some View {
        
        VStack(spacing: 50){
            
            Text("GRADUAL")
                .fontWeight(.semibold)
                .tracking(3)
                .padding(.top, 20)
            
            OffsetPageTabView(offset: $offset) {
                
                
                HStack(spacing: 0){
                    ForEach(intros){intro in
                        VStack {
                            
                            Image(intro.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: screenSize.height / 3.5)
                            
                            VStack(spacing: 22) {
                                Text(intro.title)
                                    .foregroundColor(Color("Text"))
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                    .font(.title)
                                
                                Text(intro.description)
                                    .foregroundColor(Color("Text"))

                                if intro.isBeta {
                                    Text("BETA")
                                        .bold()
                                        .padding(.vertical, 3)
                                        .padding(.horizontal, 7)
                                        .foregroundColor(Color.white)
                                        .background(Color("PerfectlyInsane"))
                                        .cornerRadius(7)
                                }
                               
                            }
                            .foregroundStyle(.black)
                            .padding(.top,50)
                            
                        }
                        .padding(25)
                        .frame(width: screenSize.width)
                    }
                }
                .background(Color("Background"))
                .multilineTextAlignment(.center)
                
            }
            .frame(height: screenSize.height / 1.5)
            // Indicators...
            
            
            VStack {
                HStack(spacing: 12){
                    
                    ForEach(intros.indices,id: \.self){index in
                        
                        Capsule()
                            .fill(Color("Text"))
                        // increasing width for only current index...
                            .frame(width: getIndex() == index ? 20 : 7, height: 7)
                    }
                }
                .overlay(
                    Capsule()
                        .fill(Color("Text"))
                        .frame(width: 20, height: 7)
                        .offset(x: getIndicatorOffset())
                    
                    ,alignment: .leading
                )
                .offset(y: -15)
                
                Button {
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                    let index = min(getIndex() + 1, intros.count - 1)
                    if getIndex() == intros.count - 1 {
                        withAnimation {
                            notificationService.requestAccess()
                            presentingView = false
                            isNewUser = false
                        }
                    }
                    offset = CGFloat(index) * screenSize.width
                    
                } label: {
                    Text("Next")
                        .foregroundColor(Color("FlippedText"))
                        .frame(minWidth: 275, minHeight: 32)
                }
                .tint(Color("Text"))
                .buttonStyle(.borderedProminent)
            }
            
            
            
            
            
        }
        .background(Color("Background"))
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        // Animating when index Changes...
        .animation(.easeInOut,value: getIndex())
        
    }
    
    // offset for indicator...
    func getIndicatorOffset()->CGFloat{
        
        let progress = offset / screenSize.width
        
        // 12 = spacing
        // 7 = Circle size...
        
        let maxWidth: CGFloat = 12 + 7
        
        return progress * maxWidth
    }
    
    // Expading index based on offset...
    func getIndex()->Int{
        
        let progress = round(offset / screenSize.width)
        
        // For Saftey...
        let index = min(Int(progress), intros.count - 1)
        return index
    }
}



struct Intro: Identifiable{
    var id = UUID()
    var image: String
    var title: String
    var description: String
    
    var isBeta: Bool = false
}


//struct OnboardingPage_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingPage()
//    }
//}
