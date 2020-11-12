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

extension GameScene {
    
    //MARK: - Setters
    func setPlayer() {
        addChild(player)
        
        if let particleSystem = SKEmitterNode(fileNamed: "PlayerParticle.sks") {
            particleSystem.targetNode = self
            player.addChild(particleSystem)
        }
    }
    
    func setEnemysLine() {
        ///Get stats for enemy lines
        var currentIDLine = [1,2,3,4,5]
        currentIDLine.shuffle()
        var arrayLineEnemys: [EnemyNode] = []
        
        ///Get stats for position
        let enemyWidth = SettingsScenes.Game.Size.enemy.width
        var currentPointX = SettingsGlobal.width / 2 - enemyWidth * 2
        
        ///Generate enemy line
        for item in currentIDLine {
            let enemy = EnemyNode()
            enemy.load(colorById: item)
            enemy.position = CGPoint(x: currentPointX, y: enemyPositionLineY)
            addChild(enemy)
            
            arrayLineEnemys.append(enemy)
            
            currentPointX += enemyWidth
        }
        
        ///Add line to main array
        arrayWithEnemys.append(arrayLineEnemys)
        ///Change generator position
        enemyPositionLineY += SettingsScenes.Game.Size.enemy.height
    }
    
    //MARK: - Generator and cleaners
    
    func generateEnemysLineAtStart() {
        ///Generate lines
        for _ in 0..<SettingsGameProcess.Map.Generation.generateLinesAtStart {
            setEnemysLine()
        }
        
        ///Set corrent color to player
        let firstLine = arrayWithEnemys[0]
        let centralColor = firstLine[2].currentColor
        player.loadFigure(byId: centralColor)
    }
    
    func updateMapAtStep() {
        
    }
    
    //MARK: - Game actions
    
    func swipePlayer(toDestination destination: SwipePlayer) {
        if gameIsPlay {
            ///Get stats
            var possibleToMakeMove = true
            var needChangeMapSize = false
            var moveToRow = player.currentPositionRow
            var moveToLine = player.currentPositionLine
            
            if !isFirstSwipe {
                ///Get positions to move
                switch destination {
                case .left:
                    moveToRow -= 1
                    if moveToRow < 0 {
                        possibleToMakeMove = false
                    }
                case .right:
                    moveToRow += 1
                    if moveToRow > 4 {
                        possibleToMakeMove = false
                    }
                case .up:
                    moveToLine += 1
                    needChangeMapSize = true
                }
            }
            else {
                if destination == .up {
                    isFirstSwipe = false
                    needChangeMapSize = true
                }
                else {
                    possibleToMakeMove = false
                }
            }
            
            ///Get future enemy
            let enemyToMove = arrayWithEnemys[moveToLine][moveToRow]
            if !enemyToMove.isActiveEnemy {
                possibleToMakeMove = false
            }
            
            ///Make move is is possible
            if possibleToMakeMove {
                ///Is correct color
                if enemyToMove.currentColor == player.currentColor {
                    ///Increase stats
                    increaseScoreBy(1)
                    increaseGameSpeeds()
                    
                    moveCamera()
                    
                    Sound.sharedInstance().playSound(.swipe)
                    
                    ///Increase coins
                    increaseCoinAfterMoves -= 1
                    if increaseCoinAfterMoves <= 0 {
                        increaseCoinAfterMoves = SettingsGameProcess.Coin.increseCoinAfterMoves
                        
                        increaseCoinsBy(1)
                    }
                    
                    ///Set new player positions
                    player.currentPositionLine = moveToLine
                    player.currentPositionRow = moveToRow

                    ///Move camera if player more then half od screen
                    if SettingsGameProcess.Camera.followToPlayerIfPlayerMoreThan50PercentOfScreenAtY {
                        if currentCamera.position.y < player.position.y {
                            moveCamera(fromPosition: player.position)
                        }
                    }
                    
                    ///Make game actions
                    movePlayerToNewPosition()
                    getRandomColorForPlayer()
                }
                ///Is wrong color
                else {
                    player.remove()
                    setAnimationExplosion(toPosition: player.position)
                    
                    endGame()
                }
            }
            
            ///Remove old enemys and generate new
            if needChangeMapSize {
                ///Generate
                setEnemysLine()
                ///Remove
                if arrayWithEnemys.count >= SettingsGameProcess.Map.Generation.maxGeneratedLines {
                    for item in arrayWithEnemys[0] {
                        item.isActiveEnemy = false
                        item.removeFromParent()
                    }
                    arrayWithEnemys.remove(at: 0)
                    
                    player.currentPositionLine -= 1
                }
            }
        }
    }
    
    func movePlayerToNewPosition() {
        let enemyNow = arrayWithEnemys[player.currentPositionLine][player.currentPositionRow]
        
        player.run(SKAction.move(to: enemyNow.position, duration: SettingsGameProcess.Player.speedToMove))
        enemyNow.isActiveEnemy = false
        enemyNow.run(SKAction.scale(to: 0.0, duration: SettingsGameProcess.Enemy.speedToRemove))
    }
    
    func getRandomColorForPlayer() {
        ///Get possible moving destinaitons
        var possibleMovingDestination : [SwipePlayer] = []
        if arrayWithEnemys[player.currentPositionLine + 1][player.currentPositionRow].isActiveEnemy {
            possibleMovingDestination.append(SwipePlayer.up)
        }
        if player.currentPositionRow - 1 >= 0 {
            if arrayWithEnemys[player.currentPositionLine][player.currentPositionRow - 1].isActiveEnemy {
                possibleMovingDestination.append(SwipePlayer.left)
            }
        }
        if player.currentPositionRow + 1 <= 4 {
            if arrayWithEnemys[player.currentPositionLine][player.currentPositionRow + 1].isActiveEnemy {
                possibleMovingDestination.append(SwipePlayer.right)
            }
        }
        
        ///Get enemy to next moving
        let currentDestination = possibleMovingDestination[Int(from: 0, to: possibleMovingDestination.count - 1)]
        let currentEnemy : EnemyNode
        switch currentDestination {
        case .up:
            currentEnemy = arrayWithEnemys[player.currentPositionLine + 1][player.currentPositionRow]
        case .left:
            currentEnemy = arrayWithEnemys[player.currentPositionLine][player.currentPositionRow - 1]
        case .right:
            currentEnemy = arrayWithEnemys[player.currentPositionLine][player.currentPositionRow + 1]
        }
        
        ///Set new color
        player.loadFigure(byId: currentEnemy.currentColor)
    }
    
    //MARK: - Camera
    
    func moveCamera() {
        currentCamera.removeAllActions()
        currentCamera.run(SKAction.moveTo(y: currentCamera.position.y + SettingsGlobal.height, duration: cameraSpeed))
    }
    
    func moveCamera(fromPosition newPosition: CGPoint) {
        currentCamera.removeAllActions()
        currentCamera.position = CGPoint(x: SettingsGlobal.width / 2, y: newPosition.y)
        currentCamera.run(SKAction.moveTo(y: currentCamera.position.y + SettingsGlobal.height, duration: cameraSpeed))
    }
}
