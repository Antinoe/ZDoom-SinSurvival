
//	Thank you for the Player pointer, TonynUBares and Fishytza!
//	And a special thanks to Jacket for the AI-written Code. It was entertaining.
Class SinSurvivalInjury : EventHandler{
	Override void WorldThingDamaged(WorldEvent e){
		if(e.thing && e.thing.player && e.thing.health > 0){
			e.thing.player.mo.A_Log("DAMAGED!",5);
			//	DAMAGE TYPES
			//
			bool isBluntForceTrauma = (e.DamageType == "Blunt" || e.DamageType == "Impact");
			bool isLaceration = (e.DamageType == "Cut" || e.DamageType == "Slash" || e.DamageType == "Claw" || e.DamageType == "ImpClaw" || e.DamageType == "Rip" || e.DamageType == "Tear");
			bool isDeepTissueInjury = (e.DamageType == "Poke" || e.DamageType == "Stab" || e.DamageType == "Pierce" || e.DamageType == "Puncture" || e.DamageType == "Explosive" || e.DamageType == "ExplosiveImpact" || e.DamageType == "Rocket" || e.DamageType == "Grenade" || e.DamageType == "Fragmentation");
			bool isBurn = (e.DamageType == "Burn" || e.DamageType == "Fire" || e.DamageType == "Heat" || e.DamageType == "Hot");
			bool isGunshotWound = (e.DamageType == "Gun" || e.DamageType == "Pistol" || e.DamageType == "Revolver" || e.DamageType == "SMG" || e.DamageType == "Shotgun" || e.DamageType == "Rifle" || e.DamageType == "Minigun" || e.DamageType == "Chaingun" || e.DamageType == "MonsterBullet" || e.DamageType == "MonsterShotgunBullet" || e.DamageType == "MonsterMinigun");
			bool isDamageType = (isBluntForceTrauma || isLaceration || isDeepTissueInjury || isBurn || isGunshotWound);
			//
			//let armor = BasicArmor(players[e.PlayerNumber].mo.FindInventory("BasicArmor"));
			bool isWearingArmor = e.thing.player.mo.CountInv("BasicArmor") > 0;
			if(!isDamageType || isWearingArmor && !isBurn){e.thing.player.mo.GiveInventory("InjuryBluntForceTrauma",e.Damage);}
			if(isBluntForceTrauma){e.thing.player.mo.GiveInventory("InjuryBluntForceTrauma",e.Damage);}
			if(isLaceration && !isWearingArmor){
				e.thing.player.mo.GiveInventory("InjuryLaceration",e.Damage);
				e.thing.player.mo.GiveInventory("InjuryBleeding",e.Damage);
			}
			if(isGunshotWound && !isWearingArmor){
				e.thing.player.mo.GiveInventory("InjuryGunshotWound",e.Damage);
				e.thing.player.mo.GiveInventory("InjuryBleeding",e.Damage);
				e.thing.player.mo.GiveInventory("InjuryForeignBody",1);
			}
			if(isBurn){e.thing.player.mo.GiveInventory("InjuryBurn",e.Damage);}
			if(isDeepTissueInjury && !isWearingArmor){
				e.thing.player.mo.GiveInventory("InjuryDeepTissueInjury",e.Damage);
				e.thing.player.mo.GiveInventory("InjuryBleeding",e.Damage / 2);
				//	Receive only a quarter of shrapnel, relative to the damage, from explosions.
				e.thing.player.mo.GiveInventory("InjuryForeignBody",e.Damage / 4);
			}
		}
	}
	Override void WorldThingDied(WorldEvent e){
		if(e.thing && e.thing.player){
			e.thing.player.mo.TakeInventory("InjuryBluntForceTrauma",9999);
			e.thing.player.mo.TakeInventory("InjuryLaceration",9999);
			e.thing.player.mo.TakeInventory("InjuryBleeding",9999);
			e.thing.player.mo.TakeInventory("InjuryGunshotWound",9999);
			e.thing.player.mo.TakeInventory("InjurySepsis",9999);
			e.thing.player.mo.TakeInventory("InjuryDeepTissueInjury",9999);
			e.thing.player.mo.TakeInventory("InjuryBurn",9999);
		}
	}
	Override void CheckReplacement(ReplaceEvent e){
		if(e.Replacee is "SinPotionGreen"){if(cvar.GetCVar('sinsurvival_medical_replacements').getbool())e.Replacement="SinSurvivalPotionSpawner";}
		if(e.Replacee is "SinPotionRed"){if(cvar.GetCVar('sinsurvival_medical_replacements').getbool())e.Replacement="SinSurvivalPotionSpawner";}
		if(e.Replacee is "SinStimpack"){if(cvar.GetCVar('sinsurvival_medical_replacements').getbool())e.Replacement="SinSurvivalStimpack";}
		if(e.Replacee is "SinMedikit"){if(cvar.GetCVar('sinsurvival_medical_replacements').getbool())e.Replacement="SinSurvivalMedikit";}
	}
}
