local function LimitPos(pos, dir, ply)	local trace_forward = util.TraceHull({		start = ply:EyePos(),		endpos = pos,		mins = ply:OBBMins() / 2,		maxs = ply:OBBMaxs() / 2,		filter = ents.FindInSphere(pos, 300),		mask = MASK_SOLID_BRUSHONLY,	})	if trace_forward.Hit and trace_forward.Entity ~= ply and not trace_forward.Entity:IsPlayer() and not trace_forward.Entity:IsVehicle() then		return trace_forward.HitPos + trace_forward.HitNormal * 1	end	return posendhook.Add("ShouldDrawLocalPlayer", "fishing", function(ply)	if not fishing.IsFishing() then return end	return trueend)local params = {}fishing.cam_smooth_pos = fishing.cam_smooth_pos or Vector()fishing.cam_smooth_dir = fishing.cam_smooth_dir or Vector()fishing.ScreenFocus = fishing.ScreenFocus or falsehook.Add("CalcView", "fishing", function(ply)	if not fishing.IsFishing() then return end	local wep = ply:GetActiveWeapon()	local ent = wep.dt.hook	if not ent:IsValid() then return end	local pos = ply:EyePos()	local ang = ply:EyeAngles()	local dir	if fishing.ScreenFocus and wep.screen_part then		pos = wep.screen_part.cached_pos		pos = pos + wep.screen_part.cached_ang:Up() * 20		pos = pos + wep.screen_part.cached_ang:Forward() * 5		dir = (wep.screen_part.cached_pos - pos):GetNormalized()	else		pos = pos + ang:Forward() * -70		pos = pos + ang:Right() * 50		dir = ang:Forward()	end	local delta = FrameTime() * 10	fishing.cam_smooth_pos = fishing.cam_smooth_pos + ((pos - fishing.cam_smooth_pos) * delta)	fishing.cam_smooth_dir = fishing.cam_smooth_dir + ((dir - fishing.cam_smooth_dir) * delta)	params.origin = fishing.cam_smooth_pos	params.angles = fishing.cam_smooth_dir:Angle()	local newpos = LimitPos(params.origin, ang:Forward(), ply)	if newpos then		params.origin = newpos		fishing.cam_smooth_pos = newpos	end	return paramsend)