# *********
# IMPORTANT
# *********
# Running an event using this script will turn all message window backgrounds
# opaque; returning them to normal is the responsibility of the game.
# Call Window_Message.lw_set_opaque(false) to return them to the default 
# opacity

module LW_Replay_Variables
  # values for background_opacity
  Opacity_on = 255
  Opacity_off = 192
end

module TLS_Scenes
  # Include one entry in this array for each scene that should be included in
  # the list that can be replayed.
  
  # Syntax:
  #   ["Name of Common event",
  #       ["Face 1"(, etc)], [face ID 1 (, etc)],
  #       "control code" (, optional controls)]
  
  # 0-6 faces can be displayed; extra entries beyond that will be pushed off
  # the screen. (If no faces are desired, leave the arrays empty.)
  
  # Control codes:
  # "always"
  #     - always include this scene
  
  # "switch_on", id
  #     - include this scene if switch[id] is on
  
  # "variable_at_least", id, value
  #     - include this scene if variable[id] >= value  
  
  # "self_switch_on", mapID, eventID, switch character
  #     - include this scene if self_switch 'switch character'
  #       for event[eventID] on map[mapID] is set to on
  
  # N.B. do not omit the commas separating entries!
  
  Scene_data = [
    ["Riala Prologue",
        ["face002b", "Riala emo"], [0,0],
        "always"],
    ["Wendis Dream",
        ["face002b", "Wendis blond emo1"], [7,1],
        "always"],
    ["Yarra Teasing",
        ["face002b", "Yarra emo2"], [0,0],
        "always"],
    ["Aka First Time",
        ["face002b", "Aka emo"], [0,1],
        "always"],
    ["Yarra x Ina",
        ["Yarra emo2", "Z Ina"], [0,1],
        "self_switch_on", 16 , 18, 'A'],
    ["Accepting Qum",
        ["face002b", "Qum D'umpe emo"], [0,1],
        "always"],
    ["Yarra in Bed",
        ["face002b", "Yarra emo2"], [0,0],
        "always"],
    ["Relief with Aka",
        ["face002b", "Aka emo"], [0,1],
        "always"],
    ["Noble Prostitute",
        ["face002b", "People4"], [0,1],
        "self_switch_on", 44 , 29, 'A'],
    ["Local Prostitute",
        ["face002b", "People5"], [0,3],
        "switch_on", 87],
    ["Zirantian Prostitute",
        ["face002b", "Zirantian prostitute"], [0,1],
        "switch_on", 88],
    ["Exotic Prostitute",
        ["face002b", "Actor5"], [0,1],
        "switch_on", 89],
    ["Mysterious Prostitute",
        ["face002b", "People3"], [0,7],
        "switch_on", 148],
    ["Mysterious Prostitute II",
        ["face002b", "People3"], [0,7],
        "switch_on", 149],
    ["Whoring Qum",
        ["Qum D'umpe emo", "NPC emo", "NPC emo", "NPC emo", "NPC emo", "NPC emo"], [4,0,0,0,0,0],
        "self_switch_on", 60 , 2, 'B'],
    ["Sick Succubus",
        ["face002b", "NPC emo"], [0,0],
        "switch_on", 122],
    ["Stineford Orgy",
        ["face002b", "Aka emo", "Yarra emo2", "Qum D'umpe emo"], [0,1,0,6],
        "switch_on", 700],
    ["Robin Interruption",
        ["Robin blond emo", "face002b", "Aka emo", "Yarra emo2", "Qum D'umpe emo"], [0,0,1,0,6],
        "always"],  
    ["Hilstara First Time",
        ["face002b", "Hilstara emo"], [0,6],
        "always"],  
    ["Trin First Time",
        ["face002b", "Trin emo2"], [0,1],
        "always"], 
    ["Bathing with Hilstara",
        ["face002b", "Hilstara emo"], [0,6],
        "self_switch_on", 99 , 16, 'B'],        
    ["Megail First Time",
        ["face002b", "Megail emo2"], [0,5],
        "always"], 
    ["Megail Reconciliation",
        ["face002b", "Megail emo2"], [0,0],
        "always"],   
    ["Aka + Hilstara",
        ["face002b", "Aka emo", "Hilstara emo"], [0,1,6],
        "switch_on", 228],  
    ["Yarra + Trin",
        ["face002b", "Yarra emo2", "Trin emo"], [0,0,1],
        "self_switch_on", 99 , 21, 'A'],     
    ["Altina First Early",
        ["face002b", "Altina emo"], [0,3],
        "switch_on", 249],  
    ["Altina First Later",
        ["face002b", "Altina emo"], [0,0],
        "switch_on", 253],   
    ["Varia Gangbang",
        ["Varia emo", "NPC emo", "NPC emo", "NPC emo", "NPC emo", "NPC emo"], [5,0,0,0,0,0],
        "switch_on", 261],   
    ["Varia Dominated",
        ["face002b", "Varia emo"], [0,0],
        "switch_on", 263],   
    ["Varia Reshaped",
        ["face002b", "Varia emo"], [0,1],
        "switch_on", 264],     
    ["Carina First Time",
        ["face002b", "Carina emo"], [0,1],
        "always"],    
    ["Orcent Orgy",
        ["Z Orcent", "NPC emo", "NPC emo", "NPC emo", "NPC emo", "NPC emo"], [1,0,0,0,0,0],
        "switch_on", 721], 
    ["Blowjob Distraction",
        ["Varia emo", "NPC emo"], [0,0],
        "switch_on", 722],     
    ["Carina Solo",
        ["Carina emo"], [5],
        "switch_on", 355],  
    ["Aka x Tentacles",
        ["Aka emo", "face002b dark"], [4,0],
        "switch_on", 471],         
    ["Trin x Altina",
        ["Trin emo2", "Altina emo"], [1,1],
        "switch_on", 466], 
    ["Yarra x Qum",
        ["Yarra emo2", "Qum D'umpe emo"], [0,1],
        "always"],     
    ["Yarra x Ogre",
        ["Yarra emo2", "NPC emo"], [0,0],
        "switch_on", 516],   
    ["Yarra + Qum x Ogre",
        ["Yarra emo2", "Qum D'umpe emo", "NPC emo"], [0,1,0],
        "switch_on", 515],  
    ["Orcent x Succubus",
        ["Z Orcent", "NPC emo"], [1,0],
        "always"],  
    ["Orc Council Solo",
        ["Yarra emo2", "NPC emo", "NPC emo", "NPC emo", "NPC emo", "NPC emo"], [0,0,0,0,0,0],
        "switch_on", 723],    
    ["Orc Council",
        ["Yarra emo2", "Qum D'umpe emo", "NPC emo", "NPC emo", "NPC emo", "NPC emo"], [0,1,0,0,0,0],
        "switch_on", 724],
    ["Gathering Orgy",
        ["Yarra emo2", "Qum D'umpe emo", "NPC emo", "NPC emo", "NPC emo", "NPC emo"], [0,1,0,0,0,0],
        "always"], 
    ["Qum x Futa",
        ["Qum D'umpe emo", "NPC emo"], [1,0],
        "switch_on", 559], 
    ["Serving the Empress I",
        ["face002b", "Esthera emo2"], [0,1],
        "always"],    
    ["Serving the Empress II",
        ["face002b", "Esthera emo"], [0,1],
        "always"],    
    ["Serving the Empress III",
        ["face002b", "Esthera emo"], [0,7],
        "always"],      
    ["Nalili First Time",
        ["face002b", "Nalili emo1"], [0,5],
        "switch_on", 619], 
    ["Nalili Titjob",
        ["face002b", "Nalili emo1", "Esthera emo2"], [0,5,4],
        "switch_on", 725],   
    ["Nalili Double Team",
        ["face002b", "Nalili emo1", "Esthera emo2"], [0,5,4],
        "switch_on", 726],    
    ["Lamia Prisoner",
        ["face002b", "Y Lamia1"], [0,1],
        "switch_on", 632],      
    ["Office Orgy",
        ["face002b", "Y succubus2 OrgEmp", "Y succubus1 OrgEmp", "Y succubus1 OrgEmp", "Y succubus2 OrgEmp", "Y succubus2 OrgEmp"], [0,0,0,7,1,4],
        "switch_on", 638],          
    ["Reunion Orgy",
        ["face002b", "Harem emo"], [0,0],
        "switch_on", 688],
    ["Megail + Hilstara",
        ["1 Simon dark", "Megail emo2", "Hilstara emo"], [0,0,6],
        "switch_on", 729], 
    ["Trin + Altina",
        ["1 Simon dark", "Trin emo2", "Altina emo", "Altina emo", "Altina emo", "Altina emo"], [0,1,1,1,1,1],
        "switch_on", 727],    
    ["Yarra + Qum",
        ["1 Simon dark", "Yarra emo2", "Qum D'umpe emo"], [0,0,6],
        "switch_on", 728],     
    ["Aka + Nalili",
        ["1 Simon dark", "Aka emo", "Nalili emo1"], [0,1,5],
        "self_switch_on", 246 , 40, 'A'],
    ["Qum + Trin",
        ["1 Simon dark", "Qum D'umpe emo", "Trin emo"], [0,1,1],
        "switch_on", 805],
    ["Yarra + Varia",
        ["1 Simon dark", "Yarra emo2", "Varia emo"], [0,0,0],
        "switch_on", 890],
    ["Hilstara + Carina",
        ["1 Simon dark", "Hilstara emo", "Carina emo"], [0,6,1],
        "switch_on", 888],
    ["Ardford Orgy",
        ["1 Simon dark", "Harem emo"], [0,0],
        "switch_on", 900],
    ["Hilstara x Succubi",
        ["Hilstara emo", "NPC emo","NPC emo","NPC emo","NPC emo","NPC emo"], [6,0,0,0,0,0],
        "switch_on", 986],
    ["Aka's New Form",
        ["1 Simon dark", "Aka emo2"], [0,1],
        "switch_on", 987],
    ["Balia First Time",
        ["1 Simon dark", "Balia emo"], [0,1],
        "switch_on", 1057],
    ["Forest Orgy",
        ["1 Simon dark", "Z succubus_a", "Z succubus_b", "Z succubus_c", "Z succubus_a", "Z succubus_a"], [0,7,7,1,7,7],
        "switch_on", 1162],
    ["Lynine First Time",
        ["1 Simon dark", "Lynine emo"], [0,1],
        "switch_on", 1181],
    ["Orilise First Time",
        ["1 Simon dark", "Orilise emo"], [0,1],
        "switch_on", 1182],
    ["Lynine + Orilise",
        ["1 Simon dark", "Lynine emo", "Orilise emo"], [0,1,1],
        "switch_on", 1231],
    ["Orilise + Lynine",
        ["1 Simon dark", "Orilise emo", "Lynine emo"], [0,1,1],
        "switch_on", 1232],
    ["Aka + Varia",
        ["1 Simon dark", "Varia emo", "Aka emo2"], [0,1,1],
        "switch_on", 1268],
    ["Hilstara x Lynine",
        ["Hilstara emo", "Lynine emo"], [1,1],
        "switch_on", 1269],
    ["Yarra + Qum + Nalili",
        ["1 Simon dark", "Yarra emo2", "Qum D'umpe emo", "Nalili emo1"], [0,0,1,1],
        "switch_on", 1270],
    ["Yarra x Fuani",
        ["Yarra emo2", "Z Fuani emo"], [0,2],
        "switch_on", 1361],
    ["Comforting Simon",
        ["1 Simon dark", "Carina emo", "Aka emo2", "Nalili emo1"], [0,4,4,3],
        "switch_on", 1350],
    ["Crypt Handjob",
        ["1 Simon dark", "Aka emo2", "Nalili emo1"], [0,1,1],
        "switch_on", 1415],
    ["Varia in Chains",
        ["1 Simon dark", "Varia emo"], [0,1],
        "switch_on", 1551],
    ["Yarra + Hilstara",
        ["1 Simon dark", "Yarra emo2", "Hilstara emo"], [0,0,1],
        "switch_on", 1552],
    ["Trin Double Team",
        ["1 Simon dark", "Trin emo", "1 Simon dark"], [0,1,0],
        "switch_on", 1509],
    ["Robin First Time",
        ["1 Simon dark", "Robin blond emo"], [0,1],
        "switch_on", 1507],
    ["Hilstara x Galvia",
        ["Hilstara emo", "Galvia emo"], [0,0],
        "switch_on", 1585],
    ["Megail + Orilise",
        ["1 Simon dark", "Megail emo2", "Orilise emo"], [0,0,0],
        "self_switch_on", 355 , 13, 'A'],
    ["Carina + Qum",
        ["1 Simon dark", "Carina emo", "Qum D'umpe emo"], [0,1,1],
        "switch_on", 1698],
    ["Yarra's Joint Squad",
        ["Yarra emo2", "Y DS_Actor20", "Z succubus_a", "Y DS_Actor20", "Z succubus_a", "Y DS_Actor20", "Z succubus_a", "Y DS_Actor20"], [0,7,1,7,1,7,1,7],
        "switch_on", 1699],
    ["Healing Dreams",
        ["1 Simon dark", "Z succubus_nun_a"], [0,2],
        "switch_on", 1863],
    ["Restoring Riala",
        ["1 Simon dark", "Riala emo2"], [0,1],
        "switch_on", 1905],
    ["Meeting Iris",
        ["1 Simon dark", "Riala emo2", "Iris emo"], [0,6,6],
        "switch_on", 1905],
    ["Restoring Unsuccubi",
        ["1 Simon dark", "Z succubus_aU", "Z succubus_aU", "Z succubus_aU", "Z succubus_aU", "Z succubus_aU",], [0,1,1,1,1,1],
        "switch_on", 2001],
    ["Sending A Message",
        ["1 Simon dark", "Iris emo", "Riala emo2"], [0,6,6],
        "switch_on", 2006],
    ["Fuckety Fuck",
        ["Qum D'umpe emo", "Megail emo2", "Varia emo", "Hilstara emo", "Lynine emo"], [6,0,1,0,1],
        "switch_on", 2012],
    ["Victory Orgy",
        ["1 Simon dark", "Harem emo"], [0,0],
        "switch_on", 2016],
     ["Special Surprise",
        ["1 Simon dark", "Iris emo", "Aka emo2", "Yarra emo2"], [0,1,1,0],
        "switch_on", 2099],
     ["Aka + Yarra",
        ["1 Simon dark", "Aka emo2", "Yarra emo2"], [0,1,0],
        "switch_on", 2364],
     ["Megail + Qum",
        ["1 Simon dark", "Qum D'umpe emo", "Megail emo2"], [0,1,1],
        "switch_on", 2368],        
     ["Iris + Megail",
        ["1 Simon dark", "Iris emo", "Megail emo2"], [0,1,1],
        "switch_on", 2366],
     ["Iris + Megail Anal",
        ["1 Simon dark", "Iris emo", "Megail emo2"], [0,1,1],
        "switch_on", 2367],
     ["Janine's Wedding Night",
        ["1 Simon dark", "Janine emo3"], [0,1],
        "switch_on", 2568],
     ["Old Lovers",
        ["1 Simon dark", "Wynn emo"], [0,1],
        "switch_on", 2312],        
     ["Shard Sipping",
        ["1 Simon dark", "Yarra emo2", "Qum D'umpe emo", "Nalili emo1", "Riala emo2", "Iris emo"], [0,0,1,5,1,1],
        "switch_on", 2359], 
     ["Elleani Relief",
        ["Yarra emo2", "Elleani emo1"], [0,5],
        "switch_on", 2641], 
     ["Dari's New Body",
        ["1 Simon dark", "Dari2 emo"], [0,0],
        "switch_on", 2725], 
     ["Dari's Changed Body",
        ["1 Simon dark", "Dari1 emo"], [0,0],
        "switch_on", 2726], 
     ["Hilstara Massage",
        ["1 Simon dark", "Hilstara emo"], [0,1],
        "switch_on", 2727], 
     ["Uyae's First Time",
        ["1 Simon dark", "Uyae emo"], [0,1],
        "switch_on", 2722], 
     ["Robin's Transformation",
        ["1 Simon dark", "Robin grey emo"], [0,1],
        "switch_on", 2728],   
     ["Orilise x Altina",
        ["Orilise emo", "Altina emo"], [1,0],
        "switch_on", 2796], 
     ["Rescued Erosians",
        ["1 Simon dark", "J_People1", "J_People1", "J_People2", "J_People3", "J_People2"], [0,2,3,5,2,7],
        "switch_on", 2840], 
     ["Robin + Qum",
        ["1 Simon dark", "Robin blond emo", "Qum D'umpe emo"], [0,1,1],
        "switch_on", 2869], 
     ["Aka + Uyae",
        ["1 Simon dark", "Aka emo2", "Uyae emo"], [0,1,1],
        "switch_on", 2874], 
     ["Fuani + Yarra",
        ["1 Simon dark", "Z Fuani emo", "Yarra emo2"], [0,2,0],
        "switch_on", 2876], 
     ["Nalili x Fenima",
        ["Nalili emo1", "Y Stenai NPC 3"], [1,0],
        "switch_on", 2898],
     ["Reunited",
        ["1 Simon dark", "Monster1"], [0,0],
        "switch_on", 2934],
     ["Wendis + Wynn",
        ["1 Simon dark", "Wynn emo", "Monster1"], [0,1,0],
        "switch_on", 2942],
     ["Titfucking Tips",
        ["1 Simon dark", "Hilstara emo", "Monster1"], [0,1,0],
        "switch_on", 2941],
     ["Carina + Yarra",
        ["1 Simon dark", "Yarra emo2", "Carina emo"], [0,0,1],
        "switch_on", 2964],
     ["Gawnfall Orgy",
        ["1 Simon dark", "Harem emo"], [0,0],
        "switch_on", 3259],
     ["Qum Roleplaying",
        ["1 Simon dark", "Qum D'umpe emo"], [0,1],
        "switch_on", 3293],
     ["Sarai Solo",
        ["Sarai emo"], [0],
        "switch_on", 3284],
     ["Sarai's First Time",
        ["1 Simon dark", "Sarai emo"], [0,0],
        "switch_on", 3287],
     ["Yelarel Blessing",
        ["1 Simon dark", "Yelarel emo"], [0,1],
        "switch_on", 3291],
     ["Varia + Uyae",
        ["1 Simon dark", "Varia emo", "Uyae emo"], [0,1,1],
        "switch_on", 3295],
     ["Ivalan Ritual",
        ["1 Simon dark", "Yelarel emo", "Z succubus_nun_a", "Z succubus_nun_b", "Z succubus_nun_a", "Z succubus_nun_b"], [0,1,1,1,1,1],
        "switch_on", 2512],
     ["Erosian Orgy",
        ["Hilstara emo", "NPC emo"], [0,0],
        "switch_on", 3553],
     ["Megail x Iris",
        ["Megail emo2", "Iris emo"], [1,1],
        "switch_on", 3554],
     ["The Fucklord's Harem",
        ["1 Simon dark", "Lynine emo", "Harem emo"], [0,1,0],
        "switch_on", 3545],
     ["Thenoursan Aftermath",
        ["1 Simon dark", "Harem emo"], [0,0],
        "switch_on", 3561],
     ["Restoring Sabitha",
        ["1 Simon dark", "Sabitha H emo"], [0,1],
        "switch_on", 3583],
     ["Glade Fivesome",
        ["1 Simon dark", "Yarra emo2", "Nalili emo1", "Orilise emo", "Trin emo2", "Aka emo2"], [0,0,1,1,1,1],
        "switch_on", 3619],
     ["Consuming a Shard",
        ["1 Simon dark", "Harem emo"], [0,0],
        "switch_on", 3675],
     ["Tertia Titfuck",
        ["1 Simon dark", "Tertia emo"], [0,0],
        "switch_on", 3734],
     ["Tertia Induction",
        ["1 Simon dark", "Tertia emo"], [0,0],
        "switch_on", 3775],
     ["Yarra + Nalili",
        ["1 Simon dark", "Yarra emo2", "Nalili emo1"], [0,0,1],
        "self_switch_on", 494, 122, 'A'],
     ["Wendis Reunion I",
        ["1 Simon dark", "Wendis grey emo1"], [4,1],
        "switch_on", 12],
     ["Wendis Reunion II",
        ["1 Simon dark", "Wendis grey emo1", "Harem emo"], [4,1,0],
        "switch_on", 12],
     ["Dari + Qum",
        ["1 Simon dark", "Dari1 emo", "Qum D'umpe emo"], [0,0,1],
        "switch_on", 3818],
     ["Orcent x Kara",
        ["Orcent", "Z Kara"], [2,4],
        "switch_on", 3789],
     ["Fheliel First Time",
        ["1 Simon dark", "Fheliel emo"], [0,1],
        "switch_on", 3781],
     ["Biyue Wingjob",
        ["1 Simon dark", "Z Biyue emo"], [0,0],
        "switch_on", 3796],
     ["Neranda Impregnation",
        ["1 Simon dark", "Neranda emo1"], [0,4],
        "switch_on", 3821],
     ["Relondo's Harem",
        ["1 Simon dark", "NPC emo"], [0,0],
        "switch_on", 3823],
     ["Galvia + Hilstara",
        ["1 Simon dark", "Galvia emo", "Hilstara emo"], [0,0,0],
        "switch_on", 3839],
     ["Wynn's Lab Bondage",
        ["1 Simon dark", "Wendis grey emo1", "Wynn emo"], [0,0,1],
        "switch_on", 3842],
     ["Ginasta Bathing",
        ["Ginasta emo"], [1],
        "switch_on", 3903],
     ["Balia x Iris",
        ["Balia emo", "Iris emo"], [1,1],
        "switch_on", 3927],
     ["The Empress's Orgy",
        ["Nalili emo2", "NPC emo"], [1,0],
        "switch_on", 3961],
     ["Ravaging Conqueror",
        ["1 Simon dark", "Harem emo"], [0,0],
        "switch_on", 3999],
     ["The Empress's Last Fuck",
        ["1 Simon dark", "Esthera emo"], [0,0],
        "switch_on", 4026],
     ["Balia's Threesome",
        ["Iris emo", "Balia emo", "Megail emo2"], [0,0,0],
        "switch_on", 4082],
     ["Esthera + Nalili",
        ["1 Simon dark", "Esthera emo", "Nalili emo1"], [0,0,1],
        "switch_on", 4083],
     ["Elleani First Time",
        ["1 Simon dark", "Elleani emo1"], [0,0],
        "switch_on", 2313],
     ["Iris Lingerie",
        ["1 Simon dark", "Iris emo"], [0,1],
        "switch_on", 4133],
     ["Lord of Blood's Harem",
        ["1 Simon dark", "y succubus misc", "y succubus2 misc", "y succubus3 misc", "y succubus misc", "y succubus2 misc", "y succubus3 misc"], [0,2,0,0,2,0,0],
        "switch_on", 4170],
     ["Solo Harem",
        ["1 Simon dark", "Zelica emo", "Harem emo"], [0,1,0],
        "switch_on", 4367],
     ["Battle in Aram",
        ["Palina emo"], [0],
        "switch_on", 4419],
     ["Hollow Embrace",
        ["1 Simon dark", "Harem emo"], [0,0],
        "switch_on", 4540],
     ["Ivala First Time",
        ["1 Simon dark", "Ivala emo"], [0,1],
        "switch_on", 4558],
     ["Mithyn First Time",
        ["1 Simon dark", "Mithyn emo"], [0,0],
        "switch_on", 4557],
     ["Freeing Zelica",
        ["1 Simon dark", "Zelica emo"], [0,6],
        "switch_on", 4641],
     ["Ivala Threesome",
        ["1 Simon dark", "Ivala emo", "Carina emo"], [0,1,1],
        "switch_on", 4629],
     ["Ginasta First Time",
        ["1 Simon dark", "Ginasta emo"], [0,1],
        "switch_on", 4669],
        
        
    ["Kai x Succubus",
        ["MainActor1-3fs", "NPC emo"], [1,0],
        "always"],
    ["Kai x Lamia",
        ["MainActor1-3fs", "NPC emo"], [1,0],
        "always"],
    ["Kai Death",
        ["MainActor1-3fs", "NPC emo"], [1,0],
        "always"],
    ["Tal x Plant",
        ["MainActor1-3fs", "NPC emo"], [7,0],
        "self_switch_on", 22 , 35, 'A'],
#~     ["Kai x Succubus",
#~         ["Aka emo", "Aka emo", "Carina emo", "Carina emo", "Carina emo", "Carina emo"], [1, 0, 6, 5, 4, 7],
#~         "always"],
#~     ["Tal x Plant",
#~         ["Aka emo"], [2],
#~         "self_switch_on", 22 , 35, 'A'],
#~     ["Aka First Time",
#~         ["Aka emo"], [3],
#~         "always"],
#~     ["Sick Succubus",
#~         [], [],
#~         "switch_on", 122],
#~     ["Aka: Standing",
#~         [], [],
#~         "variable_at_least", 101, 50],
#~     ["Yarra: Titfuck",
#~         ["Aka emo"], [6],
#~         "variable_at_least", 103, 50],
#~     ["Qum: Doggie",
#~         ["Aka emo"], [7],
#~         "variable_at_least", 105, 50]
  ]

  EnableFiltering = true

  Categories = ["Simon", "Riala", "Yarra", "Aka", "Qum D'umpe", "NPC", "Hilstara", "Trin", "Megail", "Altina", "Varia", "Carina", "Esthera", "Nalili", "Harem", "Balia", "Lynine", "Orilise", "Iris", "Janine", "Wynn", "Elleani", "Dari", "Uyae", "Robin", "Sarai", "Sabitha", "Tertia", "Ivala", "Mithyn", "Zelica", "Ginasta", "Wendis", "Fheliel", "Neranda"].sort

  # If a scene is given the exact same name as any of the two following words, weird issues will happen
  FilterLabel = "Filter"
  SeparatorLabel = "-----"

  # For non-NPC sprites that don't follow the convention "<character name> emo"
  SpriteNameToCharacterName = {
    "face002b" => "Simon",
    "face002b dark" => "Simon",
    "1 Simon dark" => "Simon",
    "Wendis blond" => "Wendis",
    "Wendis grey" => "Wendis",
    "Monster1" => "Wendis",
    "Z Orcent" => "Orcent",
    "Dari1" => "Dari",
    "Dari2" => "Dari",
    "Robin blond" => "Robin",
    "Robin grey" => "Robin",
    "Sabitha H" => "Sabitha",
  }

  def self.check_scene_visible(scene_array)
    case scene_array[3]
    when "always"
      true
    when "switch_on"
      $game_switches[scene_array[4]]
    when "variable_at_least"
      $game_variables[scene_array[4]] >= scene_array[5]
    when "self_switch_on"
      $game_self_switches[ [scene_array[4], scene_array[5], scene_array[6]] ]
    else
      false
    end
  end

  # Dark magic to deduce a scene categories from its sprites
  def self.sprites_to_categories(sprites)
    sprites.map do |sprite_name|
      category = sprite_name.gsub(/\s+emo.*/, '')
      if TLS_Scenes::SpriteNameToCharacterName.has_key?(category)
        category = TLS_Scenes::SpriteNameToCharacterName[category]
      end
      # Group all minor characters within the NPC category
      unless TLS_Scenes::Categories.include?(category)
        category = "NPC"
      end
      category
    end.uniq
  end
