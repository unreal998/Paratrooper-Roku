function init()
    m.context = m.top
    m.mainGameContainer = m.context.findNode("MainGameContainer")
    m.engineTimer = m.context.findNode("engineTimer")
    m.EVENT_TYPES = GetEventType()
    m.isPress = false
    m.engineTimer.ObserveField("fire", "engineTimer")
    m.mainGameContainer.setFocus(true)

    m.MINIGUN_WIDTH_WITH_DEFLEXION = 190
    m.MINIGUN_HEIGHT = 80
    m.BULLET_HEIGHT_SIZE = 12
    m.HEART_SIZE = 90
end function
 
function _addGameContainers()
    m.arenaContainer = createObject("roSGNode", "Group")
    m.bloodSplatContainer = createObject("roSGNode", "Group")
    m.enemysContainer = createObject("roSGNode", "Group")
    m.bulletsContainer = createObject("roSGNode", "Group")
    m.context.appendChild(m.arenaContainer)
    m.context.appendChild(m.bloodSplatContainer)
    m.context.appendChild(m.enemysContainer)
    m.context.appendChild(m.bulletsContainer)
end function

function startNewGame(mainGameStatData as Object)
    _addGameContainers()
    ' buildArena(mainGameStatData.playerData)
    createCharacter(mainGameStatData.playerData)
    createHealthBar(mainGameStatData.playerData)
    m.bulletSpeed = mainGameStatData.playerData.bulletsSpeed
    ' m.enemysCount = mainGameStatData.gameProcessData.enemysCount
    ' m.bloodSplatCount = mainGameStatData.gameProcessData.bloodSplatCount
    ' createEnemy(mainGameStatData.playerData.gameMode)
    m.engineTimer.control = "start"
end function

function createHealthBar(playerData)
    m.healthBar = createObject("roSGNode", "HealthBar")
    m.healthBar.healthCount = playerData.healthCount
    m.healthBar.translation = [ (1920 - (m.HEART_SIZE * 3)) ,0]
    m.context.appendChild(m.healthBar)
end function


' function createEnemy(gameMode)
'     for i = 0 to m.enemysCount
'         enemy = createObject("roSGNode", "EnemyCharacterCar")
'         randomRow = m.arenaContainer.getChild(Rnd(m.rowsCountWithouStartAndFinish))
'         enemy.speed = Rnd(30)
'         if (gameMode = "vert")    
'             enemy.translation = [randomRow.translation[0] + m.ENEMY_SIZE / 4, -m.ENEMY_SIZE]
'         else if (gameMode = "horiz")
'             enemy.translation = [-m.ENEMY_SIZE / 2, randomRow.translation[1]]
'         end if
'         enemy.direction = gameMode
'         m.enemysContainer.appendChild(enemy)    
'     end for 
' end function

function createCharacter(playerData)
    m.character = createObject("roSGNode", "PlayerCharacter")
    m.character.translation = playerData.playerStartPosition
    m.character.speed = playerData.playerSpeed
    m.minigun = m.character.getChild(0)
    m.minigun.rotation = 1.5708
    m.context.appendChild(m.character)
    m.bulletsContainer.translation = [m.character.translation[0] + m.minigun.translation[0] , (m.character.translation[1] + m.minigun.translation[1] + m.MINIGUN_HEIGHT / 2) - m.BULLET_HEIGHT_SIZE / 2] 
    ? m.bulletsContainer.translation
end function

' function addEnemyCharacters()
'     enemysContainerChildCount = m.enemysContainer.getChildCount() - 1
'     if (enemysContainerChildCount < m.enemysCount)
'         needAddEnemyValue = m.enemysCount - enemysContainerChildCount 
'         for i = 0 to needAddEnemyValue
'             enemy = createObject("roSGNode", "EnemyCharacterCar")
'             randomRow = m.arenaContainer.getChild(Rnd(m.rowsCountWithouStartAndFinish))
'             enemy.speed = Rnd(30)
'             enemy.translation = [-m.ENEMY_SIZE / 2, randomRow.translation[1]]
'             end if
'             enemy.direction = m.gameMode
'             m.enemysContainer.appendChild(enemy)
'         end for 
'     end if
' end function

' function checkEnemyPosition()
'     enemysToRemveArray = []
'     for i = 0 to m.enemysContainer.getChildCount() - 1
'         enemyCharacter = m.enemysContainer.getChild(i)
'         if (enemyCharacter.translation[0] > 1920 or enemyCharacter.translation[1] > 1080)
'             enemysToRemveArray.push(i)
'         end if
'     end for
'     for each enemyIndex in enemysToRemveArray
'         m.enemysContainer.removeChildIndex(enemyIndex)
'     end for
' end function

