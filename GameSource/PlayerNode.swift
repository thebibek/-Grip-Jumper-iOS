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

class PlayerNode: SimpleNode {
    
    var hat = SimpleNode(texture: GraphicPreloadsGame.preload.hat1_1, size: SettingsScenes.Game.Size.hat, position: SettingsScenes.Game.Position.hat, zPosition: SettingsScenes.Game.ZPosition.hat)
    
    var currentPositionLine = 0
    var currentPositionRow = 2
    
    var currentColor = 0
    
    //MARK: - Initialisations
    /** Initialisation of player node.*/
    init() {
        super.init(texture: GraphicPreloadsGame.preload.player1, size: SettingsScenes.Game.Size.player, position: SettingsScenes.Game.Position.player, zPosition: SettingsScenes.Game.ZPosition.player)
        addChild(hat)
    }
    
    /** If your custom init function not can run compiler call this function.*/
    required init?(coder aDecoder: NSCoder) { fatalError("PlayerNode init(coder:) has not been implemented")}
    
    //MARK: - Player state
    /** This function load current selected skin to player node.*/
    func loadFigure(byId idFigure: Int) {
        currentColor = idFigure
        switch idFigure {
        case 1:
            texture = GraphicPreloadsGame.preload.player1
            if SettingsGlobal.Skins.on {
                switch UserDefaults.standard.integer(forKey: "CurrentSkin") {
                case 2: hat.texture = GraphicPreloadsGame.preload.hat2_1
                case 3: hat.texture = GraphicPreloadsGame.preload.hat3_1
                case 4: hat.texture = GraphicPreloadsGame.preload.hat4_1
                default: hat.texture = GraphicPreloadsGame.preload.hat1_1
                }
            }
        case 2:
            texture = GraphicPreloadsGame.preload.player2
            if SettingsGlobal.Skins.on {
                switch UserDefaults.standard.integer(forKey: "CurrentSkin") {
                case 2: hat.texture = GraphicPreloadsGame.preload.hat2_2
                case 3: hat.texture = GraphicPreloadsGame.preload.hat3_2
                case 4: hat.texture = GraphicPreloadsGame.preload.hat4_2
                default: hat.texture = GraphicPreloadsGame.preload.hat1_2
                }
            }
        case 3:
            texture = GraphicPreloadsGame.preload.player3
            if SettingsGlobal.Skins.on {
                switch UserDefaults.standard.integer(forKey: "CurrentSkin") {
                case 2: hat.texture = GraphicPreloadsGame.preload.hat2_3
                case 3: hat.texture = GraphicPreloadsGame.preload.hat3_3
                case 4: hat.texture = GraphicPreloadsGame.preload.hat4_3
                default: hat.texture = GraphicPreloadsGame.preload.hat1_3
                }
            }
        case 4:
            texture = GraphicPreloadsGame.preload.player4
            if SettingsGlobal.Skins.on {
                switch UserDefaults.standard.integer(forKey: "CurrentSkin") {
                case 2: hat.texture = GraphicPreloadsGame.preload.hat2_4
                case 3: hat.texture = GraphicPreloadsGame.preload.hat3_4
                case 4: hat.texture = GraphicPreloadsGame.preload.hat4_4
                default: hat.texture = GraphicPreloadsGame.preload.hat1_4
                }
            }
        default:
            texture = GraphicPreloadsGame.preload.player5
            if SettingsGlobal.Skins.on {
                switch UserDefaults.standard.integer(forKey: "CurrentSkin") {
                case 2: hat.texture = GraphicPreloadsGame.preload.hat2_5
                case 3: hat.texture = GraphicPreloadsGame.preload.hat3_5
                case 4: hat.texture = GraphicPreloadsGame.preload.hat4_5
                default: hat.texture = GraphicPreloadsGame.preload.hat1_5
                }
            }
        }
    }
    
    //MARK: - Your features
    
    func remove() {
        run(SKAction.scale(to: 0.0, duration: SettingsGameProcess.Player.speedRemove))
    }
}
