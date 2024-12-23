
//	Thank you for the Player pointer, TonynUBares and Fishytza!
//	And a special thanks to Jacket for the AI-written Code. It was entertaining.
Class SinSurvivalMedical : EventHandler{
	Override void WorldThingDamaged(WorldEvent e){
		if(e.thing && e.thing.player && e.thing.health > 0){
			//e.thing.player.mo.A_Log("DAMAGED!",5);
			bool isBiteWound = (e.DamageType == "Bite" || e.DamageType == "Jaw" || e.DamageType == "Teeth");
			bool isBluntTrauma = (e.DamageType == "Blunt" || e.DamageType == "Impact" || e.DamageType == "Stomp" || e.DamageType == "Bat" || e.DamageType == "Club");
			bool isLaceration = (e.DamageType == "Cut" || e.DamageType == "Slash" || e.DamageType == "Claw" || e.DamageType == "ImpClaw" || e.DamageType == "Rip" || e.DamageType == "Tear" || e.DamageType == "Melee" || e.DamageType == "Nailgun");
			bool isDeepTissueInjury = (e.DamageType == "Poke" || e.DamageType == "Stab" || e.DamageType == "Pierce" || e.DamageType == "Puncture" || e.DamageType == "Impale" || e.DamageType == "Explosive" || e.DamageType == "ExplosiveImpact" || e.DamageType == "Rocket" || e.DamageType == "Grenade" || e.DamageType == "Fragmentation");
			bool isBurn = (e.DamageType == "Burn" || e.DamageType == "Fire" || e.DamageType == "Heat" || e.DamageType == "Hot" || e.DamageType == "Electric" || e.DamageType == "Lightning" || e.DamageType == "Plasma");
			bool isChemicalBurn = (e.DamageType == "Acid" || e.DamageType == "Ice" || e.DamageType == "Freeze" || e.DamageType == "Cold");
			bool isGunshotWound = (e.DamageType == "Bullet" || e.DamageType == "Gun" || e.DamageType == "Pistol" || e.DamageType == "Revolver" || e.DamageType == "SMG" || e.DamageType == "Shotgun" || e.DamageType == "Rifle" || e.DamageType == "Minigun" || e.DamageType == "Chaingun" || e.DamageType == "MonsterBullet" || e.DamageType == "MonsterShotgunBullet" || e.DamageType == "MonsterMinigun" || e.DamageType == "Autocannon" || e.DamageType == "SmallRifleBullet");
			bool isInfection = (e.DamageType == "Poison" || e.DamageType == "Venom");
			bool isInternalDamage = (e.DamageType == "Soul" || e.DamageType == "Void" || e.DamageType == "PM_BulletHellDamage");
			//bool isOrganDamage = ();
			bool isDamageType = (isBiteWound || isBluntTrauma || isLaceration || isGunshotWound || isDeepTissueInjury || isBurn || isChemicalBurn || isInfection || isInternalDamage);
			//let armor = BasicArmor(players[e.PlayerNumber].mo.FindInventory("BasicArmor"));
			bool isWearingArmor = e.thing.player.mo.CountInv("BasicArmor") > 0;
			if(!isDamageType || isWearingArmor && !isBurn){e.thing.player.mo.GiveInventory("BluntTrauma",e.Damage);}
			if(isBluntTrauma){e.thing.player.mo.GiveInventory("BluntTrauma",e.Damage);}
			int bleedingAmount = (e.Damage / 4);
			if(isBiteWound && !isWearingArmor){
				e.thing.player.mo.GiveInventory("BiteWound",e.Damage);
				e.thing.player.mo.GiveInventory("Bleeding",bleedingAmount);
			}
			if(isLaceration && !isWearingArmor){
				e.thing.player.mo.GiveInventory("Laceration",e.Damage);
				e.thing.player.mo.GiveInventory("Bleeding",bleedingAmount);
			}
			if(isGunshotWound && !isWearingArmor){
				e.thing.player.mo.GiveInventory("GunshotWound",e.Damage);
				e.thing.player.mo.GiveInventory("Bleeding",bleedingAmount);
				//e.thing.player.mo.GiveInventory("ForeignBody",1);
			}
			int shrapnelAmount = (e.Damage / 10);
			if(isDeepTissueInjury && !isWearingArmor){
				e.thing.player.mo.GiveInventory("DeepTissueInjury",e.Damage);
				e.thing.player.mo.GiveInventory("Bleeding",bleedingAmount);
				//e.thing.player.mo.GiveInventory("ForeignBody",shrapnelAmount);
			}
			if(isBurn){e.thing.player.mo.GiveInventory("Burn",e.Damage);}
			if(isChemicalBurn){e.thing.player.mo.GiveInventory("ChemicalBurn",e.Damage);}
			if(isInfection){e.thing.player.mo.GiveInventory("Infection",e.Damage);}
			if(isInternalDamage){e.thing.player.mo.GiveInventory("InternalDamage",e.Damage);}
		}
	}
	Override void CheckReplacement(ReplaceEvent e){
		if(e.Replacee is "SinPotionGreen"){if(cvar.GetCVar('sinsurvival_medical_replacements').getbool())e.Replacement="SinBandage";}
		if(e.Replacee is "SinPotionRed"){if(cvar.GetCVar('sinsurvival_medical_replacements').getbool())e.Replacement="SinSuture";}
		if(e.Replacee is "SinStimpack"){if(cvar.GetCVar('sinsurvival_medical_replacements').getbool())e.Replacement="SinOintment";}
		if(e.Replacee is "SinMedikit"){if(cvar.GetCVar('sinsurvival_medical_replacements').getbool())e.Replacement="SinSaline";}
	}
}
