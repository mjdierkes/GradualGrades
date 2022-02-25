//
//  CarouselView.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/3/22.
//

import SwiftUI

struct SnapCarousel: View {
    @EnvironmentObject var UIState: UIStateModel
    @Binding var items: [Card]
//    let namespace: Namespace.ID

    var body: some View {
        let spacing: CGFloat = 16
        let widthOfHiddenCards: CGFloat = 10 /// UIScreen.main.bounds.width - 10
        let cardHeight: CGFloat = 175
        
        return Canvas {
            /// TODO: find a way to avoid passing same arguments to Carousel and Item
            Carousel(
                numberOfItems: CGFloat(items.count),
                spacing: spacing,
                widthOfHiddenCards: widthOfHiddenCards
            ) {
                ForEach($items, id: \.self.id) { item in
                    Item(
                        _id: Int(item.id),
                        spacing: spacing,
                        widthOfHiddenCards: widthOfHiddenCards,
                        cardHeight: cardHeight
                    ) {
                            CardView(card: item)
//                            .matchedGeometryEffect(id: item.wrappedValue.id, in: namespace)
//                            .onTapGesture {
//                                withAnimation(.spring()){
//                                    UIState.currentCard = item.wrappedValue
//                                    UIState.showDetailPage = true
//                                }
//                            }
                    }
                
                    .background(Color("Background"))
                    .cornerRadius(8)
                    .transition(AnyTransition.slide)
                    .animation(.spring())
                }
            }
        }
    }

}


struct Card: Codable, Hashable, Identifiable {
    var id: Int
    var name: String = ""
    var className: String = ""
    var dueDate: String = ""
    var assignment: Assignment
}

public class UIStateModel: ObservableObject {
    @Published var activeCard: Int = 0
    @Published var screenDrag: Float = 0.0
    
    // Detail Hero Page..
    @Published var showDetailPage: Bool = false
    @Published var currentCard: Card?
    
    // showing Detail content a bit later...
    @Published var showDetailContent: Bool = false
    
    // For Hero Animation
    // Using Namespace...
}

struct Carousel<Items : View> : View {
    let items: Items
    let numberOfItems: CGFloat //= 8
    let spacing: CGFloat //= 16
    let widthOfHiddenCards: CGFloat //= 32
    let totalSpacing: CGFloat
    let cardWidth: CGFloat
    
    @GestureState var isDetectingLongPress = false
    
    @EnvironmentObject var UIState: UIStateModel
        
    @inlinable public init(
        numberOfItems: CGFloat,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        @ViewBuilder _ items: () -> Items) {
        
        self.items = items()
        self.numberOfItems = numberOfItems
        self.spacing = spacing
        self.widthOfHiddenCards = widthOfHiddenCards
        self.totalSpacing = (numberOfItems - 1) * spacing
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards*2) - (spacing*2) //279
        
    }
    
    var body: some View {
        let totalCanvasWidth: CGFloat = (cardWidth * numberOfItems) + totalSpacing
        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width) / 2
        let leftPadding = widthOfHiddenCards + spacing
        let totalMovement = cardWidth + spacing
                
        let activeOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard))
        let nextOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard) + 1)

        var calcOffset = Float(activeOffset)
        
        if (calcOffset != Float(nextOffset)) {
            calcOffset = Float(activeOffset) + UIState.screenDrag
        }
        
        return HStack(alignment: .center, spacing: spacing) {
            items
        }
        .offset(x: CGFloat(calcOffset), y: 0)
        .gesture(DragGesture().updating($isDetectingLongPress) { currentState, gestureState, transaction in
            self.UIState.screenDrag = Float(currentState.translation.width)
            
        }.onEnded { value in
            self.UIState.screenDrag = 0
            
            if (value.translation.width < -50 && UIState.activeCard != Int(numberOfItems - 1)) {
                self.UIState.activeCard = self.UIState.activeCard + 1
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
            
            if (value.translation.width > 50 && UIState.activeCard != 0) {
                self.UIState.activeCard = self.UIState.activeCard - 1
                let impactMed = UIImpactFeedbackGenerator(style: .light)
                impactMed.impactOccurred()
            }
        })
    }
}

struct Canvas<Content : View> : View {
    let content: Content
    @EnvironmentObject var UIState: UIStateModel
    
    @inlinable init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color("BackgroundGray").edgesIgnoringSafeArea(.all))
    }
}

struct Item<Content: View>: View {
    @EnvironmentObject var UIState: UIStateModel
    let cardWidth: CGFloat
    let cardHeight: CGFloat

    var _id: Int
    var content: Content

    @inlinable public init(
        _id: Int,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        cardHeight: CGFloat,
        @ViewBuilder _ content: () -> Content
    ) {
        self.content = content()
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards*2) - (spacing*2) //279
        self.cardHeight = cardHeight
        self._id = _id
    }

    var body: some View {
        content
            .frame(width: cardWidth, height: _id == UIState.activeCard ? cardHeight : cardHeight - 60, alignment: .center)
    }
}

struct DetailPage: View {
    
    @EnvironmentObject var UIState: UIStateModel
//    let namespace: Namespace.ID



    
    var body: some View {
        ZStack{
            
            if let currentCard = UIState.currentCard, UIState.showDetailPage {
                
                Rectangle()
                    .fill(.white)
//                    .matchedGeometryEffect(id: currentCard.id, in: namespace)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 15) {
                                        
                    HStack {
                        Button {
                            withAnimation{
                                // Closing View..
                                UIState.showDetailContent = false
                                UIState.showDetailPage = false
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Color.white.opacity(0.6))
                                .clipShape(Circle())
                        }
                        Spacer()
                    }
                    .padding()
                    
                    Text(currentCard.dueDate)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .padding(.top)

                    Text(currentCard.name)
                        .font(.title.bold())
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        // Sample Content...
                        Text(content)
                            .kerning(1.1)
                            .lineSpacing(8)
                            .multilineTextAlignment(.leading)
                            .padding(.top,10)
                    }
                }
                .opacity(UIState.showDetailPage ? 1 : 0)
                .foregroundColor(.black)
                .padding()
                // Moving view to top Without Any Spacers..
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        
                        withAnimation{
                            UIState.showDetailPage = true
                        }
                    }
                }
            }
        }
    }
    
    
        let content = "Humans have long used cognitive enhancement methods to expand the proficiency and range of the various mental activities that they engage in, including writing to store and retrieve information, and computers that allow them to perform myriad activities that are now commonplace in the internet age. Neuroenhancement describes the use of neuroscience-based techniques for enhancing cognitive function by acting directly on the human brain and nervous system, altering its properties to increase performance. Cognitive neuroscience has now reached the point where it may begin to put theory derived from years of experimentation into practice. This special issue includes 16 articles that employ or examine a variety of neuroenhancement methods currently being developed to increase cognition in healthy people and in patients with neurological or psychiatric illness.This includes transcranial electromagnetic stimulation methods, such as transcranial direct current stimulation (tDCS) and transcranial magnetic stimulation (TMS), along with deep brain stimulation, neurofeedback, behavioral training techniques, and these and other techniques in conjunction with neuroimaging."
}
