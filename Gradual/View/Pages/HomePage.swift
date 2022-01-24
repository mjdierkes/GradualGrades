//
//  HomePage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import SwiftUI

struct HomePage: View {
    
    @EnvironmentObject var manager: AppManager
    @State private var liveGPA = ""
    @State private var showingSheet = false
    @State private var showingAccountPage = false

    var body: some View {
        
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                NavigationLink(destination: LoginPage(), isActive: .constant(manager.student == nil)) {}
                
                VStack(alignment: .leading){
                    Text("Good \(dayTime()) \(manager.firstName)")
                        .padding(.horizontal)
                        .font(.title2)
                        .font(.system(.body, design: .rounded))
                    
                    Text(manager.gpa?.roundedWeightedGPA ?? "ERROR")
                        .font(.largeTitle)
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.medium)
                        .padding(.horizontal)
                        .padding(.top, 1)
                    
                    Text("Live GPA")
                        .bold()
                        .foregroundColor(Color("GradGreen"))
                        .padding(.horizontal)
                        .padding(.bottom, 1)
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                    }
                    
                    if manager.cards.count > 0 {
                        ZStack {
                            Color("BackgroundGray")
                            ForEach(0..<manager.cards.count, id: \.self) { index in
                                CardView() {
                                    withAnimation {
                                        manager.removeCard(at: index)
                                    }
                                }
                            }
                        }
                        .frame(height: 200)
                    }
                    
                    
                    
                    Text("Grades")
                        .padding()
                        .font(.title2)
                        .font(.system(.body, design: .rounded))
                    
                    ForEach($manager.classes) { details in
                        NavigationLink(destination: AssignmentPage(classDetails: details)) {
                            SimpleClassView(classData: details)
                        }
                        .tint(.black)
                    }
                    
                }
            }
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingSheet.toggle()
                    } label: {
                        ZStack {
                            HStack {
                                Image(systemName: "star.circle.fill")
                                Text("Free Premium")
                                    .font(.system(size: 14))
                            }
                            .foregroundColor(Color("GradGreen"))
                            .padding(.vertical, 3)
                            .padding(.horizontal, 12)
                            .background(Color("LowGreen"))
                            .cornerRadius(50)
                        }
                    }

                }
                
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAccountPage.toggle()
                    } label: {
                        Image(systemName: "person")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                    }
                    .tint(.black)
                    .scaleEffect(0.9)
                    .padding(.trailing)
                }
                
            }
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $showingSheet){
                PremiumPage()
            }
            .sheet(isPresented: $showingAccountPage){
                AccountPage()
            }
        }
        
    }
    
    func dayTime() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 0..<12 :
            return "Morning"
        case 12..<24 :
            return "Afternoon"
        default:
            return "Day"
        }
    }
    
}

struct HomePage_Previews: PreviewProvider {
    @StateObject static var manager = AppManager()
    static var previews: some View {
        HomePage()
            .environmentObject(manager)
    }
}