' function createBloodSplat(positionsArray)
'     bloodSplat = createObject("roSGNode", "BloodSplat")
'     bloodSplat.typeOfBlood = Rnd(4)
'     bloodSplat.translation = positionsArray
'     if (m.bloodSplatContainer.getChildCount() > m.bloodSplatCount)
'         m.bloodSplatContainer.removeChildIndex(0)
'     end if
'     m.bloodSplatContainer.appendChild(bloodSplat)
' end function

' function playerDie()
'     createBloodSplat(m.character.translation)
'     m.context.gameState = m.EVENT_TYPES.WAS_SMASHED
' end function

' function restartLevel(playerData)
'     m.character.translation = playerData.playerStartPosition
'     m.healthBar.callFunc("removeHealth", {helthCount: playerData.healthCount})
'     m.enemysContainer.removeChildrenIndex(m.enemysContainer.getChildCount() - 1, 0)
'     createEnemy(playerData.gameMode)
' end function

' function checkCharactersColision()
'     characterMinXPosition = (m.character.translation[0] - m.CHARACTERS_SIZE / 2) - 15
'     characterMaxXPosition = (m.character.translation[0] + m.CHARACTERS_SIZE / 2) - 15
'     characterMinYPosition = (m.character.translation[1] - m.CHARACTERS_SIZE / 2) - 15
'     characterMaxYPosition = (m.character.translation[1] + m.CHARACTERS_SIZE / 2) - 15
'     for i = 0 to m.enemysContainer.getChildCount() - 1
'         enemy = m.enemysContainer.getChild(i)
'         enemyMinXPosition = enemy.translation[0] - m.ENEMY_SIZE / 2
'         enemyMaxXPosition = enemy.translation[0] + m.ENEMY_SIZE / 2
'         enemyMinYPosition = enemy.translation[1] - m.ENEMY_SIZE / 2
'         enemyMaxYPosition = enemy.translation[1] + m.ENEMY_SIZE / 2
'         if ((enemyMaxXPosition > characterMinXPosition and enemyMaxXPosition < characterMaxXPosition) and (characterMaxYPosition > enemyMinYPosition and characterMinYPosition < enemyMaxYPosition ))
'             playerDie()
'         else if ((characterMaxXPosition > enemyMinXPosition and characterMinXPosition < enemyMaxXPosition ) and (characterMaxYPosition > enemyMinYPosition and characterMinYPosition < enemyMaxYPosition ))    
'             playerDie()
'         end if
'     end for
' end function

function playerActions()
    if (m.isPress)
        if (m.pressedKey = "right")
            m.minigun.rotation = m.minigun.rotation - m.character.speed
        else if (m.pressedKey = "left")
            m.minigun.rotation = m.minigun.rotation + m.character.speed
        else if (m.pressedKey = "OK")
            startFire()    
        end if
    end if
end function

function startFire()
    bullet = m.bulletsContainer.createChild("Bullet")
    bullet.rotation = m.minigun.rotation

    angleSin = sin(bullet.rotation)
    angleCos = cos(bullet.rotation)
    spreading = m.MINIGUN_WIDTH_WITH_DEFLEXION + RND(100)
    bullet.translation = [spreading * angleCos, m.MINIGUN_WIDTH_WITH_DEFLEXION * -angleSin] 
    ? bullet.translation
end function

function bulletMove()
    bulletToRemoveArray = []
    for i = 0 to m.bulletsContainer.getChildCount() - 1
        bullet = m.bulletsContainer.getChild(i)
        angleSin = sin(bullet.rotation)
        angleCos = cos(bullet.rotation)
        bullet.translation = [bullet.translation[0] + (m.bulletSpeed * angleCos), bullet.translation[1] + (m.bulletSpeed * -angleSin)]
        if (bullet.translation[1] < - 1080)
            bulletToRemoveArray.push(bullet)
        end if
    end for
    for each bullet in bulletToRemoveArray
        m.bulletsContainer.removeChild(bullet)
    end for 
end function

' function playerWin()
'     m.context.gameState = m.EVENT_TYPES.PLAYER_WIN
' end function


function engineTimer()
    playerActions()
    bulletMove()
'     checkCharactersColision()
'     checkEnemyPosition()
'     addEnemyCharacters()
end function

function onKeyEvent(key, press)
    if (key = "right" or key = "left" or key = "OK")
        m.isPress = press
        m.pressedKey = key
    end if
  return false
end function