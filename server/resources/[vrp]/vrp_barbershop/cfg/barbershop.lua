
local cfg = {}

cfg.lang = "da"
-- define customization parts
local parts = {
  ["Ansigt"] = -1,
  ["Pletter"] = 0,
  ["Skæg"] = 1,
  ["Øjenbryn"] = 2,
  ["Alderdom"] = 3,
  ["Makeup"] = 4,
  ["Blush"] = 5,
  ["Hudfarve"] = 6,
  ["Hud"] = 7,
  ["Læbestift"] = 8,
  ["Fregner"] = 9,
  ["Brysthår"] = 10,
  ["Kropspletter"] = 11,
  ["Hår"] = 12
}

-- changes prices (any change to the character parts add amount to the total price)
cfg.drawable_change_price = 20
cfg.texture_change_price = 5
cfg.barbershops_title = "Barbershop"

-- skinshops list {parts,x,y,z}
cfg.barbershops = {
{parts,-815.59008789063,-182.16806030273,37.568920135498}, 
--{parts,449.88708496094,-993.13946533203,30.689584732056}, 
{parts,139.21583557129,-1708.9689941406,29.301620483398},
{parts,-1281.9802246094,-1119.6861572266,7.0001249313354},
{parts,1934.115234375,3730.7399902344,32.854434967041},
{parts,1211.0759277344,-475.00064086914,66.218032836914},
{parts,-34.97777557373,-150.9037322998,57.086517333984},
{parts,-280.37301635742,6227.017578125,31.705526351929},
{parts,108.40766143799,-1302.1480712891,28.768798828125},
{parts,-264.48846435547,-959.60705566406,31.223133087158}
}

return cfg
