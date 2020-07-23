AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "37mm Flare"
ENT.Category = "M9K Ammunition"
ENT.Spawnable = true
ENT.AdminOnly = false

game.AddAmmoType({
	name = "rzmflaregun",
	dmgtype = DMG_BULLET
})

if SERVER then
	local VectorCache1 = Vector(0,0,10)

	function ENT:Initialize()
		self:SetModel("models/weapons/w_40mm_grenade_launched.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:PhysWake()
		self:SetUseType(SIMPLE_USE)

		timer.Simple(0,function()
			if not IsValid(self) then return end
			self:SetPos(self:GetPos() + VectorCache1)
			self:DropToFloor()
		end)
	end

	function ENT:PhysicsCollide(Data)
		if Data.Speed > 80 and Data.DeltaTime > 0.2 then
			self:EmitSound("Wood.ImpactHard")
		end
	end

	function ENT:Use(Activator)
		if Activator:IsPlayer() then
			Activator:GiveAmmo(1,"rzmflaregun")
			self:Remove()
		end
	end
end

if CLIENT then
	language.Add("rzmflaregun_ammo","Flaregun Ammo")

	function ENT:Draw()
		self:DrawModel()
	end
end