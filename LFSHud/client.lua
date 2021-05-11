
local cooldown = 0
peacetimeActive = false
local year, month, day, hour, minute, second = GetLocalTime()
local AOPxNew = 0.675
local AOPyNew = 1.600





AddEventHandler('onClientMapStart', function()
    TriggerEvent('AOP:RunConfig')
    Wait(2000)
    TriggerServerEvent('AOP:Sync')
    TriggerServerEvent('AOP:Sync2')
    TriggerServerEvent('AOP:PTSync')
    TriggerEvent('AOP:JoinMsg')
end)

AddEventHandler('playerSpawned', function()
    local ped = GetPlayerPed(-1)
    if AOPSpawnsEnabled then
        TriggerEvent('AOP:SetPlayerSpawnPoint', ped)
    end
end)

togglehud5 = true

Citizen.CreateThread(function()
  while true do
Citizen.Wait(0)
if IsControlJustPressed(1,  311) then
if togglehud5 == false then
   
    togglehud5 = true

else 
    
    togglehud5 = false
    
end
 
end
end
end)

RegisterNetEvent('AOP:NoPerms')
AddEventHandler('AOP:NoPerms', function()
    ShowInfo(noPermsMessage)
end)

RegisterNetEvent('Fax:ClientPrint')
AddEventHandler('Fax:ClientPrint', function(text)
    print(text)
end)
    
RegisterNetEvent('AOP:NoVote')
AddEventHandler('AOP:NoVote', function()
    ShowInfo("~w~AOP Vote Is Currently Not Active.")
end)

RegisterNetEvent('AOP:DisNotification')
AddEventHandler('AOP:DisNotification', function(textPassed)
    SetTextComponentFormat("STRING")
    AddTextComponentString(textPassed)
    DisplayHelpTextFromStringLabel(0, 0, 1, - 1)
end)

RegisterNetEvent('AOP:PTSound')
AddEventHandler('AOP:PTSound', function()
    PlaySoundFrontend(-1,"CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET",1)
end)

RegisterNetEvent('AOP:RunConfig')
AddEventHandler('AOP:RunConfig', function()
    if AOPLocation == 0 then -- Default
        if serverPLD then
            AOPxNew = 0.675
            AOPyNew = 1.330
            AOPyNew2 = AOPyNew + 0.025
        else
            AOPxNew = 0.660
            AOPyNew = 1.430
            AOPyNew2 = AOPyNew + 0.025
        end
    elseif AOPLocation == 1 then -- Bottom Center
        AOPxNew = 1.000
        AOPyNew = 1.430
        AOPyNew2 = AOPyNew + 0.025
    elseif AOPLocation == 2 then -- Bottom Right [WIP]
        AOPxNew = 0.660
        AOPyNew = 1.430
        AOPyNew2 = AOPyNew + 0.025
    elseif AOPLocation == 3 then -- Top Right [WIP]
        AOPxNew = 0.660
        AOPyNew = 1.430
        AOPyNew2 = AOPyNew + 0.025
    elseif AOPLocation == 4 then -- Top Center
        AOPxNew = 1.000
        AOPyNew = 0.50
        AOPyNew2 = AOPyNew + 0.025
    elseif AOPLocation == 5 then -- Top Left
        AOPxNew = 0.00
        AOPyNew = 0.50
        AOPyNew2 = AOPyNew + 0.025
    elseif AOPLocation == 6 then -- Custom
        AOPxNew = AOPx
        AOPyNew = AOPy
        AOPyNew2 = AOPyNew + 0.025
    end

    Citizen.Trace("[FAXES AOP SCRIPT] Config Ran")
end)


RegisterNetEvent('AOP:SendAOP')
AddEventHandler('AOP:SendAOP', function(newCurAOP)
    FaxCurAOP = newCurAOP
end)



RegisterNetEvent('AOP:SendPT')
AddEventHandler('AOP:SendPT', function(newCurPT)
    peacetimeActive = newCurPT
end)

