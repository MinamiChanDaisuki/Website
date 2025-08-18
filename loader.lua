local api = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))();
api.script_id = "ba63e5108c182e73a0d0ab53587b6439";
local Players = game:GetService("Players")
local player = Players.LocalPlayer;
local status_api = api.check_key(script_key);

if not script_key then
    player:Kick("[ERROR] Authentication Failed - Key not found");
    return;
end;

local handlers_status = {
    KEY_VALID = function()
        pcall(api.purge_cache);
        api.load_script();
    end;
    KEY_HWID_LOCKED = function() player:Kick("[WARNING] HWID Locked - Reset your HWID") end;
    KEY_EXPIRED = function() player:Kick("[ERROR] Key Expired - Subscription ended") end;
    KEY_BANNED = function() player:Kick("[ERROR] Key Blacklisted - Access revoked") end;
    KEY_INCORRECT = function() player:Kick("[ERROR] Invalid Key - Your Cooked") end;
};

(handlers_status[status_api.code] or function()
    player:Kick("[ERROR] Authentication Error -", status_api.message);
end)();
