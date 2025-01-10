
//	Thank you for the Player pointer, TonynUBares and Fishytza!
//	And a special thanks to Jacket for the AI-written Code. It was entertaining.
Class SinSurvivalMedical : EventHandler{
	Override void WorldThingDamaged(WorldEvent e){
		If(e.thing && e.thing.player && e.thing.health > 0 && cvar.GetCVar("sinsurvival_injury").getbool()){
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
			If(!isDamageType || isWearingArmor && !isBurn){e.thing.player.mo.GiveInventory("BluntTrauma",e.Damage);}
			If(isBluntTrauma){e.thing.player.mo.GiveInventory("BluntTrauma",e.Damage);}
			int bleedingAmount = (e.Damage / 4);
			If(isBiteWound && !isWearingArmor){
				e.thing.player.mo.GiveInventory("BiteWound",e.Damage);
				e.thing.player.mo.GiveInventory("Bleeding",bleedingAmount);
			}
			If(isLaceration && !isWearingArmor){
				e.thing.player.mo.GiveInventory("Laceration",e.Damage);
				e.thing.player.mo.GiveInventory("Bleeding",bleedingAmount);
			}
			If(isGunshotWound && !isWearingArmor){
				e.thing.player.mo.GiveInventory("GunshotWound",e.Damage);
				e.thing.player.mo.GiveInventory("Bleeding",bleedingAmount);
				//e.thing.player.mo.GiveInventory("ForeignBody",1);
			}
			int shrapnelAmount = (e.Damage / 10);
			If(isDeepTissueInjury && !isWearingArmor){
				e.thing.player.mo.GiveInventory("DeepTissueInjury",e.Damage);
				e.thing.player.mo.GiveInventory("Bleeding",bleedingAmount);
				//e.thing.player.mo.GiveInventory("ForeignBody",shrapnelAmount);
			}
			If(isBurn){e.thing.player.mo.GiveInventory("Burn",e.Damage);}
			If(isChemicalBurn){e.thing.player.mo.GiveInventory("ChemicalBurn",e.Damage);}
			If(isInfection){e.thing.player.mo.GiveInventory("Infection",e.Damage);}
			If(isInternalDamage){e.thing.player.mo.GiveInventory("InternalDamage",e.Damage);}
		}
	}
}