RegisterNetEvent('AOP:SetPlayerSpawnPoint')
AddEventHandler('AOP:SetPlayerSpawnPoint', function(ped)
    for i=1, #AOPSpawns do
        local AOPTab = AOPSpawns[i]
        if string.lower(AOPTab.AOPName) == string.lower(FaxCurAOP) then
            SetEntityCoords(ped, AOPTab.AOPCoords.x, AOPTab.AOPCoords.y, AOPTab.AOPCoords.z)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if localTime == 1 then -- client time
            year, month, day, hour, minute, second = GetLocalTime()
            newMinute = minute
            if minute < 10 then
                newMinute = "0" .. minute
            end
            DrawTextAOP(AOPxNew, 1.330 , 1.0,1.0,0.45, "".. featColor .. "~b~Time: ~w~" .. hour .. ":" .. newMinute .. featColor .." ~b~| ~o~Date: ~w~" .. day .. featColor .."~w~/~w~" .. month .. featColor .. "~w~/~w~" .. year.. "", 255, 255, 255, 255)
        elseif localTime == 2 then
            year = GetClockYear();month = GetClockMonth();day = GetClockDayOfMonth()
            hour = GetClockHours();minute = GetClockMinutes();second = GetClockSeconds()
            newMinute = minute
            if minute < 10 then
                newMinute = "0" .. minute
            end
            DrawTextAOP(AOPxNew, 1.330 , 1.0,1.0,0.45, "".. featColor .. "Time: ~w~" .. hour .. ":" .. newMinute .. featColor .." | Date: ~w~" .. day .. featColor .."/~w~" .. month .. featColor .. "/~w~" .. year.. "", 255, 255, 255, 255)
        elseif localTime == 0 then
            drawTimeText = ""
        end
        Citizen.Wait(1)
        local player = GetPlayerPed(-1)
        local veh = GetVehiclePedIsIn(player)
        local mph = math.ceil(GetEntitySpeed(veh) * 2.23)

        if ((peacetimeActive) and (togglehud5 == true)) then
            if peacetimeNS then
                if IsControlPressed(0, 106) then
                    --ShowInfo("~g~ATC ~w~Enabled ~r~EMERGENCIES.")
                end
                SetPlayerCanDoDriveBy(player, false)
            end
   


            DrawTextAOP(AOPxNew, 1.375, 1.0,1.0,0.45, "~b~ATC " .. featColor .. "~o~Status: ~w~" .. FaxCurAOP .. featColor .. "", 255, 255, 255, 255)
            DrawTextAOP(AOPxNew, 1.353, 1.0,1.0,0.45, "~b~Emergencies: ~g~Allowed", 255, 255, 255, 255)
            DrawTextAOP(AOPxNew, 1.309, 1.0,1.0,0.35, "~o~discord.gg/lfs", 255, 255, 255, 255)
            --DrawTextAOP(AOPxNew, AOPyNew5, 1.0,1.0,0.45, "~b~Server Information", 255, 255, 255, 255)
        elseif ((not peacetimeActive) and (togglehud5 == true))  then
            if peacetime then
               -- DrawTextAOP(AOPxNew, AOPyNew5, 1.0,1.0,0.45, "~b~Server Information", 255, 255, 255, 255)
                DrawTextAOP(AOPxNew, 1.375, 1.0,1.0,0.45, "~b~ATC " .. featColor .. "~o~Status: ~w~" .. FaxCurAOP .. featColor .. "", 255, 255, 255, 255)
                DrawTextAOP(AOPxNew, 1.353, 1.0,1.0,0.45, "~b~Emergencies: ~r~Not Allowed", 255, 255, 255, 255)
                DrawTextAOP(AOPxNew, 1.309, 1.0,1.0,0.35, "~o~discord.gg/lfs", 255, 255, 255, 255)
            else
                DrawTextAOP(AOPxNew, AOPyNew3, 1.0,1.0,0.45, drawTimeText, 255, 255, 255, 255)
                DrawTextAOP(AOPxNew, 1.375, 1.0,1.0,0.45, "~b~ATC " .. featColor .. "~o~Status: ~w~" .. FaxCurAOP, 255, 255, 255, 255)
            end
        end
    end
end)

function DrawTextAOP(x,y ,width,height,scale, text, r,g,b,a)
    if AOPLocation == 1 or AOPLocation == 4 then
        SetTextCentre(true)
    end
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function ShowInfo(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(true, false)
end




-- MADE BY NOAHBRAHIM (DO NOT REMOVE)
RegisterNetEvent('notifications')
AddEventHandler('notifications', function(color, title, message)
    SendNUIMessage({
        type = "custom",
        color = color,
		title = title,
        message = message,
    })
    
	PlaySoundFrontend(-1,"CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET",1)
end)


Citizen.CreateThread(function()
	while true do 
		Wait(0);
		if ann ~= nil and announcement then 
			-- 70 character limit per announcement using .8
			Draw2DText(.5, .3, header, 1.5, true);
			--Draw2DText(.5, .5, ann, 0.8, true);
			local cout = .4;
			if #ann > 70 then 
				for i = 1, #anns do 
					Draw2DText(.5, cout, anns[i], 0.8, true);
					cout = cout + .05;
				end
			else 
				Draw2DText(.5, cout, ann, 0.8, true);
			end
		end
	end
end)


