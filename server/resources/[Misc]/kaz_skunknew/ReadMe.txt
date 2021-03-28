Gave fra Sky-Universe & Kazoon -> Et eksempel på en af vores drug-scripts vi benytter.

Nyt Release: Skunk Script 
Står du eller den server du spiller på, og mangler et fedt alternativt drug-script?
Hader du AFK jobs, og vil gerne have noget lidt anderledes? Tjek dette!

Scriptet fungerer på følgende måde:
Der er en Gådemand, der med randome intervaller udskriver nogle gåder i chatten.
Hvis man løser denne gåde, samt finder gådemanden, kan man købe nogle Skunkfrø.

Har man skunkfrø, kan man plante dem på en mark.
Disse frø man planter vokser så op, og bliver et visuelt træ - Træet vokser, og bliver et "stort træ" (Se video)
Når træet er færdiggroet ( Fuldt størrelse ) kan det høstes, og det kan høstes af ALLE, så man skal beskytte sine ting.

Derefter skal man videre til anden lokation, hvor man kan hænge dem til tørre.
Igen kommer de visuelt frem. 
Når de er færdigtørrede kan man tage dem ned - hvilket ALLE kan, så igen - pas på dine ting!
Og til sidst skal det pakkes i 10grams poser klar til salg.

-> Evt. til testing -> Spawn frøene. Spawnkode "skunkfro"



Readme//Guide:

Indsæt følgende i vrp/cfg/items.lua

["skunkfro"] = {"Skunkfrø", "Kan plantes.", nil , 0.10},
["skunk2"] = {"Skunk 1g", "Skal pakkes.", nil , 0.01},
["skunk1000"] = {"Skunkplante", "Skal tørres.", nil , 5.00},
["klump10"] = {"Pose med skunk (10g)", "Sælges eller åbnes.", nil , 0.10},

Indsæt i server.cfg el. serverresources:

Start kaz_skunknew

og smid "skunkfremstilling.ymap" ind i en maps folder -> hvis i ikke har en kan i lave en hvor den skal bestå af følgende:
Mappen: Maps
inde i den ->
mappen: stream
resource.lua -> Inde i denne:
-----------
resource_manifest_version "77731fab-63ca-442c-a67b-abc70f28dfa5"

this_is_a_map 'yes'
-----------
og inde i stream ligger i ymap filen.


Og selvfølgelig -> Smid mappen ind :) 

Og scriptet er selvfølgelig også kodet op til ikke at skabe lag.

Video: https://www.youtube.com/watch?v=uYaSJoo9E9o