end

class Scene_TLS_Replayer < Scene_MenuBase
  
  def start
    super
    create_select_window
    create_face_window
    TLS_Scenes::EnableFiltering and create_filter_window
  end
  
  
  def create_select_window
    @select_window = TLS_Replay_Select_Window.new(0, 0, Graphics.width / 2, Graphics.height)
    @select_window.viewport = @viewport
    @select_window.set_handler(:cancel, method(:return_scene))
    @select_window.set_handler(:ok, method(:play_event))
    @select_window.activate
    @select_window.refresh
  end
  
  def create_face_window
    @face_window = TLS_Replay_Face_Window.new(@select_window.width, 0, Graphics.width - @select_window.width, Graphics.height)
    @select_window.face_window = @face_window
  end
  
  def play_event
    if @select_window.is_filter_button?
      show_filter_window
      return
    end

    $game_temp.reserve_common_event(@select_window.get_current_event_id)
    Window_Message.lw_set_opaque(true)
    return_scene
  end
  
  def create_filter_window
    @filter_window = TLS_Scene_Filter.new(Graphics.width*1/16, Graphics.height*1/16, Graphics.width*7/8, Graphics.height*7/8)
    @filter_window.set_handler(:cancel, method(:reset_filter))
    @filter_window.set_handler(:ok, method(:set_filter))
    @filter_window.hide
  end

  def show_filter_window
    @filter_window.show
    @filter_window.activate
    @filter_window.select(0)
  end

  def hide_filter_window
    @filter_window.hide
    @select_window.activate
  end

  def set_filter
    filter = @filter_window.get_filter
    @select_window.filter_data(filter)
    hide_filter_window
  end

  def reset_filter
    @select_window.reset_data
    hide_filter_window
  end
