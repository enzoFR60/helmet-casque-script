util.AddNetworkString( "enzofr60:Casque:TimerBar" )
util.AddNetworkString( "enzofr60:Casque:Drop" )

hook.Add('PlayerDeath', 'enzofr60_casque_deadhook', function(victim, weapon, killer)
	if IsValid(victim) then
		if victim:GetNWBool("enzofr60_equiper_casque") == true then
			victim:SetNWBool("enzofr60_equiper_casque", false)
		end
	end
end)

hook.Add("PlayerButtonDown", "enzoFR60_equip_casque_KeyDown", function(ply, btn)
	if not IsValid(ply) then return end
	if btn == KEY_B then
		if ply:GetNWBool("enzofr60_equiper_casque") == false then return end
		net.Start( "enzofr60:Casque:TimerBar" )
		net.Send( ply )
		ply:SetNWBool("enzofr60_equiper_casque", false)
	end
end)
net.Receive("enzofr60:Casque:Drop", function(len, ply)
	if not IsValid(ply) then return end
	local helmet = ents.Create( "enzofr60_casque" )
	if ( !IsValid( helmet ) ) then return end
	helmet:SetPos( ply:LocalToWorld(Vector(30, 0, 10)) )
	helmet:Spawn()
end)