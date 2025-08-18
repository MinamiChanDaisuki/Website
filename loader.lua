local api = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))();
api.script_id = "ba63e5108c182e73a0d0ab53587b6439";
local Players = game:GetService("Players");
local Player = Players.LocalPlayer;
local status_api = api.check_key(script_key);

if not script_key then
    Player:Kick("[ERROR] Authentication Failed - Key not found");
    return;
end;

local handlers_status = {
    KEY_VALID = function()
        pcall(api.purge_cache);
        api.load_script();
    end;
    KEY_HWID_LOCKED = function() Player:Kick("[WARNING] HWID Locked - Reset your HWID") end;
    KEY_EXPIRED = function() Player:Kick("[ERROR] Key Expired - Subscription ended") end;
    KEY_BANNED = function() Player:Kick("[ERROR] Key Blacklisted - Access revoked") end;
    KEY_INCORRECT = function() Player:Kick("[ERROR] Invalid Key - Your Cooked") end;
};

(handlers_status[status_api.code] or function()
    Player:Kick("[ERROR] Authentication Error -", status_api.message);
end)();
