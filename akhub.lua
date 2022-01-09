local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("AKHub", "GrapeTheme")
local Tab = Window:NewTab("Cheats")
local Section = Tab:NewSection("Legit")
Section:NewButton("Legit Aimbot", "ButtonInfo", function()
local mouse = game:GetService("Players").LocalPlayer:GetMouse()
local hold=false

--settings
local keybind=Enum.UserInputType.MouseButton1
local enablepconsole=false
local fov=25
local teamcheck=true

function WallCheck(position, part)
    local Raycast = RaycastParams.new()
    Raycast.FilterDescendantsInstances = {game:GetService("Players").LocalPlayer.Character, part.Parent}
    Raycast.FilterType = Enum.RaycastFilterType.Blacklist
    local Result = workspace:Raycast(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position, (position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).unit * (position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude, Raycast)
    if Result == nil then
        return true
    end
    return false
end

if teamcheck then
   if #game.Teams:GetChildren()<2 then
    
       teamcheck=false
   end
end

function getnearest()
   local nearest
   local kanker=math.huge
   for i,v in next, game:GetService("Players"):GetChildren() do
       if v and v.Character and v~=game:GetService("Players").LocalPlayer and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("Humanoid").Health>0 then
           if teamcheck then
               if v.Team ~= game.Players.LocalPlayer.Team then
                   if WallCheck(v.Character.Head.Position,v.Character.Head) or WallCheck(v.Character.Torso.Position,v.Character.Torso) then
                       local worldPoint = v.Character.Torso.Position
                       local vector, onScreen = workspace.CurrentCamera:WorldToScreenPoint(worldPoint)
                       local magnitude = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(vector.X, vector.Y)).magnitude
                       if kanker>magnitude and onScreen and magnitude<fov then
                           kanker=magnitude
                           nearest=v
                       end
                   end
               end
           else
               if WallCheck(v.Character.Head.Position,v.Character.Head) or WallCheck(v.Character.Torso.Position,v.Character.Torso) then
                   local worldPoint = v.Character.Head.Position
                   local vector, onScreen = workspace.CurrentCamera:WorldToScreenPoint(worldPoint)
                   local magnitude = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(vector.X, vector.Y)).magnitude
                   if kanker>magnitude and onScreen and magnitude<fov then
                       kanker=magnitude
                       nearest=v
                   end
               end
           end
       end
   end
   return nearest
end

game:GetService("UserInputService").InputBegan:connect(function(input)
   if input.UserInputType == Enum.UserInputType.MouseButton1 then
       hold=true
   end
end)

game:GetService("UserInputService").InputEnded:connect(function(input)
   if input.UserInputType == Enum.UserInputType.MouseButton1  then
       hold=false
   end
end)

game:GetService("RunService").RenderStepped:connect(function()
   if hold then
       if getnearest() then
           local vector, onScreen = workspace.CurrentCamera:WorldToScreenPoint(getnearest().Character.Torso.Position)
           local dist = (Vector2.new(vector.X, vector.Y) - Vector2.new(mouse.X,mouse.Y)).Magnitude
           local magnitudeX = mouse.X - vector.X
           local magnitudeY = mouse.Y - vector.Y
           mousemoverel(-magnitudeX*0.3,-magnitudeY*0.10)
           if enablepconsole then
               rconsoleprint("\nmoved "..math.floor(magnitudeX)+magnitudeX-math.floor(magnitudeX).." "..math.floor(magnitudeY)+magnitudeY-math.floor(magnitudeY).." to "..getnearest().Character.Name)
           end
           wait(0.3)
       end
   end
end)
end)

Section:NewButton("Spoofed HBE (4,5,1)", "ButtonInfo", function()
game:GetService("Workspace").DescendantAdded:Connect(function(instance)
    if instance.ClassName == "SelectionBox" then
        f = instance.Visible
        instance.Visible = false
        wait()
        local d =    instance.Adornee
        if d == d.Parent:FindFirstChild("HumanoidRootPart") then
            instance:Destroy()
        end
    
        instance.Visible = f
    end
end)

_G.rr = true

local UserInputService = game:GetService("UserInputService")
 
-- A sample function providing one usage of InputBegan

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.End then
            _G.rr = not _G.rr
        end
    end
end)

local mt = getrawmetatable(game)

local localPlayer = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

local function isPartVisible(obj)   
    local center = obj.Position

--  No need to do any extra calculations if the center point is on the screen
    local centerPoint, centerVisible = camera:WorldToScreenPoint(center)
    if centerVisible then
        return true --, centerPoint -- (centerPoint not used)
    end
    return false
