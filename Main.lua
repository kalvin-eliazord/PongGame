-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

padGauche = {}  
padDroite = {}
balle = {}

function CentreBalle()
  balle.largeur = 20
  balle.hauteur = 20
  balle.x = LARGEUR_ECRAN /2
  balle.x = balle.x - balle.largeur / 2
  balle.y = HAUTEUR_ECRAN /2
  balle.y = balle.y - balle.hauteur /2
  balle.vitesse_x = 5
  balle.vitesse_y = 5

  padGauche.largeur = 20
  padGauche.hauteur = 80
  padGauche.x = 10
  padGauche.y = HAUTEUR_ECRAN /2 - padGauche.hauteur/2
  JOUEUR_VITESSE = 10
  padDroite.largeur = 20
  padDroite.hauteur = 80
  padDroite.x = 770
  padDroite.y = HAUTEUR_ECRAN /2 - padDroite.hauteur/2
end

function love.load()
  LARGEUR_ECRAN = love.graphics.getWidth()
  HAUTEUR_ECRAN = love.graphics.getHeight()

  scorePadGauche = 0
  scorePadDroite = 0
  CentreBalle()
end

function love.update(dt)
  if love.keyboard.isDown("up") and padGauche.y >= 0 then
    padGauche.y = padGauche.y + - JOUEUR_VITESSE
  end

  if love.keyboard.isDown("down") and padGauche.y + padGauche.hauteur <= HAUTEUR_ECRAN then
    padGauche.y = padGauche.y + JOUEUR_VITESSE
  end

  if love.keyboard.isDown("z") and padDroite.y >= 0 then
    padDroite.y = padDroite.y + - JOUEUR_VITESSE
  end

  if love.keyboard.isDown("s") and padDroite.y + padDroite.hauteur <= HAUTEUR_ECRAN then
    padDroite.y = padDroite.y + JOUEUR_VITESSE
  end

  balle.x = balle.x + balle.vitesse_x 
  balle.y = balle.y + balle.vitesse_y

  if balle.x <= padGauche.x + padGauche.largeur then
    if balle.y + balle.hauteur > padGauche.y 
    and balle.y + balle.hauteur < padGauche.y + padGauche.hauteur then
      balle.vitesse_x = -balle.vitesse_x
      balle.x = padGauche.x + padGauche.largeur
    end
  end

  if balle.x + balle.largeur >= padDroite.x then
    if balle.y + balle.hauteur > padDroite.y and balle.y < padDroite.y + padDroite.hauteur then
      balle.vitesse_x = -balle.vitesse_x
      balle.x = padDroite.x - padDroite.largeur
    end
  end

  if balle.x > LARGEUR_ECRAN - balle.largeur then
    CentreBalle()
    balle.vitesse_x = -balle.vitesse_x 
    balle.vitesse_y = -balle.vitesse_y
    scorePadGauche = scorePadGauche + 1
    if scorePadGauche == 10 then
      -- win
    end
  end

  if balle.x <= 0 then
    CentreBalle()
    scorePadDroite = scorePadDroite + 1
    if scorePadDroite == 10 then
      -- win
    end
  end

  if balle.y <= 0 then
    balle.vitesse_y = -balle.vitesse_y
  end

  if balle.y >= HAUTEUR_ECRAN - balle.hauteur then
    balle.vitesse_y = -balle.vitesse_y
  end

end

function love.draw()
  love.graphics.rectangle("fill", padGauche.x, padGauche.y, padGauche.largeur, padGauche.hauteur)
  love.graphics.rectangle("fill", padDroite.x, padDroite.y, padDroite.largeur, padDroite.hauteur)
  love.graphics.rectangle("fill", balle.x, balle.y, balle.largeur, balle.hauteur)

  love.graphics.rectangle("fill", LARGEUR_ECRAN/2, 0, 1, HAUTEUR_ECRAN)

  love.graphics.print(scorePadGauche, LARGEUR_ECRAN/2 -20, 20)
  love.graphics.print(scorePadDroite, LARGEUR_ECRAN/2 +15, 20)
end

function love.keypressed(key)
  print(key)
  if key == "space" then
    --menu
  end
end