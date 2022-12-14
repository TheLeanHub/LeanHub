local Network = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/TheLeanHub/LeanHub/main/Network"))()
local Client = {
    Github = "https://rawgithubusercontent.com/TheLeanHub/LeanHub/tree/main/SupportedGame/",
    Games = {
        ["8069117419"] = "Demon%20Soul%20Simulator";
        ["10898965735"] = "Mine%20Racer";
        ["7525610732"] = "Kaizen";
        ["6569830174"] = "Lemon%20Funky";
        ["6679968919"] = "Fly Race";
    },
}

local MarketplaceService = game:GetService("MarketplaceService")
local MSName = MarketplaceService:GetProductInfo(game.PlaceId).Name

function GetGame()
    for PlaceId, GameName in next, Client.Games do
        if tostring(game.PlaceId) == PlaceId then
            return GameName
        end
    end
end

function LoadScript()
    local GameName = GetGame()
    if GameName then
        local Success, Error = pcall(function()
            loadstring(game:HttpGet(string.format("%s%s%s", Client.Github, GameName, ".lua")))()
        end)
        if not Success then
            warn(string.format('Failed to load script for game: "%s", Error: %s', string.gsub(GameName, "%%20", " "), Error))
        end
    else
        Network:Notify("Unsupported Game", string.format("%s is not Supported", MSName), 5)
        task.wait(1.5)
        Network:NotifyPrompt("Universal", "Would you like to load the universal script?", 30, function(Value)
            if Value then
                loadstring(game:HttpGet(string.format("%s%s", Client.Github, "Universal.lua")))()
            elseif not Value then
                return;
            end
        end)
    end
end

LoadScript()
