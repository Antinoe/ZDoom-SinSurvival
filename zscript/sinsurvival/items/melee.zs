
Class SinMelee : SinWeapon{
	bool swing; property Swing : swing;
	int quakeIntensity; property QuakeIntensity : quakeIntensity;
	int quakeDuration; property QuakeDuration : quakeDuration;
	int staminaCost; property StaminaCost : staminaCost;
	int strengthScaling; property StrengthScaling : strengthScaling;
	int dexterityScaling; property DexterityScaling : dexterityScaling;
	Default{
		Damage 0;
		Damagetype "Strike";
		AttackSound "weapons/punch";
		Inventory.Amount 50;
		Inventory.MaxAmount 50;
		SinWeapon.FireType FIRE_AUTO;
		SinWeapon.AttackType ATTACK_HITSCAN;
		SinWeapon.HitscanFlags FBF_NORANDOM|FBF_EXPLICITANGLE;
		SinWeapon.HitscanDamage 25;
		SinWeapon.HitscanRange 100;
		SinWeapon.FireMode1 3,10;
		SinWeapon.Recoil -1;
		SinWeapon.AmmoCost 1;
		SinWeapon.DrySound "";
		SinItem.RemoveWhenEmpty 1;
		SinMelee.Swing 0;
		SinMelee.QuakeIntensity 1;
		SinMelee.QuakeDuration 5;
	}
	Override void PostBeginPlay(){
		//If(damage>0){scandmg=damage;}
		If(swing){
			spreadx=-12;
		}
	}
	Override bool WeaponPreFire(SinPlayer shooter, SinHands gun){
		If(shooter.stamin>0&&amount>0){
			int strength = shooter.CountInv("SinStrength");
			int dexterity = shooter.CountInv("SinDexterity");
			int newDamage = (scandmg+strength+dexterity);
			shooter.stamin-=staminaCost;
			scandmg=newDamage;
			Return 1;
		}
		Return 0;
		//Return Super.WeaponPreFire(shooter,gun);
	}
	Override void WeaponFire(SinPlayer shooter, SinHands gun){
		If(quakeIntensity>0){
			shooter.A_Quake(quakeIntensity,quakeDuration,0,100,0);
		}
		Super.WeaponFire(shooter,gun);
	}
	Override void WeaponPostFire(SinPlayer shooter, SinHands gun){
		If(swing){
			spreadx+=6;
		}
	}
	Override bool WeaponReFire(SinPlayer shooter, SinHands gun){
		If(swing){
			If(spreadx<=12){Return 1;}
			spreadx=-12;
			Return 0;
		}
		Return Super.WeaponReFire(shooter,gun);
	}
}

//	Old Projectile-based Melee System. Keep it here as reference when designing other classes.
/*
Class SinMeleeProjectile : FastProjectile{
	Default{
		Radius 10;
		Height 10;
		Speed 20;
		Damage 0;
		DamageType "Strike";
		-RIPPER;
		+STRIFEDAMAGE;
		//+NOEXPLODEFLOOR;
		//+THRUGHOST;
	}
	States{
		Spawn:
			//SWEP ABCDEFGH 1;
			SWEP BDG 1;
			Stop;
		Death:
			SWEP ABCDEFGH 1;
			Stop;
	}
}
Class SinMelee : SinWeapon abstract{
	int staminaCost; property StaminaCost : staminaCost;
	Default{
		SinItem.Stackable 0;
		SinItem.RemoveWhenEmpty 1;
		SinWeapon.AmmoCost 1;
		SinWeapon.FireType FIRE_AUTO;
		SinWeapon.AttackType ATTACK_PROJECTILE;
		SinWeapon.Projectile "";
		SinWeapon.Noise 256;
		SinWeapon.Recoil -1;
		SinWeapon.FireMode1 2,10;
		SinWeapon.DrySound "";
		AttackSound "";
		Damage 0;
		DamageType "Strike";
	}
	Override void HandleSprite(int status){cursprite=spawnstate.sprite;}
	Override bool WeaponPreFire(SinPlayer shooter, SinHands gun){
		shooter.A_Log("Stamina: "..shooter.stamin);
		If(shooter.stamin>0){
			shooter.stamin-=staminaCost;
			Return 1;
		}
		Else{Return 0;}
		Return Super.WeaponPreFire(shooter,gun);
	}
	Override void WeaponFire(SinPlayer shooter, SinHands gun){
		let meleeProj = SinMeleeProjectile(shooter.SpawnPlayerMissile("SinMeleeProjectile"));
		If(meleeProj){
			meleeProj.SetDamage(damage);
			meleeProj.A_SetDamageType(damagetype);
			//shooter.A_Log("Damage of Melee Weapon is " .. meleeProj.damage);
			shooter.A_Quake(1,5,0,100,0);
		}
	}
}
*/