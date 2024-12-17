//
//  ContentView.swift
//  Moosicapp
//
//  Created by Samuel Scalise on 09/12/24.
//



import SwiftUI
import MusicKit


struct ContentView: View {
    
    @State private var mood: String = "happy" // Default mood
    @State private var currentSong: Song? = nil
    @State private var isSongGenerated: Bool = false
    @State private var isLoading: Bool = false
    @State private var favorites: [Song] = []
    @State private var isSharing: Bool = false
    @State private var isSongFavorited: Bool = false // Track if the song is favorited
    @State private var musicPlayer = ApplicationMusicPlayer.shared // Music player instance
    
    @State private var isGlowing = false
    
    
    
    let moods = ["happy", "sad", "relaxed", "energetic", "romantic", "angry",  ] // Define moods for the picker
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                
                
                Spacer()
                if let song = currentSong {
                    
                    VStack(spacing: 20) {
                        
                        
                        
                        
                        SongCardView(song: song)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black.opacity(0.8))
                            .cornerRadius(15)
                            .shadow(color: .white.opacity(0.3), radius: 10, x: 0, y: 5)
                        
                        
                        HStack{
                            Button(action: {
                                Task {
                                    await playSong()
                                }
                            }) {
                                Label("Play Song", systemImage: "play.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.gray)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white
                                        .opacity(0.2))
                                    .cornerRadius(10)
                                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                                //                                    .hideWithScreenshot()
                            }
                            .labelStyle(.iconOnly)
                            
                            
                            
                            
                            Button(action: {
                                Task {
                                    await pauseSong()
                                }
                            }) {
                                Label("Pause Song", systemImage: "pause.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.gray)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white
                                        .opacity(0.2))
                                    .cornerRadius(10)
                                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                                //                                    .hideWithScreenshot()
                            }
                            .labelStyle(.iconOnly)
                            
                            
                        }
                        .hideWithScreenshot()
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        // Buttons Favourite and Share
                        
                        HStack(spacing: 20) {
                            Spacer()
                            Button(action: {
                                likeSong(song)
                            }) {
                                Image(systemName: isSongFavorited ? "heart.fill" : "heart")
                                    .font(.title2)
                                    .foregroundColor(isSongFavorited ? .red : .white)
                                    .padding()
                                    .frame(width: 60, height: 60)
                                    .background(Color.black.opacity(0.8))
                                    .clipShape(Circle())
                                    .shadow(color: .white.opacity(0.3), radius: 5, x: 0, y: 5)
                                //                                    .hideWithScreenshot()
                            }
                            
                            Button(action: shareSong) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 60, height: 60)
                                    .background(Color.black.opacity(0.8))
                                    .clipShape(Circle())
                                    .shadow(color: .white.opacity(0.3), radius: 5, x: 0, y: 5)
                                //                                    .hideWithScreenshot()
                            }
                            Spacer()
                        }
                        .hideWithScreenshot()
                        
                        HStack {
                            Spacer()
                            Button(action: generateSong) {
                                Image(systemName: "arrow.2.circlepath")
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 60, height: 60)
                                    .background(Color.black)
                                    .clipShape(Circle())
                                    .cornerRadius(10)
                                    .shadow(color: .white.opacity(0.2), radius: 10, x: 0, y: 5)
                                    .accessibilityLabel("Generate Another Song")
                              
                            }
                            Spacer()
                        }
                        .hideWithScreenshot()
                        
                    }
                    .padding()
                } else {
                    
                    
                    
                    VStack{
                        
                        HeadphonesGlowView()
                        
                    }
                    
                    
                    VStack {
                        
                        
                        
                        Spacer()
                        
                        VStack{
                            
                            
                            
                            
                            Spacer()
                            
                            
                            
                            
                            Text("How are you feeling today?")
                                .foregroundColor(.white)
                                .bold()
                                .font(.title2)
                                .offset(y: -50)
                                .padding()
                            
                        }
                        
                        // Card-based Mood Selection
                        VStack{
                            
                            
                            
                        }
                        
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            ForEach(moods, id: \.self) { moodOption in
                                //
                                Button(action: {
                                    withAnimation {
                                        mood = moodOption
                                        generateSong()
                                    }
                                    
                                }) {
                                    
                                    Text(moodOption.capitalized)
                                    //
                                        .frame(width: 100, height: 60)
                                    
                                        .foregroundColor(.white)
                                        .background(Color.black)
                                        .cornerRadius(10)
                                        .bold()
                                        .cornerRadius(15)
                                    
                                        .shadow(color: .white.opacity(0.5), radius: 10, x: 0, y: 0)
                                        .shadow(radius: 10.0)
                                    
                                }
                                .padding()
                                
                            }
                        }
                        
                        .padding(.horizontal, 20)
                        
                        ProgressView()
                            .opacity(isLoading ? 1.0 : 0.1)
                            .padding()
                        
                    }
                    .padding(.bottom, 150)
                        
                  
                }
                
                Spacer()
                
                
                
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            if currentSong != nil {
                                Button(action: {
                                    currentSong = nil
                                }) {
                                    HStack {
                                        Image(systemName: "chevron.left")
                                        Text("Back to Moods")
                                    }
                                    .foregroundColor(.white)
                                    
                                }
                            }
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: FavoritesView(favorites: $favorites)) {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.white)
                                    .frame(width: 40, height: 40)
                                    .background(Color.black.opacity(0.8))
                                    .clipShape(Circle())
                                    .shadow(color: .white.opacity(0.3), radius: 5, x: 0, y: 5)
                                    .padding()
                               
                            }
                        }
                    }
                
            }
          
            .onAppear(perform: requestAuthorization)
            .sheet(isPresented: $isSharing) {
                if let song = currentSong, let url = song.url {
                    ActivityView(activityItems: [url])
                }
            }
            
        }
       
    }
    
    
    // Play the current song
    private func playSong() async {
        guard let song = currentSong else { return }
        
        do {
            try await musicPlayer.queue = [song] // Imposta la coda in modo asincrono
            try await musicPlayer.play()        // Avvia la riproduzione in modo asincrono
            
        } catch {
            print("Error playing song: \(error)")
        }
    }
    
    
    private func pauseSong() async {
        guard let song = currentSong else { return }
        
        do {
            try await musicPlayer.queue = [song] // Imposta la coda in modo asincrono
            try await musicPlayer.pause()        // Avvia la riproduzione in modo asincrono
            
        } catch {
            print("Error playing song: \(error)")
        }
    }
    
    // Apple Music Authorization
    private func requestAuthorization() {
        Task {
            let status = await MusicAuthorization.request()
            if status != .authorized {
                print("Apple Music access not granted")
            }
        }
    }
    
    // Map moods to genres
    private func genreForMood(_ mood: String) -> String {
        let moodToGenre: [String: [String]] = [
            "happy": ["pop", "dance", "party"],
            "sad": ["acoustic", "soul", "blues"],
            "relaxed": ["chill", "ambient", "jazz"],
            "energetic": ["rock", "edm", "hip-hop"],
            "romantic": ["love", "r&b", "latin"],
            "angry": ["metal", "punk", "hard rock"]
        ]
        
        for (key, genres) in moodToGenre {
            if mood.lowercased().contains(key) {
                return genres.randomElement() ?? "pop"
            }
        }
        
        return "pop"
    }
    
    
    
    // Generate a song recommendation
    private func generateSong() {
        guard !mood.isEmpty else { return }
        isLoading = true
        isSongFavorited = false
        let genre = genreForMood(mood)
        
        Task {
            do {
                let request = MusicCatalogSearchRequest(term: genre, types: [Song.self])
                let response = try await request.response()
                
                if let song = response.songs.randomElement() { // Randomize song selection
                    DispatchQueue.main.async {
                        currentSong = song
                        isSongGenerated = true
                        isLoading = false
                    }
                } else {
                    DispatchQueue.main.async {
                        currentSong = nil
                        isSongGenerated = false
                        isLoading = false
                    }
                }
            } catch {
                print("Error fetching song: \(error)")
                DispatchQueue.main.async {
                    currentSong = nil
                    isSongGenerated = false
                    isLoading = false
                }
            }
        }
    }
    
    private func likeSong(_ song: Song) {
        if let index = favorites.firstIndex(of: song) {
            // Song is already in favorites, so remove it
            favorites.remove(at: index)
            isSongFavorited = false
        } else {
            // Song is not in favorites, add it
            favorites.append(song)
            isSongFavorited = true
        }
    }
    
    private func shareSong() {
        isSharing = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

