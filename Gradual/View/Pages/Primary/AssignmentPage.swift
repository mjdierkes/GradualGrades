//
//  AssignmentPage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import SwiftUI
import SwiftUICharts

struct AssignmentPage: View {
    
    @Binding var classDetails: Class
    @EnvironmentObject var manager: AppManager
    @StateObject var doomManager = DoomsdayManager()
    @FocusState private var focused: Bool
    
    @AppStorage("isDogPerson") var isDogPerson = true

    let formatter = GradeFormatter()
    
    var body: some View {
        
        VStack {
            
            
            
            if classDetails.assignments.count == 0 {
                Group {
                    Spacer()
                    Image(isDogPerson ? "Zeus" : "CuteCat")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: isDogPerson ? 250 : 175)
                    Text("No Assignments Yet")
                        .padding()
                    Spacer()
                }
                .onTapGesture(count: 2) {
                    isDogPerson.toggle()
                }
                ClassInformation(classDetails: $classDetails)
            }
            
            else {
 
                ScrollView(.vertical, showsIndicators: false) {
                    
//                    LineChartView(data: [8,23,54,45,12,37,7,23,43], title: "Mobile App Programing", legend: "Average \(doomManager.overallAverage + "%")", form: ChartForm.extraLarge, rateValue: 20, dropShadow: false)
                    HStack {
                        
                        Text("Average")
                            .font(.title2)
                            .bold()
                        
                        Spacer()

                        
                        Text("\(doomManager.overallAverage)%")
                            .foregroundColor(formatter.getColor(from: Double(doomManager.overallAverage)))
                            .font(.title2)
                            .bold()

                    }
                    .padding()
                    .background(Color("BackgroundGray"))
                    .cornerRadius(14)
                    
                    
                    VStack(alignment: .leading) {
                        MajorAssignments()
                        MinorAssignments()
                        PlainAssignments()
                    }
                    .padding()
                    Spacer()
                    ClassInformation(classDetails: $classDetails)
                }
            }
        }
        .focused($focused)
        .onChange(of: doomManager.calculatorActive, perform: { newValue in
            doomManager.overallAverage = classDetails.grade
        })
        .onAppear {
            doomManager.build(from: classDetails)
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Done") {
                    focused = false
                }
            }
        }
        .environmentObject(doomManager)
        .navigationBarTitle(classDetails.name)
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

private struct MajorAssignments: View {
    
    @EnvironmentObject var doomManager: DoomsdayManager
    
    let formatter = GradeFormatter()
    
    
    var body: some View {
        if doomManager.majorAssignments.count > 0{
            
            HStack {
                Text("Majors")
                    .font(.title2)
                    .bold()
                
                Spacer()
                
                if let average = (!doomManager.calculatorActive) ? doomManager.editableMajor : doomManager.majorAverage {
                    Text(String(average) + "%")
                        .foregroundColor(formatter.getColor(from: average))
                        .font(.title2)
                        .bold()
                }
            }
            .padding(.bottom)
            .onChange(of: doomManager.calculatorActive) { newValue in
                doomManager.editableMajor = doomManager.majorAverage
            }
            
            ForEach($doomManager.majorAssignments) { assessment in
                SimpleAssignmentView(assessment: assessment)
            }
            
            Spacer()
                .frame(height: 40)
        }
        
    }
}


private struct MinorAssignments: View {
    
    @EnvironmentObject var doomManager: DoomsdayManager
    
    let formatter = GradeFormatter()
    
    
    var body: some View {
        if doomManager.minorAssignments.count > 0{
            
            HStack {
                Text("Minors")
                    .font(.title2)
                    .bold()
                
                Spacer()
                
                if let average = (!doomManager.calculatorActive) ? doomManager.editableMinor : doomManager.minorAverage {
                    Text(String(average) + "%")
                        .foregroundColor(formatter.getColor(from: average))
                        .font(.title2)
                        .bold()
                }
            }
            .padding(.bottom)
            .onChange(of: doomManager.calculatorActive) { newValue in
                doomManager.editableMinor = doomManager.minorAverage
            }
            
            ForEach($doomManager.minorAssignments) { assessment in
                SimpleAssignmentView(assessment: assessment)
            }
            
            Spacer()
                .frame(height: 40)
        }
        
        
    }
}

private struct PlainAssignments: View {
    
    @EnvironmentObject var doomManager: DoomsdayManager
    
    let formatter = GradeFormatter()
    
    
    var body: some View {
        if doomManager.nonAssignments.count > 0{
                VStack {
                    HStack {
                        Text("Non Graded")
                            .font(.title2)
                            .bold()
                        
                        Spacer()
                        
                        if let average = (!doomManager.calculatorActive) ? doomManager.editablePlain : doomManager.plainAverage {
                            Text(String(average) + "%")
                                .foregroundColor(formatter.getColor(from: average))
                                .font(.title2)
                                .bold()
                        }
                    }
                    .padding(.bottom)
                    .onChange(of: doomManager.calculatorActive) { newValue in
                        doomManager.editablePlain = doomManager.plainAverage
                    }
                    
                    ForEach($doomManager.nonAssignments) { assessment in
                        SimpleAssignmentView(assessment: assessment, isEditable: false)
                    }
                    
                    Spacer()
                        .frame(height: 40)
                }
        }
        
        
    }
}
//struct AssignmentPage_Previews: PreviewProvider {
//    static var previews: some View {
//        AssignmentPage()
//    }
//}