end 


setreadonly(mt, false);
local old_index = mt.__index;
mt.__index = function(a, b)
    if tostring(a) == "Torso" then
        if tostring(b) == "Size" then
            return  Vector3.new(2,2,1)
        end
       end
    return old_index(a, b);
end

setreadonly(mt, false);
local old_index = mt.__index;
mt.__index = function(a, b)
    if tostring(a) == "HumanoidRootPart" then
        if tostring(b) == "Size" then
            return  Vector3.new(2,2,1)
        end
    end
    return old_index(a, b);
end
         

setreadonly(mt, false);
local old_index = mt.__index;
mt.__index = function(a, b)
    if tostring(a) == "HumanoidRootPart" then
        if tostring(b) == "Mass" then
            return 2.7999999523163
        end
    end
    return old_index(a, b);
end
         
setreadonly(mt, false);
local old_index = mt.__index;
mt.__index = function(a, b)
    if tostring(a) == "Torso" then
        if tostring(b) == "Mass" then
            return 2.7999999523163
        end
    end
    return old_index(a, b);
end
    
local mt = getrawmetatable(game)
local oldnamecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if (method == "GetMass") then
        if self.Name == "HumanoidRootPart" or self.Name == "Torso" then
            return 2.7999999523163
        end
    end
    return oldnamecall(self, ...)
end)

local t = {}
while true do
    wait(0.1)
    local _players = game:GetService("Players");
    local localplayer = _players.LocalPlayer
    local name = localplayer.Name
    local team = localplayer.Team
    for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") and v.Name ~= name and v:FindFirstChild("Torso") then
            if _players:FindFirstChild(v.Name) then
                if _players:FindFirstChild(v.Name).Team ~= team then
                    _G.head = v.HumanoidRootPart
                    if isPartVisible(v.Torso) and _G.rr then
                        local head = v.HumanoidRootPart
                        local castPoints = {head.Position}
                        local ignoreList = {}
                        for i,l in pairs( v:GetDescendants()) do
                            if l:IsA("Part") or l:IsA("MeshPart") then
                                table.insert(ignoreList,  (table.getn(ignoreList)+1), l )
                            end
                        end
                        local ff = workspace.CurrentCamera:GetPartsObscuringTarget(castPoints, ignoreList)
   
                        if v:FindFirstChild("Torso") then
                            v.Torso.Size = Vector3.new(2.001,2.001 ,1.001)
                            --print("torso")
                        end
                        if table.getn(ff) < 1 then
                            local head = v.HumanoidRootPart
                            head.Size = Vector3.new(4,5 ,1)
                            head.Transparency = 1
                            head.Color =Color3.fromRGB(255, 0, 0)
                            head.CanCollide = false
                            local lolve
                            lolve = head.Parent:GetPropertyChangedSignal("Parent"):Connect(function()
                                wait(3)
                                lolve:Disconnect()
                            end)
                        else
                            _G.head.Color =Color3.fromRGB(163, 162, 165)
                            _G.head.Size = Vector3.new(2, 2, 1)
                            _G.head.Transparency = 1
                            _G.head.CanCollide = true
                        end
                    else
                        _G.head.Color =Color3.fromRGB(163, 162, 165)
                        _G.head.Size = Vector3.new(8, 7, 4)
                        _G.head.Transparency = 1
                        _G.head.CanCollide = true
                    end
                end
            end
        end
    end
end
end)

Section:NewButton("RCL Firerate & Nospread", "ButtonInfo", function()
while wait() do 
    wait(5)
for i,v in next,getgc(true)do
    if type(v)=='table'and rawget(v,'AmmoClip')then
v.AmmoLimited = false 
v.SpreadBase = 0
v.ReloadDuration = 2
v.FireRate = 0.12
v.FireMulti = 1
v.DamageDefault = 10
end
end
end
end)
local Section = Tab:NewSection("Misc")
Section:NewButton("DDOS [KOHLS]", "ButtonInfo", function()
local remote = game:GetService("ReplicatedStorage"):WaitForChild("b\a\n\a\n\a")

while wait(5) do
game:GetService('RunService').RenderStepped:Connect(function()
    remote:FireServer("KuID")
end)
end
end)
Section:NewKeybind("GUI Toggle [CLICK TO SET KEYBIND]", "KeybindInfo", Enum.KeyCode.F, function()
	Library:ToggleUI()
end)
