//
//  ContentView.swift
//  NavStack
//
//  Created by Sarthak Shrivastava on 26/03/23.
//

import SwiftUI

struct ContentView: View {
    
    var platforms: [Platform] = [.init(name: "Playstation", imageName: "playstation.logo", color: .indigo),
                                 .init(name: "Xbox", imageName: "xbox.logo", color: .green),
                                 .init(name: "PC", imageName: "pc", color: .red),
                                 .init(name: "Mobile", imageName: "iphone", color: .mint)]
    
    var games: [Game] = [.init(name: "Minecarft", rating: "99"),
                         .init(name: "Fifa 23", rating: "95"),
                         .init(name: "Final Fantasy 16", rating: "98"),
                         .init(name: "F1 2023", rating: "97")]
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path){
            List{
                Section("Platforms"){
                    ForEach(platforms , id: \.name) { platform in
                        NavigationLink(value: platform){
                            Label(platform.name, systemImage: platform.imageName)
                                .foregroundColor(platform.color)
                        }
                    }
                }
                Section("Games"){
                    ForEach(games , id: \.name) { game in
                        NavigationLink(value: game) {
                            Text(game.name)
                        }
                    }
                }
            }
            .navigationTitle("Gaming")
            .navigationDestination(for: Platform.self) { platform in
                ZStack{
                    platform.color.ignoresSafeArea()
                    VStack{
                        Label(platform.name, systemImage: platform.imageName)
                            .font(.largeTitle).bold()
                        
                        List{
                            ForEach(games , id: \.name) { game in
                                NavigationLink(value: game) {
                                    Text(game.name)
                                }
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Game.self) { game in
                VStack(spacing: 20){
                
                    Text("\(game.name) - \(game.rating)")
                        .font(.largeTitle).bold()
                    
                    Button("Reccomend Game") {
                        path.append(games.randomElement()!)
                    }
                    Button("Another Platform") {
                        path.append(platforms.randomElement()!)
                    }
                    Button("Home") {
                        path = NavigationPath()
                    }
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

struct Platform: Hashable {
    let name: String
    let imageName: String
    let color: Color
}


struct Game: Hashable {
    let name: String
    let rating: String
}
