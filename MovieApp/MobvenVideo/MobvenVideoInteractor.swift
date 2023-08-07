//
//  MobvenVideoInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.08.2023.
//

import Foundation
import AVFoundation

protocol MobvenVideoBusinessLogic: AnyObject {
    func getVideo(player: AVPlayer?)
    func togglePlayState(player: AVPlayer?)
    func resetPlayState()
    func moveForward(player: AVPlayer?)
    func moveBackward(player: AVPlayer?)
}

protocol MobvenVideoDataStore: AnyObject {
    
}

final class MobvenVideoInteractor: MobvenVideoBusinessLogic, MobvenVideoDataStore {
    
    var presenter: MobvenVideoPresentationLogic?
    var worker: MobvenVideoWorkingLogic = MobvenVideoWorker()
    
    var isPlaying: Bool = false
    
    func getVideo(player: AVPlayer?) {
        guard let videoPath = Bundle.main.path(forResource: "Mobven", ofType: "mp4") else {
            return
        }
        
        let videoURL = URL(fileURLWithPath: videoPath)
        let playerItem = AVPlayerItem(url: videoURL)
        player?.replaceCurrentItem(with: playerItem)
    }
    
    func togglePlayState(player: AVPlayer?) {
        guard let player else { return }
        
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        
        isPlaying.toggle()
        let response = MobvenVideoModels.PlayVideo.Response(isPlaying: isPlaying)
        presenter?.presentVideoState(response: response)
    }
    
    func resetPlayState() {
        isPlaying = false
        let response = MobvenVideoModels.PlayVideo.Response(isPlaying: isPlaying)
        presenter?.presentVideoState(response: response)
    }
    
    func moveForward(player: AVPlayer?) {
        guard let player,
              let duration = player.currentItem?.duration.seconds else {
            return
        }
        
        let currentTime = player.currentTime().seconds
        let newTime = min(currentTime + 5, duration - 5)
        
        let time = CMTimeMakeWithSeconds(newTime, preferredTimescale: 1000)
        player.seek(to: time)
    }
    
    func moveBackward(player: AVPlayer?) {
        guard let player else { return }
        
        let currentTime = player.currentTime().seconds
        let newTime = max(currentTime - 5, 0)
        let time = CMTimeMakeWithSeconds(newTime, preferredTimescale: 1000)
        
        player.seek(to: time)
    }
}
