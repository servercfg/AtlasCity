--[[
─────────────────────────────────────────────────────────────────────────────────────────────────────────
─██████──████████─██████████████─██████████████████─██████████████─██████████████─██████──────────██████─
─██░░██──██░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░██████████──██░░██─
─██░░██──██░░████─██░░██████░░██─████████████░░░░██─██░░██████░░██─██░░██████░░██─██░░░░░░░░░░██──██░░██─
─██░░██──██░░██───██░░██──██░░██─────────████░░████─██░░██──██░░██─██░░██──██░░██─██░░██████░░██──██░░██─
─██░░██████░░██───██░░██████░░██───────████░░████───██░░██──██░░██─██░░██──██░░██─██░░██──██░░██──██░░██─
─██░░░░░░░░░░██───██░░░░░░░░░░██─────████░░████─────██░░██──██░░██─██░░██──██░░██─██░░██──██░░██──██░░██─
─██░░██████░░██───██░░██████░░██───████░░████───────██░░██──██░░██─██░░██──██░░██─██░░██──██░░██──██░░██─
─██░░██──██░░██───██░░██──██░░██─████░░████─────────██░░██──██░░██─██░░██──██░░██─██░░██──██░░██████░░██─
─██░░██──██░░████─██░░██──██░░██─██░░░░████████████─██░░██████░░██─██░░██████░░██─██░░██──██░░░░░░░░░░██─
─██░░██──██░░░░██─██░░██──██░░██─██░░░░░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░██──██████████░░██─
─██████──████████─██████──██████─██████████████████─██████████████─██████████████─██████──────────██████─
─────────────────────────────────────────────────────────────────────────────────────────────────────────
]]--

Kaz_Liveries:

Første step - Tilføj ting til din database:
Gå ind i Vrp_user_vehicles - Tryk SQL og kopier denne ind:

ALTER TABLE vrp_user_vehicles
ADD livery_metode varchar(255);

Repeat step ind, men denne gang tast dette ind:


ALTER TABLE vrp_user_vehicles
ADD vehicle_livery varchar(255);

_____________________________________________________________

Anden step:
Tilføj Loading af Liveries når din bil bliver spawnet.

Det du skal gøre her er at tilføje følgende: 
TriggerEvent('Kaz_Liveries:BilSpawned') (HVIS DET ER CLIENT SIDED)
eller 
TriggerServerEvent('Kaz_Liveries:BilSpawned', source) (HVIS DET ER SERVER SIDED)

Dette kan være meget forskelligt hvor de skal sættes ind - men som udgangspunkt er det på ca linje 265 i Vrp_garages
Eller linje 479 i Kaz_garages
- Begge Client.lua

Ellers skal du selv finde stedet de skal sættes ind - men som udgangspunkt skal det gøres efter din bil er færdigloadet,
og du er blevet sat ind i den.

Derefter går du ind i Config.lua i Kaz_liveries, og sætter dine ønskede settings op.
Du kan sætte lige så mange steder som du vil.

God fornøjelse!