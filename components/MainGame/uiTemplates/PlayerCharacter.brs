function init()
    m.context = m.top
    m.context.observeField("direction", "changeDirection")
    m.DOT_WIDTH = 300
    m.DOT_HEIGHT = 180
    m.MINIGUN_WIDTH = 240
    m.MINIGUN_HEIGHT = 80
    createPlayerCharacter()
end function

function createPlayerCharacter()
    dot =  m.context.createChild("Poster")
    dot.uri = "pkg:/images/playerCharacter/bunker.png"
    dot.width = m.DOT_WIDTH
    dot.height = m.DOT_HEIGHT
    minigun =  m.context.createChild("Poster")
    minigun.uri = "pkg:/images/playerCharacter/minigun.png"
    minigun.width = m.MINIGUN_WIDTH
    minigun.height = m.MINIGUN_HEIGHT
    minigun.translation = [m.DOT_WIDTH / 2 - 10, m.DOT_HEIGHT / 2 - (m.MINIGUN_HEIGHT / 2)]
    minigun.scaleRotateCenter = [0, m.MINIGUN_HEIGHT/2]
    m.context.appendChild(minigun)
    m.context.appendChild(dot)
end function