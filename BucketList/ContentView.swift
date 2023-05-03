//
//  ContentView.swift
//  BucketList
//
//  Created by Tamim Khan on 2/5/23.
//
import MapKit
import SwiftUI

struct ContentView: View {
    
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack{
                Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations){location in
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
                            viewModel.selectedPlace = location
                        }
                    }
                }
                .ignoresSafeArea()
                Circle()
                    .fill(.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
//                    .onTapGesture {
//                        viewModel.addLocation()
//                    }
//                Image(systemName: "plus")
                    
                   
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button{
                            viewModel.addLocation()
                            
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
            .sheet(item: $viewModel.selectedPlace){ place in
                EditView(location: place){
                    viewModel.update(location: $0)
                    
                }
            }
            
        }else{
            Button("Unlock places"){
                viewModel.authenticate()
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
