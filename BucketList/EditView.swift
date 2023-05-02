//
//  EditView.swift
//  BucketList
//
//  Created by Tamim Khan on 3/5/23.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var location: Location
    
    
    @State private var name: String
    @State private var description: String
    
    
    var onSave: (Location) -> Void
    
    
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Place Name", text: $name)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Place Details")
            .toolbar{
                Button("Save"){
                    var newLocatoin = location
                    newLocatoin.id = UUID()
                    newLocatoin.name = name
                    newLocatoin.description = description
                    
                    onSave(newLocatoin)
                    dismiss()
                }
            }
        }
    }
    
    init(location: Location, onSave: @escaping(Location) -> Void){
        self.location = location
        self.onSave = onSave
        
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) {newlocation in}
    }
}