end

class TLS_Replay_Select_Window < Window_Selectable
  
  def initialize(x, y, width, height)
    super(x, y, width, height)
    @data = get_data
    @filter = nil
    select(0)
    
  end
  
  def get_data
    result = TLS_Scenes::EnableFiltering ? [
      [TLS_Scenes::FilterLabel],
      [TLS_Scenes::SeparatorLabel],
    ] : []
    TLS_Scenes::Scene_data.each do |current|
      if(TLS_Scenes::check_scene_visible(current) ) then
        result.push([current[0], get_event_id_for_name(current[0]), current[1], current[2]])
      end
    end
    p(result)
    return result
  end

  def face_window= (window)
    @face_window = window
  end
  
  def get_event_id_for_name(name)
    $data_common_events.each do |current|
      if(current && current.name == name) then
        return current.id
      end
    end
  end
  
  def get_current_event_id
    return @data[index][1]
  end
    
  def draw_item(i)
    if @data[i][0] == TLS_Scenes::FilterLabel
      change_color(text_color(24))
      text = @data[i][0] + (@filter.nil? ? "" : ": " + @filter)
      draw_text(item_rect(i), text)
      return
    end

    change_color(normal_color, @data[i][0] != TLS_Scenes::SeparatorLabel)
    rect = item_rect(i)
    draw_text(rect, @data[i][0])
  end
  
  def item_max
    return @data ? @data.size : 0
  end
  
  def refresh
    create_contents
    draw_all_items
  end
  
  def update
    super

    if is_filter_button? || is_separator?
      @face_window.reset
      return
    end

    @face_window.set_faces(@data[index][2], @data[index][3]) if @data[index]
  end

  def is_filter_button?
    @data[index][0] == TLS_Scenes::FilterLabel
  end
  
  def is_separator?
    @data[index][0] == TLS_Scenes::SeparatorLabel
  end

  def current_item_enabled?
    !is_separator?
  end

  def reset_data
    @filter = nil
    @data = get_data
    refresh
  end

  def filter_data(filter)
    @filter = filter
    @data = get_data.select do |elt|
      next true if elt[0] == TLS_Scenes::FilterLabel or elt[0] == TLS_Scenes::SeparatorLabel
      TLS_Scenes::sprites_to_categories(elt[2]).include?(filter)
    end
    refresh
  end
