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

class EnemyNode: SimpleNode {
    
    var currentColor = 0
    var isActiveEnemy = true
    
    //MARK: - Inititalisations
    /**
     Initialisation enemy
     - parameter texture: SKTexture object with texture for enemy.
     - parameter size: CGSize object for set size of enemy.
     - parameter position: CGPoint object for set position node on scene.
     - parameter zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init() {
        super.init(texture: GraphicPreloadsGame.preload.enemy1, size: SettingsScenes.Game.Size.enemy, position: SettingsScenes.Game.Position.enemy, zPosition: SettingsScenes.Game.ZPosition.enemy)
    }
    
    /** If your custom init function not can run compiler call this function*/
    required init?(coder aDecoder: NSCoder) { fatalError("SimpleNode init(coder:) has not been implemented")}
    
    //MARK: - Your features
    
    func load(colorById idColor: Int) {
        currentColor = idColor
        
        switch idColor {
        case 1:
            texture = GraphicPreloadsGame.preload.enemy1
        case 2:
            texture = GraphicPreloadsGame.preload.enemy2
        case 3:
            texture = GraphicPreloadsGame.preload.enemy3
        case 4:
            texture = GraphicPreloadsGame.preload.enemy4
        default:
            texture = GraphicPreloadsGame.preload.enemy5
        }
    }
}
