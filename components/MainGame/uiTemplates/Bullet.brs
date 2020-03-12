function init()
    m.context = m.top
    m.BULLET_WIDTH_SIZE = 19
    m.BULLET_HEIGHT_SIZE = 12
    createBullet()
end function

function createBullet()
    tile = createObject("roSGNode", "Poster")
    tile.uri = "pkg:/images/playerCharacter/bullet.png"
    tile.width = m.BULLET_WIDTH_SIZE
    tile.height = m.BULLET_HEIGHT_SIZE
    m.context.appendChild(tile)
end function