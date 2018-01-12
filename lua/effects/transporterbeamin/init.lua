//Based on the CDS_Disintegrate effect
//All credits go to the CDS team !!!
// BEAM FADE IN
function EFFECT:Init(data)
	self.entity = data:GetEntity()
	if(!self.entity:IsValid()) then return end
	self.mag = math.Clamp(self.entity:BoundingRadius()/1,200,99999) //Amount of Particles. IDEA: make the number of particles relative to boundingbox size
	self.dur = 4 +CurTime()
	self.emitter = ParticleEmitter(self.entity:GetPos())
	self.amp = 255/data:GetScale()
end

function EFFECT:Think()
	if not self.entity:IsValid() then return false end
	local t = CurTime()
	local vOffset = self.entity:GetPos()
	local Low, High = self.entity:WorldSpaceAABB() //Size based on BoundingBox
	for i=1, self.mag do --don't fuck with this or you FPS dies
		local vPos = Vector(math.random(Low.x,High.x), math.random(Low.y,High.y), math.random(Low.z,High.z))
		local particle = self.emitter:Add("particles/fire_glow", vPos)
		if (particle) then
			particle:SetColor(255,255,255,255)
			particle:SetVelocity(Vector(0,0,15))
			particle:SetLifeTime(0)
			particle:SetDieTime(.9)
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(255)
			particle:SetStartSize(2)
			particle:SetEndSize(.1)
			particle:SetRoll(math.random(0, 360))
			particle:SetRollDelta(0)
			particle:SetAirResistance(100)
			particle:SetGravity(Vector(0, 0, 0))
			particle:SetBounce(0.3)
			--particle:SetAngles(self.HowYouPosing)
		end
		local particle2 = self.emitter:Add("particles/fire_glow", vPos)
		if (particle2) then
			particle2:SetColor(255,255,255,255)
			particle2:SetVelocity(Vector(0,0,-15))
			particle2:SetLifeTime(0)
			particle2:SetDieTime(.9)
			particle2:SetStartAlpha(255)
			particle2:SetEndAlpha(255)
			particle2:SetStartSize(2.5)
			particle2:SetEndSize(.1)
			particle2:SetRoll(math.random(0, 360))
			particle2:SetRollDelta(0)
			particle2:SetAirResistance(100)
			particle2:SetGravity(Vector(0, 0, 0))
			particle2:SetBounce(0.3)
			--particle2:SetAngles(self.HowYouPosing)
		end
	end
	local dlight1 = DynamicLight( LocalPlayer():EntIndex() )
	if (dlight1) then
		dlight1.pos = self.entity:GetPos()
		dlight1.r = 255
		dlight1.g = 255
		dlight1.b = 255
		dlight1.brightness = 15
		dlight1.Decay = 150
		dlight1.Size = 30
		dlight1.Noworld = false
		dlight1.Nomodel = false
		dlight1.DieTime = CurTime() + 1
		dlight1.dir = Vector(0,0,-90)
	end

	--local tmp2 = 255 - math.Clamp(self.amp*((self.dur-t)),0,255)
	--self.entity:SetColor(tmp2,tmp2,tmp2,tmp2)
	--self.entity:SetRenderMode(RENDERMODE_TRANSALPHA)
	--self.entity:SetMaterial("models/props_combine/stasisshield_sheet")
	self.entity:SetRenderFX(8)
	self.entity:SetSolid(1)
	if not (t < self.dur) then
		self.emitter:Finish()
		--self.entity:SetMaterial(nil)
	end
	return t < self.dur
end

function EFFECT:Render()
end
