private ["_addedBaseNames","_wpList","_itemType","_baseName", "_magazines","_currentMagazine",
"_magazineClass","_allWeaponTypes","_allBannedWeapons","_itemInfo","_itemName",
"_rvgList", "_index", "_scope"];

params [
    ["_logic", objNull],
    "",
    ["_activated", true]
];

// Detect Mods that Require Custom Logic
B52_Heros_Enabled           = isClass(configfile >> "CfgPatches" >> "her_a3w_survive");
B52_KSS_Enabled             = isClass(configfile >> "CfgPatches" >> "tf_kss");
B52_Random_Vehicles_Enabled = isClass(configfile >> "CfgPatches" >> "b52_random_vehicles");
B52_Loot_Enabled            = isClass(configfile >> "CfgPatches" >> "b52_loot");
B52_Ravage_Enabled          = isClass (configfile >> "CfgMods" >> "Ravage");

if (B52_Loot_Enabled)
then {
    // Building Types
    B52_BuildingResidential = ["Structures","Structures_Town","Structures_Slums","Structures_Village"];
    B52_BuildingCommercial  = ["Structures_Commercial"];
    B52_BuildingIndustrial  = ["Structures_Infrastructure","Structures_Industrial"];
    B52_BuildingMilitary    = ["Structures_Military"];
    B52_BuildingSports      = ["Structures_Sports"];
    B52_BuildingTransit     = ["Structures_Transport","Structures_Airport","Structures_Cultural"];
    
    B52_Items     = ["Rangefinder","Binocular","ToolKit","FirstAidKit","ItemMap","MedKit","ItemGPS","ItemRadio","NVGoggles"];
    B52_Clothes   = ["H_Hat_camo","H_HelmetB_light","U_I_pilotCoveralls","H_Bandanna_camo","U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_tshirt","U_BG_Guerilla1_1","U_BG_Guerilla2_1","U_C_Poloshirt_burgundy","U_I_CombatUniform"];
    B52_Vests     = ["V_Chestrig_blk","V_BandollierB_blk","V_HarnessO_brn","V_PlateCarrier1_blk","V_Press_F","V_TacVest_blk"];
    B52_Backpacks = ["B_AssaultPack_blk","B_AssaultPack_cbr","B_AssaultPack_khk","B_Carryall_cbr","B_Carryall_khk","B_Carryall_mcamo","B_FieldPack_blk","B_FieldPack_cbr","B_FieldPack_khk"];

    if (B52_Heros_Enabled)
    then 
    {
        B52_Food = ["herl_dri_Canteen","herl_dri_Franta","herl_dri_milk","herl_dri_RedGul","herl_dri_Spirit","herl_dri_watera","herl_eat_bmr","herl_eat_CC","herl_eat_Fish","herl_eat_GB","herl_eat_grilledM","herl_eat_Rice","herl_eat_smr","herl_eat_TABA"];
    };

    if (B52_KSS_Enabled)
    then {
        B52_Food = ["herl_dri_Canteen","herl_dri_Franta","herl_dri_milk","herl_dri_RedGul","herl_dri_Spirit","herl_dri_watera","herl_eat_bmr","herl_eat_CC","herl_eat_Fish","herl_eat_GB","herl_eat_grilledM","herl_eat_Rice","herl_eat_smr","herl_eat_TABA"];
    };
};

if (B52_Random_Vehicles_Enabled)
then {
    B52_CivCars = ["C_Hatchback_01_F","C_Hatchback_01_sport_F","C_Offroad_01_F","C_SUV_01_F","C_Van_01_box_F","C_Van_01_fuel_F","C_Van_01_transport_F"];
};

if (B52_Ravage_Enabled)
then {
    {
        B52_Items pushBack _x;
    }foreach ["rvg_flare","rvg_toolkit","rvg_tire","rvg_hose","rvg_guttingKnife","rvg_Geiger","rvg_matches","rvg_purificationTablets","rvg_canOpener","rvg_Rabbit_Meat","rvg_Sheep_Meat","rvg_Chicken_Meat","rvg_Rabbit_Meat_Cooked","rvg_Sheep_Meat_Cooked","rvg_Chicken_Meat_Cooked","rvg_beans","rvg_bacon","rvg_milk","rvg_rice","rvg_rustyCan","rvg_plasticBottle","rvg_plasticBottlePurified","rvg_plasticBottleEmpty","rvg_spirit","rvg_franta","rvg_canteen","rvg_canteenPurified","rvg_canteenEmpty","rvg_rustyCanEmpty","rvg_beansEmpty","rvg_baconEmpty","rvg_spiritEmpty","rvg_frantaEmpty","rvg_canisterFuel_Empty","rvg_canisterFuel","rvg_antiRad","rvg_sleepingBag_Blue","rvg_foldedTent","rvg_money","rvg_notepad","rvg_docFolder"];
    
    // The following needs to be updated to handle the fact that Ravage items are loaded after this mod regardless of mod position.
    //_rvgList = (configfile >> "CfgMagazines") call BIS_fnc_getCfgSubClasses; 
    //{
    //    _scope = getNumber (configFile >> "CfgMagazines" >> _x >> "scope");
    //    _index = ((str _x) find "rvg_");
    //    
    //    if (_scope == 2 && _index > -1)
    //    then {
    //         B52_Items pushBack _x;    
    //    };
    //}foreach rvgList;
};

