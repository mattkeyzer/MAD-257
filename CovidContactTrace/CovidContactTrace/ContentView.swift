//
//  ContentView.swift
//  CovidContactTrace
//
//  Created by Matt Keyzer on 2/9/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    @State private var covidLocation = ""
    @State private var covidTime = ""
    @State private var covidHistory: [String: String] = [:]
    @State private var myLocation = ""
    @State private var myTime = ""
    
    var body: some View {
        Text("Covid Registry")
        
        
        VStack (alignment: .leading){
            TextField("Covid Location", text: $covidLocation)
                .padding()
            TextField("Covid Time", text: $covidTime)
                .padding()
            Button("Report Covid!") {
                // add covid to dictionary
                addCovidTrail(location: covidLocation, time: covidTime)
                // reset text back to nothing after button press
                covidLocation = ""
                covidTime = ""
            }
            .padding()
        }
        .padding()
        Spacer()
        
        
        Text("Check For Contact")
        
        VStack (alignment: .leading){
            TextField("My Location", text: $myLocation)
                .padding()
            TextField("My Time", text: $myTime)
                .padding()
            Button("Check My Safety!") {
                // add contact to dictionary
                checkForContact(location: myLocation, time: myTime)
                // reset text back to nothing after button was pressed
                myLocation = ""
                myTime = ""
            }
            .padding()
        }
        .padding()
        Spacer()
    }
            
    func addCovidTrail(location: String, time: String) {
                
        print("Location: \(location), Time: \(time)")
        
        covidHistory[location] = time
    }
    
    func checkForContact(location: String, time: String) {
            if let storedTime = covidHistory[location], storedTime == time {
                
                print("Contact found at \(location) at \(time)")
                
            } else {
                print("No contact found at \(location) at \(time)")
            }
        }
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
