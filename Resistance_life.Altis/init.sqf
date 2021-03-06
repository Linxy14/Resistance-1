//_logistic = execVM "=BTC=_Logistic\=BTC=_Logistic_Init.sqf";
enableSaving [false, false];

X_Server = false;
X_Client = false;
X_JIP = false;
StartProgress = false;

if(!isDedicated) then { X_Client = true;};
enableSaving[false,false];

life_versionInfo = "Altis Life RPG v3.1.4.5";
[] execVM "briefing.sqf"; //Load Briefing
[] execVM "KRON_Strings.sqf";
[] execVM "statusBar.sqf";
[] execVM "zlt_fastrope.sqf";
//marché
    if(isDedicated && isNil("life_market_prices")) then
    {
    [] call life_fnc_marketconfiguration;
    diag_log "Les prix du marché ont été généré !";
     
    "life_market_prices" addPublicVariableEventHandler
    {
    diag_log format["Prix du marché mis à jour ! %1", _this select 1];
    };
     
    //Start server fsm
    [] execFSM "core\fsm\server.fsm";
    diag_log "Serveur FSM exécuté";
    };
//fin

BipBipOn=true;
publicVariable "BipBipOn";

StartProgress = true;

"BIS_fnc_MP_packet" addPublicVariableEventHandler {_this call life_fnc_MPexec};

MAC_fnc_switchMove = {
private["_object","_anim"];
_object = _this select 0;
_anim = _this select 1;

_object switchMove _anim;

};

onPlayerDisconnected { [_id, _name, _uid] call compile preProcessFileLineNumbers "core\functions\fn_onPlayerDisconnect.sqf" };