//
//  GoalSetPage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/25/22.
//

import SwiftUI

struct GoalSetPage: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var preferences: PreferencesManager
    
    @State private var currentGoal = "1260"
    
    
    var body: some View {
        
        ZStack {
            Color("GradGreen")
                .ignoresSafeArea()
            
            VStack {
                Text(currentGoal)
                    .foregroundColor(Color.white)
                    .font(.system(size: 70))
                    .fontWeight(.heavy)
                
                VStack {
                    HStack {
                        ForEach(1..<4) { number in
                            Spacer()
                            Button {
                                currentGoal += String(number)
                            } label: {
                                Text(String(number))
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            Spacer()
                        }
                    }
                    Spacer()
                    HStack {
                        ForEach(4..<7) { number in
                            Spacer()
                            Button {
                                currentGoal += String(number)
                            } label: {
                                Text(String(number))
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            Spacer()
                        }
                    }
                    Spacer()
                    HStack {
                        ForEach(7..<10) { number in
                            Spacer()
                            Button {
                                currentGoal += String(number)
                            } label: {
                                Text(String(number))
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            Spacer()
                        }
                    }
                    Spacer()
                    HStack {
                        
                        Spacer()
                        Text("   ")
                        Spacer()
                        
                        Spacer()
                        Button {
                            currentGoal += String("0")
                        } label: {
                            Text("0")
                                .font(.title2)
                                .foregroundColor(.white)
                                .bold()
                        }
                        Spacer()
                        
                        Spacer()
                        Button {
                            currentGoal = String(currentGoal.dropLast())
                            
                        } label: {
                            Image(systemName: "chevron.backward")
                                .foregroundColor(.white)
                                .font(Font.body.weight(.heavy))

                        }
                        Spacer()
                        
                    }
                    
                }
                .frame(width: 325, height: 250)
                .padding(.vertical, 50)

                
               
                
                
                Button {
                    preferences.testGoal = currentGoal
                    dismiss()
                } label: {
                    Text("Set Goal")
                        .frame(width: 125, height: 30)
                       
                }
                .tint(Color("ButtonGreen"))
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                
                
            }
            
        }
        
        
    }
}

struct GoalSetPage_Previews: PreviewProvider {
    static var previews: some View {
        GoalSetPage()
    }
}
