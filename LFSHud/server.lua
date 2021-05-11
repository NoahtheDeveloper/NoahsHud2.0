-- Please do not touch the Functions Below


-- Basic Discord Send Message!
function sendToDiscord(color, name, message, footer)
	local embed = {
		  {
			  ["color"] = color,
			  ["title"] = "**".. name .."**",
			  ["description"] = message,
			  ["footer"] = {
				  ["text"] = footer,
			  },
		  }
	  }
  
	PerformHttpRequest('WEBHOOK FUCKING SHEESH', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
  end



-- Discord Identify
function GetDiscordPermissionSet(src)
	if usingDiscordPerms then
		local identifierDiscord = nil
		for k, v in ipairs(GetPlayerIdentifiers(src)) do
			if string.sub(v, 1, string.len("discord:")) == "discord:" then
				identifierDiscord = v
			end
		end

		if identifierDiscord then
			for i = 1, #discordRoleNames do
				if exports.DiscordChatRoles:IsRolePresent(src, discordRoleNames[i]) then
					return true
				else
					return false
				end
			end
		elseif identifierDiscord == nil then
			print("[XSpectic] No Discord ID found for '" .. GetPlayerName(src) .. "'")
			return false
		end
	end
end


local AOP2 = "~r~Not Released"

cooldown = 0
Faxvotestatus = false
FaxCurPT = false
curVersion = "3.1"

aopVoteLSCount = 0
aopVoteBCCount = 0
aopVoteStateCount = 0
aopVoteVineWoodCount = 0
aopVoteMirrorParkCount = 0
aopVoteDowntownCount = 0
aopVoteDavisCount = 0
aopVoteDelPCount = 0
aopVoteRockfordCount = 0
aopVoteSandyCount = 0
aopVoteHarmonyCount = 0
aopVoteGrapeSeedCount = 0
aopVotePaletoCount = 0

t = {
	voteLosSantos = aopVoteLSCount,
	voteBlaineCount = aopVoteBCCount,
	voteState = aopVoteStateCount,
	voteVinewood = aopVoteVineWoodCount,
	voteMirrorPark = aopVoteMirrorParkCount,
	voteDowntown = aopVoteDowntownCount,
	voteDavis = aopVoteDavisCount,
	voteDelPerro = aopVoteDelPCount,
	voteRockford = aopVoteRockfordCount,
	voteSandy = aopVoteSandyCount,
	voteHarmony = aopVoteHarmonyCount,
	voteGrape = aopVoteGrapeSeedCount,
	votePaleto = aopVotePaletoCount,
}

function GetDiscordPermissionSet(src)
	if usingDiscordPerms then
		local identifierDiscord = nil
		for k, v in ipairs(GetPlayerIdentifiers(src)) do
			if string.sub(v, 1, string.len("discord:")) == "discord:" then
				identifierDiscord = v
			end
		end

		if identifierDiscord then
			for i = 1, #discordRoleNames do
				if exports.discord_perms:IsRolePresent(src, discordRoleNames[i]) then
					return true
				else
					return false
				end
			end
		elseif identifierDiscord == nil then
			print("[XSpectic] No Discord ID found for '" .. GetPlayerName(src) .. "'")
			return false
		end
	end
end

RegisterServerEvent('AOP:Startup')
AddEventHandler('AOP:Startup', function()
	Wait(3000)
	TriggerClientEvent("AOP:RunConfig", -1)
	TriggerClientEvent("AOP:JoinMsg", -1)
	Wait(30000)
	SetMapName("RP : " .. FaxCurAOP)
end)


RegisterServerEvent('AOP:Startup2')
AddEventHandler('AOP:Startup2', function()
	Wait(3000)
	TriggerClientEvent("AOP:RunConfig", -1)
	TriggerClientEvent("AOP:JoinMsg", -1)
	Wait(30000)
	SetMapName("RP : " .. AOP2)
end)

TriggerEvent("AOP:Startup")

msg = ""


RegisterCommand(AOPCommand, function(source, args, rawCommand)
	if source == 0 or IsPlayerAceAllowed(source, "faxes.aopcmds") or GetDiscordPermissionSet(source) or not usingPerms then
		FaxCurAOP = table.concat(args, " ")
		
		if(source == 0)then;print("Status changed to: " .. FaxCurAOP);end
		 
		
		--TriggerEvent('notifications', -1, "#02eeff", "Current Status:",  FaxCurAOP);		
		TriggerEvent("AOP:Sync")
		-- TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n RP AREA IS NOW : ".. FaxCurAOP .." \n " .. SecondaryMessageAOP .. "\n ——————————————————————", {239, 0, 0})
		SetMapName("RP : " .. FaxCurAOP)
		if AOPChangeNotification then
		TriggerClientEvent('notifications', -1, "#02eeff", "Current Status:",  FaxCurAOP);		
		--sendToDiscord(3124932,'__**LFS ATC Status**__:',' **Player:** ' .. GetPlayerName(src) .. '\n\n**Current Status:** ' .. FaxCurAOP '');	
		sendToDiscord(16753920, "Lucaas FS Status | Player Name & Status", '**Current Status: **' .. FaxCurAOP .. '\n\n **Player:** '  .. GetPlayerName(source) , "Lucaas FS - Made by XSpectic")
	end
	else
		TriggerClientEvent('AOP:NoPerms', source)
	end
end)




RegisterServerEvent('AOP:Sync')
AddEventHandler('AOP:Sync', function()
	TriggerClientEvent('AOP:SendAOP', -1, FaxCurAOP)
end)

RegisterServerEvent('AOP:Sync2')
AddEventHandler('AOP:Sync2', function()
	TriggerClientEvent('AOP:SendAOP2', -1, AOP2)
end)

Citizen.CreateThread(function() 
while true do
Citizen.Wait(100)

TriggerClientEvent('AOP:SendAOP2', -1, AOP2)

end
end)

RegisterCommand(PTCommand, function(source, args, rawCommand)
	if peacetime then
		if source == 0 or IsPlayerAceAllowed(source, "faxes.aopcmds") or GetDiscordPermissionSet(source) or not usingPerms then
			if(source == 0)then;print("Peacetime toggled");end
			if not FaxCurPT then
				-- TriggerClientEvent("chatMessage", -1, PTOnMessage, {239, 0, 0})
				-- TriggerClientEvent("AOP:PTSound", -1)
				--TriggerClientEvent("AOP:DisNotification", -1, PTOnMessage)
				TriggerClientEvent('notifications', -1, "#3474eb", "Emergencys Enabled:",  PTOnMessage);
				FaxCurPT = true
				TriggerEvent('AOP:PTSync')
			elseif FaxCurPT then
				-- TriggerClientEvent("chatMessage", -1, PTOffMessage, {239, 0, 0})
				--TriggerClientEvent("AOP:DisNotification", -1, PTOffMessage)
				TriggerClientEvent('notifications', -1, "#3474eb", "Emergencys Disabled:",  PTOffMessage);
				FaxCurPT = false
				TriggerEvent('AOP:PTSync')
			end
		else
			TriggerClientEvent('AOP:NoPerms', source)
		end
	end
end)

RegisterServerEvent('AOP:PTSync')
AddEventHandler('AOP:PTSync', function()
	TriggerClientEvent('AOP:SendPT', -1, FaxCurPT)
end)

-- AOP Command for Vote
RegisterCommand(AOPVoteCommand, function(source, args, rawCommand)
	if vote then
		if source == 0 or IsPlayerAceAllowed(source, "faxes.aopcmds") or GetDiscordPermissionSet(source) or not usingPerms then
			if(source == 0)then;print("AOP vote started");end
			Faxvotestatus = true
			TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n RP AREA VOTE \n Use /vote. Vote Lasts 3 Minutes.  \n ——————————————————————", {239, 0, 0})
			Wait(120000)
			TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n RP AREA VOTE \n Use /vote. 1 Minute Remaining.  \n ——————————————————————", {239, 0, 0})
			Wait(60000)
			Faxvotestatus = false
			local key = next(t)
			local max = t[key]

			for k, v in pairs(t) do
				if t[k] > max then
					key, max = k, v
				end
			end

			print(key, max) -- *** Testing ****

			if tostring(key) == "voteLosSantos" then
				FaxCurAOP = "Los Santos"
			elseif tostring(key) == "voteBlaineCount" then
				FaxCurAOP = "Blaine County"
			elseif tostring(key) == "voteState" then
				FaxCurAOP = "State wide"
			elseif tostring(key) == "voteVinewood" then
				FaxCurAOP = "Vinewood"
			elseif tostring(key) == "voteMirrorPark" then
				FaxCurAOP = "Mirror Park"
			elseif tostring(key) == "voteDowntown" then
				FaxCurAOP = "Downtown LS"
			elseif tostring(key) == "voteDavis" then
				FaxCurAOP = "Davis"
			elseif tostring(key) == "voteDelPerro" then
				FaxCurAOP = "Del Perro"
			elseif tostring(key) == "voteSandy" then
				FaxCurAOP = "Sandy Shores"
			elseif tostring(key) == "voteHarmony" then
				FaxCurAOP = "Harmony"
			elseif tostring(key) == "voteGrape" then
				FaxCurAOP = "Grapeseed"
			elseif tostring(key) == "votePaleto" then
				FaxCurAOP = "Paleto Bay"
			end

			if tostring(key) == "voteLosSantos" then
				AOP2 = "Los Santos"
			elseif tostring(key) == "voteBlaineCount" then
				AOP2 = "Blaine County"
			elseif tostring(key) == "voteState" then
				AOP2 = "State wide"
			elseif tostring(key) == "voteVinewood" then
				AOP2 = "Vinewood"
			elseif tostring(key) == "voteMirrorPark" then
				AOP2 = "Mirror Park"
			elseif tostring(key) == "voteDowntown" then
				AOP2 = "Downtown LS"
			elseif tostring(key) == "voteDavis" then
				AOP2 = "Davis"
			elseif tostring(key) == "voteDelPerro" then
				AOP2 = "Del Perro"
			elseif tostring(key) == "voteSandy" then
				AOP2 = "Sandy Shores"
			elseif tostring(key) == "voteHarmony" then
				AOP2 = "Harmony"
			elseif tostring(key) == "voteGrape" then
				AOP2 = "Grapeseed"
			elseif tostring(key) == "votePaleto" then
				AOP2 = "Paleto Bay"
			end

			TriggerEvent("AOP:Sync")
			TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n RP AREA IS NOW : ".. FaxCurAOP .." \n Vote score: " .. tostring(max) .. "\n ——————————————————————", {239, 0, 0})
			SetMapName("RP : " .. FaxCurAOP)

			TriggerEvent("AOP:Sync2")
			TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n RP AREA IS NOW : ".. AOP2 .." \n Vote score: " .. tostring(max) .. "\n ——————————————————————", {239, 0, 0})
			SetMapName("RP : " .. AOP2)

			Wait(3000)
			aopVoteLSCount = 0;aopVoteBCCount = 0;aopVoteStateCount = 0;aopVoteVineWoodCount = 0;aopVoteMirrorParkCount = 0;aopVoteDowntownCount = 0;
			aopVoteDavisCount = 0;aopVoteDelPCount = 0;aopVoteRockfordCount = 0;aopVoteSandyCount = 0;aopVoteHarmonyCount = 0;aopVoteGrapeSeedCount = 0;aopVotePaletoCount = 0
		else
			TriggerClientEvent('AOP:NoPerms', source)
		end
	end
end)

RegisterCommand("vote", function(source, args, rawCommand)
	local name = GetPlayerName(source)
	local arg1 = tostring(args[1])

	if not TriggerClientEvent("AOP:CheckVoteStatus", source) then
		CancelEvent()
	end
	
	if Faxvotestatus then
		if string.lower(arg1) == "ls" then
			TriggerClientEvent('chatMessage', -1, "^5" .. name .. " ^4Has Voted For: ^7Los Santos")
			aopVoteLSCount = aopVoteLSCount + 1
		elseif string.lower(arg1) == "state" then
			TriggerClientEvent('chatMessage', -1, "^5" .. name .. " ^4Has Voted For: ^7State-wide")
			aopVoteStateCount = aopVoteStateCount + 1
		elseif string.lower(arg1) == "bc" then
			TriggerClientEvent('chatMessage', -1, "^5" .. name .. " ^4Has Voted For: ^7Blaine County")
			aopVoteBCCount = aopVoteBCCount + 1
		elseif string.lower(arg1) == "vinew" then
			TriggerClientEvent('chatMessage', -1, "^5" .. name .. " ^4Has Voted For: ^7Vinewood")
			aopVoteVineWoodCount = aopVoteVineWoodCount + 1
		elseif string.lower(arg1) == "mirrorp" then
			TriggerClientEvent('chatMessage', -1, "^5" .. name .. " ^4Has Voted For: ^7Mirror Park")
			aopVoteMirrorParkCount = aopVoteMirrorParkCount + 1
		elseif string.lower(arg1) == "downt" then
			TriggerClientEvent('chatMessage', -1, "^5" .. name .. " ^4Has Voted For: ^7Down Town")
			aopVoteDowntownCount = aopVoteDowntownCount + 1
		elseif string.lower(arg1) == "davis" then
			TriggerClientEvent('chatMessage', -1, "^5" .. name .. " ^4Has Voted For: ^7Davis")
			aopVoteDavisCount = aopVoteDavisCount + 1
		elseif string.lower(arg1) == "delperro" then
			TriggerClientEvent('chatMessage', -1, "^5" .. name .. " ^4Has Voted For: ^7Del Perro")
			aopVoteDelPCount = aopVoteDelPCount + 1
		elseif string.lower(arg1) == "rockfordh" then
			TriggerClientEvent('chatMessage', -1, "^5" .. name .. " ^4Has Voted For: ^7Rockford Hills")
			aopVoteRockfordCount = aopVoteRockfordCount + 1
		elseif string.lower(arg1) == "sandy" then
			TriggerClientEvent('chatMessage', -1, "^5" .. name .. " ^4Has Voted For: ^7Sandy Shores")
			aopVoteSandyCount = aopVoteSandyCount + 1
		elseif string.lower(arg1) == "harmony" then
			TriggerClientEvent('chatMessage', -1, "^5" .. name .. " ^4Has Voted For: ^7Harmony")
			aopVoteHarmonyCount = aopVoteHarmonyCount + 1
		elseif string.lower(arg1) == "grapes" then
			TriggerClientEvent('chatMessage', -1, "^5" .. name .. " ^4Has Voted For: ^7Grapeseed")
			aopVoteGrapeSeedCount = aopVoteGrapeSeedCount + 1
		elseif string.lower(arg1) == "paletob" then
			TriggerClientEvent('chatMessage', -1, "^5" .. name .. " ^4Has Voted For: ^7Paleto Bay")
			aopVotePaletoCount = aopVotePaletoCount + 1
		else
			TriggerClientEvent('chatMessage', source, "^3Command Usage: \n/vote <area> \n^1Areas: \n^7ls, state, bc, vinew, mirrorp, downt, davis, delperro, rockfordh, sandy, harmony, grapes, paletob")
		end
	else
		TriggerClientEvent('AOP:NoVote', source)
	end
end)

Citizen.CreateThread(function()
    while autoChangeAOP do
		local players = GetPlayers()
		for a = 1, #players do
			if players[a] > "30" then -- over 30
				FaxCurAOP = ACAOPOver30
				SetMapName("RP : " .. FaxCurAOP)
				TriggerEvent("AOP:Sync")
			elseif players[a] < "5" then -- under 5
				FaxCurAOP = ACAOPUnder5
				SetMapName("RP : " .. FaxCurAOP)
				TriggerEvent("AOP:Sync")
			elseif players[a] < "10" then -- under 10
				FaxCurAOP = ACAOPUnder10
				SetMapName("RP : " .. FaxCurAOP)
				TriggerEvent("AOP:Sync")
			elseif players[a] < "20" then -- under 20
				FaxCurAOP = ACAOPUnder20
				SetMapName("RP : " .. FaxCurAOP)
				TriggerEvent("AOP:Sync")
			elseif players[a] < "30" then -- under 30
				FaxCurAOP = ACAOPUnder30
				SetMapName("RP : " .. FaxCurAOP)
				TriggerEvent("AOP:Sync")
			end
		end
		TriggerEvent("AOP:Sync")

		for a = 1, #players do
			if players[a] > "30" then -- over 30
				AOP2 = ACAOPOver30
				SetMapName("RP : " .. AOP2)
				TriggerEvent("AOP:Sync")
			elseif players[a] < "5" then -- under 5
				AOP2 = ACAOPUnder5
				SetMapName("RP : " .. AOP2)
				TriggerEvent("AOP:Sync")
			elseif players[a] < "10" then -- under 10
				AOP2 = ACAOPUnder10
				SetMapName("RP : " .. AOP2)
				TriggerEvent("AOP:Sync")
			elseif players[a] < "20" then -- under 20
				AOP2 = ACAOPUnder20
				SetMapName("RP : " .. AOP2)
				TriggerEvent("AOP:Sync")
			elseif players[a] < "30" then -- under 30
				AOP2 = ACAOPUnder30
				SetMapName("RP : " .. AOP2)
				TriggerEvent("AOP:Sync2")
			end
		end
		TriggerEvent("AOP:Sync2")
		Citizen.Wait(90 * 1000)
	end
end)















