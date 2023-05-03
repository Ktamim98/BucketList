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
    
    
    enum LoadingState{
        case loading, loaded, failed
    }
    
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()
    
    
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Place Name", text: $name)
                    TextField("Description", text: $description)
                }
                Section("Near By..."){
                    switch loadingState{
                    case .loading:
                        Text("Loading please wait")
                    case .loaded:
                        ForEach(pages, id: \.pageid) { page in
                            /*@START_MENU_TOKEN@*/Text(page.title)/*@END_MENU_TOKEN@*/
                                .font(.headline)
                            + Text(": ")
                            Text(page.description)
                                .italic()
                        }
                    
                    case .failed:
                        Text("Please try again later")
                    }
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
            .task {
                await fetchNearByData()
            }
        }
    }
    
    init(location: Location, onSave: @escaping(Location) -> Void){
        self.location = location
        self.onSave = onSave
        
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
    
    func fetchNearByData() async{
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.cordinate.latitude)%7C\(location.cordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

        
        guard let url = URL(string: urlString) else {
            print("bad url \(urlString)")
            return
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let items = try JSONDecoder().decode(Result.self, from: data)
            
            
            pages = items.query.pages.values.sorted()
            loadingState = .loaded
        }catch{
            loadingState = .failed
        }
        
        
    }
    
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) {newlocation in}
    }
}