end

class TLS_Replay_Face_Window < Window_Base
  def initialize(x, y, width, height)
    super(x, y, width, height)
  end
  
  def set_faces(face_names, face_IDs)
    contents.clear
    face_names.each_index do |index|
      draw_face(face_names[index], face_IDs[index], (index % 2) * 112, (index / 2) * 112)
    end
  end

  def reset()
    contents.clear
  end
end

class Window_Message
  alias lw_custom_update update
  def update
    lw_custom_update
    if(! defined? @@lw_opaque_flag) then
      @@lw_opaque_flag = false
    end
    
    if(@@lw_opaque_flag) then
      self.back_opacity = LW_Replay_Variables::Opacity_on
    else
      self.back_opacity = LW_Replay_Variables::Opacity_off
    end
  end
  
  
  def self.lw_set_opaque(flag)
    @@lw_opaque_flag = flag
    p(flag)
  end
end

class TLS_Scene_Filter < Window_Selectable
  def initialize(x, y, width, height)
    super
    # FIXME: Work as is, but does far more loops than it would with a different algorithm
    @data = TLS_Scenes::Categories.select do |category|
      TLS_Scenes::Scene_data.any? do |scene|
        TLS_Scenes::check_scene_visible(scene) and TLS_Scenes::sprites_to_categories(scene[1]).include?(category)
      end
    end
    self.z = 999 # Arbitrarily high number to force the window to appear above everything else on the screen
    refresh
  end

  def col_max
    5
  end

  def item_max
    @data ? @data.size : 0
  end

  def draw_item(index)
    item = @data[index]
    rect = item_rect(index)
    draw_text(rect, item)
  end

  def get_filter
    @data[index]
  end
end
