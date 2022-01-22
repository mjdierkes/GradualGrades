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
    
    var body: some View {
        
        VStack {
            Header()
            ScrollView(.vertical, showsIndicators: false) {
                NavigationLink(destination: LoginPage(), isActive: .constant(manager.student == nil)) {}

                VStack(alignment: .leading){
                    Text("Good \(dayTime()) \(manager.firstName)")
                        .padding(.top, 10)
                        .padding(.horizontal)
                        .font(.title2)
                        .font(.system(.body, design: .rounded))
                    
                    Text(manager.gpa?.roundedWeightedGPA ?? "ERROR")
                        .font(.largeTitle)
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.medium)
                        .padding(.horizontal)
                        .padding(.vertical, 1)
//
//                    ScrollView(.horizontal, showsIndicators: false){
//                        HStack {
//                            RecentAssignmentView()
//                                .padding(2)
//                            RecentAssignmentView()
//                                .padding(2)
//                            RecentAssignmentView()
//                                .padding(2)
//                        }
//                        .padding(.horizontal)
//                    }
//                    
                    CardView()
                            
                    Text("Grades")
                        .padding()
                        .font(.title2)
                        .font(.system(.body, design: .rounded))

                    
//                    let _ = print(manager.classes)
                    ForEach($manager.classes) { details in
                        NavigationLink(destination: AssignmentPage(classDetails: details)) {
                            SimpleClassView(classData: details)
                        }
                        .tint(.black)
                    }
                    
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)

        }
//        .onAppear(perform: {
//            Task {
//                await realTimeGPA()
//            }
//        })
        
                
    }
    
    func dayTime() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 1..<12 :
            return "Morning"
        case 12..<24 :
            return "Afternoon"
        default:
            return ""
        }
    }
    
    func realTimeGPA() async {
        print("WORKING")
        guard let encoded = try? JSONEncoder().encode(manager.liveGPA) else {
            print("Failed to encode order")
            return
        }
        print("STILL WORKING")
        let url = URL(string: "http://gradualgrades-env.eba-dkw3kc3t.us-east-2.elasticbeanstalk.com/predictedGPA")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        print(request)
        do {
            print("HELLO")
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            print(data)
            let decodedGPA = try JSONDecoder().decode(NewGPA.self, from: data)
            liveGPA = decodedGPA.finalWeightedGPA
            print(decodedGPA.finalWeightedGPA)
        } catch {
            print("Checkout failed")
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
