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

class SimpleLabel: SKLabelNode {
    
    //MARK: - Initialisations
    /**
     Initialise label
     - parameter text: String with text for label.
     - parameter fontSize: CGFloat value with label font size.
     - parameter fontColorHex: String with code of color for label. It's be look like "#ffffff".
     - parameter position: CGPoint object with position new label on scene.
     - parameter zPosition: CGFloat value for set position label by z coordinate on scene.
     */
    init(text: String, fontSize: CGFloat, fontColorHex: String, position: CGPoint, zPosition: CGFloat) {
        super.init()
        self.text = text
        self.position = position
        self.zPosition = zPosition
        fontColor = UIColor(hexString: fontColorHex)
        fontName = SettingsGlobal.WorkWithScenes.fontNameInGame
        
        ///If game launch on iPad scale font size by x2
        if SettingsGlobal.isIPad { self.fontSize = fontSize * SettingsGameProcess.Interface.InterfaceScalesAtIPad.label}
        else { self.fontSize = fontSize}
        
        verticalAlignmentMode = .center
        horizontalAlignmentMode = .center
    }
    
    /**
     Initialise label
     - parameter text: String with text for label.
     - parameter fontSize: CGFloat value with label font size.
     - parameter fontColorHex: String with code of color for label. It's be look like "#ffffff".
     - parameter position: CGPoint object with position new label on scene.
     - parameter zPosition: CGFloat value for set position label by z coordinate on scene.
     */
    init(text: String, fontSize: CGFloat, fontColorHex: String, zPosition: CGFloat) {
        super.init()
        self.text = text
        self.zPosition = zPosition
        fontColor = UIColor(hexString: fontColorHex)
        fontName = SettingsGlobal.WorkWithScenes.fontNameInGame
        
        ///If game launch on iPad scale font size by x2
        if SettingsGlobal.isIPad { self.fontSize = fontSize * SettingsGameProcess.Interface.InterfaceScalesAtIPad.label}
        else { self.fontSize = fontSize}
        
        verticalAlignmentMode = .center
        horizontalAlignmentMode = .center
    }
    
    /** If your custom init function not can run compiler call this function*/
    required init?(coder aDecoder: NSCoder) { fatalError("SimpleLabel init(coder:) has not been implemented")}
    
    //MARK: - Animations
    func changeTextWithAnimationScaled(withText text: String) {
        self.text = text
        removeAllActions()
        run(SKAction.sequence([
            SKAction.scale(to: 1.2, duration: SettingsGameProcess.Interface.speedAnimationChangeLabel / 2),
            SKAction.scale(to: 1, duration: SettingsGameProcess.Interface.speedAnimationChangeLabel / 2)]))
    }
    
    func changeTextWithAnimationScaled<T: LosslessStringConvertible>(withText text: T) { changeTextWithAnimationScaled(withText: String(text))}
    
    //MARK: - Your features
    
}
