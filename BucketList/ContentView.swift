//
//  ContentView.swift
//  BucketList
//
//  Created by Tamim Khan on 2/5/23.
//
import MapKit
import SwiftUI

struct ContentView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    @State private var locations = [Location]()
    
    @State private var selectedPlace: Location?
    
    
    
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $mapRegion, annotationItems: locations){location in
                MapAnnotation(coordinate: location.cordinate){
                    VStack{
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(Circle())
                        
                        Text(location.name)
                            .fixedSize()
                    }
                    .onTapGesture {
                        selectedPlace = location
                    }
                }
            }
                .ignoresSafeArea()
            Circle()
                .fill(.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button{
                        let newLocation = Location(id: UUID(), name: "New Location", description: "", latitued: mapRegion.center.latitude, longiTued: mapRegion.center.longitude)
                        locations.append(newLocation)
                    }label: {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        .sheet(item: $selectedPlace){ place in
            EditView(location: place){ newlocation in
                if let index = locations.firstIndex(of: place){
                    locations[index] = newlocation
                }
                    
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
