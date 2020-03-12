function GetMainGameModel()
    if (m._mainGameModel = invalid)
        prototype = {}

        prototype.gameProcessData = {
            bloodSplatCount: 15
            enemysCount: 15
        }

        prototype._playerSpeed = 0.05236
        prototype._healthCount = 3
        prototype._bulletSpeed = 60

        prototype.decreaseHealth = function()
            m.playerData.healthCount--
        end function
        
        prototype.getGameProcessData = function()
            return m.gameProcessData
        end function

        prototype.getPlayerData = function()
            return m.playerData
        end function

        prototype.setPlayerData = function()
            m.playerData = {
                healthCount: m._healthCount,
                playerSpeed: m._playerSpeed,
                playerStartPosition: m._setPlayerStartPosition(),
                bulletsSpeed: m._bulletSpeed
            }
        end function
        
        prototype._setPlayerStartPosition = function()
            startPosition = []
            startPosition= [800, 940]
            return startPosition
        end function

        prototype.setHelthCount = function(helthCount)
            m._healthCount = healthCount
        end function

        prototype.setPlayerSpeed = function(playerSpeed)
            m._playerSpeed = playerSpeed
        end function

        m._mainGameModel = prototype 
    end if
    return m._mainGameModel
end function