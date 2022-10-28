//
//  SoundBootcamp.swift
//  SwiftUI_Bootcamp_LBTA
//
//  Created by Maxim Hranchenko on 28.10.2022.
//

import SwiftUI
import AVKit

class Sound {
    static var instance = Sound()
    var player: AVAudioPlayer?
    
    enum SoundType: String {
        case bird = "Birds-chirping-sound-effect"
        case duck = "Duck-quack"
    }
    
    func playSound(track: SoundType) {
        guard let url = Bundle.main.path(forResource: track.rawValue, ofType: "mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: URL(string: url)!)
            player?.play()
        } catch {
            player?.stop()
            debugPrint(error.localizedDescription)
        }
    }
    
    func playerStop() {
        player?.stop()
    }
}

struct SoundBootcamp: View {
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                Button("Play 1") {
                    Sound.instance.playSound(track: .bird)
                }
                .padding()
                .foregroundColor(.white)
                .background(RadialGradient(colors: [Color.red, Color.blue], center: .trailing, startRadius: 0, endRadius: 100))
                .cornerRadius(10)
                
                Button("Stop") {
                    Sound.instance.playerStop()
                }
                .padding()
                .foregroundColor(.white)
                .background(AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center))
                .cornerRadius(10)
            }
            
            HStack(spacing: 10) {
                Button("Play 2") {
                    Sound.instance.playSound(track: .duck)
                }
                .padding()
                .foregroundColor(.white)
                .background(AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center))
                .cornerRadius(10)
                
                Button("Stop") {
                    Sound.instance.playerStop()
                }
                .padding()
                .foregroundColor(.white)
                .background(RadialGradient(colors: [Color.red, Color.blue], center: .trailing, startRadius: 0, endRadius: 100))
                .cornerRadius(10)
            }
        }
    }
}

struct SoundBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SoundBootcamp()
    }
}
