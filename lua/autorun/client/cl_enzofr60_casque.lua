surface.CreateFont( "enzoFR60:Casque:TimerBar:Font", {
	font = "Arial Black",
	size = ScrH()*0.04,
	weight = 800,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
})


net.Receive("enzofr60:Casque:TimerBar", function()
	local CurTimeDelete = CurTime()
	
	hook.Add("HUDPaint", "HUDPaint:enzoFR60:Casque:TimerBar", function()
		local scrw, scrh = ScrW(), ScrH()
		local enzofr60_casquetimer_progress = math.Remap( CurTime() - CurTimeDelete, 1, 0, 400, 0 )
		surface.SetDrawColor( Color( 30, 30, 30, 200 ) )
		surface.DrawRect( scrw*.74, scrh*.5, scrw*.25, scrh*.09 )
	  	draw.RoundedBox( 1, scrw*.74, scrh*.5, enzofr60_casquetimer_progress-49, scrh*.09, Color( 30, 30, 30, 200 ) )

	  	draw.SimpleText( "Wait ...", "enzoFR60:Casque:TimerBar:Font", scrw*.865, scrh*.545, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )	
	end)

	timer.Simple(1,function()
		hook.Remove( "HUDPaint", "HUDPaint:enzoFR60:Casque:TimerBar" )
		net.Start("enzofr60:Casque:Drop")
		net.SendToServer()
	end )
end )

local modelcasque = ClientsideModel( "models/enzofr60/prop/enzofr60_casque.mdl" )
if IsValid(modelcasque) then
	modelcasque:SetNoDraw( true )
	hook.Add("PostPlayerDraw", "enzofr60_Casque_PostDrawPlayer", function(ply)
			if not IsValid( ply ) or not ply:Alive() then return end
			if ply:GetNWBool("enzofr60_equiper_casque") == true then
				local attach_id = ply:LookupAttachment( "eyes" )
				if not attach_id then return end
				local attach = ply:GetAttachment( attach_id )
				if not attach then return end

				local pos = attach.Pos
				local ang = attach.Ang

				modelcasque:SetModelScale( 0.88, 0 )
				pos = pos + ( ang:Forward() * -1.75 ) + ( ang:Up() * 0 ) + ( ang:Right() * -0.7 )
				ang:RotateAroundAxis( ang:Up(), 0 )
				ang:RotateAroundAxis( ang:Forward(), 0 )

				modelcasque:SetPos( pos )
				modelcasque:SetAngles( ang )

				modelcasque:SetRenderOrigin( pos )
				modelcasque:SetRenderAngles( ang )
				modelcasque:SetupBones()
				modelcasque:DrawModel()
				modelcasque:SetRenderOrigin()
				modelcasque:SetRenderAngles()
		end
	end)
end