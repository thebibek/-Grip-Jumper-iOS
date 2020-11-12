/*
 
 Created by TapTapStudio (Alice Vinnik).
 Copyright ©2020 TapTapStudio. All rights reserved.

 ▀▀█▀▀ ░█▀▀█ ▒█▀▀█ ▀▀█▀▀ ░█▀▀█ ▒█▀▀█
 ░▒█░░ ▒█▄▄█ ▒█▄▄█ ░▒█░░ ▒█▄▄█ ▒█▄▄█
 ░▒█░░ ▒█░▒█ ▒█░░░ ░▒█░░ ▒█░▒█ ▒█░░░

 ▒█▀▀▀█ ▀▀█▀▀ ▒█░▒█ ▒█▀▀▄ ▀█▀ ▒█▀▀▀█
 ░▀▀▀▄▄ ░▒█░░ ▒█░▒█ ▒█░▒█ ▒█░ ▒█░░▒█
 ▒█▄▄▄█ ░▒█░░ ░▀▄▄▀ ▒█▄▄▀ ▄█▄ ▒█▄▄▄█
 
 If you want reskin write me.
 Here you can see reskin examples 🌅: https://alicevinnik.wixsite.com/taptapstudio
 Subscribe to my instagram 📷: https://www.instagram.com/taptap_studio/
 Write to my mail 💌: taptap.main@gmail.com
 
*/

import SpriteKit
import AVFoundation

private let instance = Sound()

/**
 It's singletone class
 Use this class for playing some sound and music in game.
 It's already recognise current game settings and if user turn off sounds game will not played it.
 */
open class Sound {
    
    open class func sharedInstance() -> Sound { return instance}
    
    //MARK: - Sounds
    open var targetScene: SKScene?
    
    /** Enum with list of possible sounds.*/
    public enum Name {
        case buttonPress
        case tumblerClick
        case getPoint
        case getCoin
        case smash1
        case smash2
        case swipe
    }
    
    //Preloaded sounds action for scene
    internal let buttonPress = SKAction.playSoundFileNamed("buttonPress.mp3", waitForCompletion: false)
    internal let tumblerClick = SKAction.playSoundFileNamed("tumblerClick.mp3", waitForCompletion: false)
    internal let getPoint = SKAction.playSoundFileNamed("getPoint.mp3", waitForCompletion: false)
    internal let getCoin = SKAction.playSoundFileNamed("getCoin.mp3", waitForCompletion: false)
    internal let smash1 = SKAction.playSoundFileNamed("smash1.mp3", waitForCompletion: false)
    internal let smash2 = SKAction.playSoundFileNamed("smash2.mp3", waitForCompletion: false)
    internal let swipe = SKAction.playSoundFileNamed("swipe.mp3", waitForCompletion: false)
    
    /** It's interface for playing sounds.*/
    open func playSound(_ name: Name) {
        if UserDefaults.standard.bool(forKey: "PlaySounds") {
            switch name {
            case .buttonPress: targetScene?.run(Sound.sharedInstance().buttonPress)
            case .tumblerClick: targetScene?.run(Sound.sharedInstance().tumblerClick)
            case .getPoint: targetScene?.run(Sound.sharedInstance().getPoint)
            case .getCoin: targetScene?.run(Sound.sharedInstance().getCoin)
            case .smash1: targetScene?.run(Sound.sharedInstance().smash1)
            case .smash2: targetScene?.run(Sound.sharedInstance().smash2)
            case .swipe: targetScene?.run(Sound.sharedInstance().swipe)
            }
        }
    }
    
    /** Change settings of sounds. Possible to play or not*/
    open func changeStateSound() { UserDefaults.standard.set(!UserDefaults.standard.bool(forKey: "PlaySounds"), forKey: "PlaySounds")}
    
    //MARK: - Music
    fileprivate var musicPlayer: AVAudioPlayer?
    
    /**
     Create music and play it if it's possible by settings.
     Better for use in launch game part of app.
     */
    open func playMusic() {
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "background.mp3", withExtension: nil)!)
            musicPlayer!.numberOfLoops = -1
            musicPlayer!.prepareToPlay()
            if UserDefaults.standard.bool(forKey: "PlayMusic") { musicPlayer!.play()}
        } catch { Debugger.printNow(textToPrint: "Not can create AVAudioPlayer for music")}
    }
    
    /** Use this function for pause music in game*/
    func pauseMusic() { if musicPlayer!.isPlaying { musicPlayer!.pause()}}
    
    /** Use this function for resume music playing.*/
    func resumeMusic() { if !musicPlayer!.isPlaying { musicPlayer!.play()}}
    
    /**
     Change playing setting for music.
     If you change settings it's function make pause or contine to play music.
     */
    open func changeStateMusic() {
        UserDefaults.standard.set(!UserDefaults.standard.bool(forKey: "PlayMusic"), forKey: "PlayMusic")
        
        if UserDefaults.standard.bool(forKey: "PlayMusic") { resumeMusic()}
        else { pauseMusic()}
    }
}