// Currently Populated as of 1.68
B52_AssaultRifles   = [];
B52_AssaultRiflesG  = [];
B52_Handguns        = [];
B52_MachineGuns     = [];
B52_MissleLaunchers = [];
B52_RocketLaunchers = [];
B52_SubmachineGuns  = [];
B52_SniperRifles    = [];
B52_WeaponTypes     = ["AssaultRifle","Handgun","MachineGun","MissileLauncher","RocketLauncher","Rifle","SubmachineGun","SniperRifle"];
_allBannedWeapons   = []; // Add any weapons here you want to ban

// Currently Empty as of 1.68
B52_Mortars          = [];
B52_BombLaunchers    = [];
B52_Cannons          = [];
B52_GrenateLaunchers = [];
B52_Launchers        = [];
B52_Shotguns         = [];
B52_Throws           = [];
B52_Rifles           = [];
B52_UnknownWeapons   = [];

// Currently Populated as of 1.68
B52_Magazines = [];
B52_Attatchments = [];
//B52_Artillery        = [];
//B52_Bullets          = [];
//B52_CounterMeasures  = [];
//B52_Flares           = [];
//B52_Grenades         = [];
//B52_Lasers           = [];
//B52_Missiles         = [];
//B52_Rockets          = [];
//B52_Shells           = [];
//B52_ShotgunShells    = [];
//B52_SmokeShells      = [];
//B52_UnknownMagazines = [];

_addedBaseNames = [];

// Populate Weapon Arrays
_wpList         = (configFile >> "cfgWeapons") call BIS_fnc_getCfgSubClasses;
{
    _itemInfo = isClass(configFile >> "cfgWeapons" >> _x >> "ItemInfo");
    _itemName = _x;
    if (_itemInfo) then { 
        _num =     getNumber (configFile >> "cfgWeapons" >> _itemName >> "ItemInfo" >> "type");
        if (_num == 201 || _num == 101 || _num == 302 || _num == 301)
        then {
               B52_Attatchments pushBack _itemName;
        };
    };
    
    if (getnumber (configFile >> "cfgWeapons" >> _x >> "scope") == 2) then {
        _itemType = _x call bis_fnc_itemType;
        
        if (((_itemType select 0) == "Weapon") && ((_itemType select 1) in B52_WeaponTypes)) then {
            _baseName = _x call BIS_fnc_baseWeapon;
            
            if (!(_baseName in _addedBaseNames) && !(_baseName in _allBannedWeapons)) then {
                _addedBaseNames pushBack _baseName;

                switch(_itemType select 1) do {
                    case "AssaultRifle" :
                    {
                        if(count getArray(configfile >> "cfgWeapons" >> _baseName >> "muzzles") > 1)
                        then
                        [{
                            B52_AssaultRiflesG pushBack _baseName
                        },
                        {
                            B52_AssaultRifles pushBack _baseName
                        }];
                    };
                    case "Handgun" :{B52_Handguns pushBack _baseName};
                    case "MachineGun" :{B52_MachineGuns pushBack _baseName};
                    case "MissileLauncher" :{B52_MissleLaunchers pushBack _baseName};
                    case "RocketLauncher" :{B52_RocketLaunchers pushBack _baseName};
                    case "SubmachineGun" :{B52_SubmachineGuns pushBack _baseName};
                    case "SniperRifle" :{B52_SniperRifles pushBack _baseName};
                    //case "Mortar" :{B52_Mortars pushBack _baseName};
                    //case "BombLauncher" :{B52_BombLaunchers pushBack _baseName};
                    //case "Cannon" :{B52_Cannons pushBack _baseName};
                    //case "GrenadeLauncher" :{B52_GrenateLaunchers pushBack _baseName};
                    //case "Launcher" :{B52_Launchers pushBack _baseName};
                    //case "Magazine" :{B52_Magazines pushBack _baseName};
                    //case "Shotgun" :{B52_Shotguns pushBack _baseName};
                    //case "Throw" :{B52_Throws pushBack _baseName};
                    //case "Rifle" :{B52_Rifles pushBack _baseName};
                    default{B52_UnknownWeapons pushBack _baseName};
                };
            };
        };
    };
} foreach _wpList;

//Populate Magazine Array
{
    _magazines = getArray(configFile >> "CfgWeapons" >> _x >> "magazines");
    
    for[{_k = 0}, {_k < count(_magazines)}, {_k = _k + 1}] do
    {
        _currentMagazine = _magazines select _k;
        if (getnumber (configFile >> "CfgMagazines" >> _currentMagazine >> "scope") == 2)
        then {
            _magazineClass   = configName(configFile >> "CfgMagazines" >> _currentMagazine);
            B52_Magazines pushBack _magazineClass;
        };
    };
    
}foreach _addedBaseNames;