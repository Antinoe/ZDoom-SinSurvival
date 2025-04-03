
Class SinSurvivalInjury : EventHandler{
	Override void WorldThingDamaged(WorldEvent e){
		If(e.damage>0&&e.thing&&e.thing.health>0&&e.thing.player&&e.thing.player.mo){
			let playe = e.thing.player.mo;
			bool isBiteWound=(e.DamageType=="Bite"||e.DamageType=="Jaw"||e.DamageType=="Teeth");
			bool isBluntTrauma=(e.DamageType=="Blunt"||e.DamageType=="Impact"||e.DamageType=="Stomp"||e.DamageType=="Bat"||e.DamageType=="Club"||e.DamageType=="Strike");
			bool isLaceration=(e.DamageType=="Cut"||e.DamageType=="Slash"||e.DamageType=="Claw"||e.DamageType=="ImpClaw"||e.DamageType=="Rip"||e.DamageType=="Tear"||e.DamageType=="Melee"||e.DamageType=="Nailgun");
			bool isDeepTissueInjury=(e.DamageType=="Poke"||e.DamageType=="Stab"||e.DamageType=="Pierce"||e.DamageType=="Puncture"||e.DamageType=="Impale"||e.DamageType=="Explosive"||e.DamageType=="ExplosiveImpact"||e.DamageType=="Rocket"||e.DamageType=="Grenade"||e.DamageType=="Fragmentation");
			bool isBurn=(e.DamageType=="Burn"||e.DamageType=="Fire"||e.DamageType=="Heat"||e.DamageType=="Hot"||e.DamageType=="Electric"||e.DamageType=="Lightning"||e.DamageType=="Plasma");
			bool isChemicalBurn=(e.DamageType=="Acid"||e.DamageType=="Ice"||e.DamageType=="Freeze"||e.DamageType=="Cold");
			bool isGunshotWound=(e.DamageType=="Bullet"||e.DamageType=="Gun"||e.DamageType=="Pistol"||e.DamageType=="Revolver"||e.DamageType=="SMG"||e.DamageType=="Shotgun"||e.DamageType=="Rifle"||e.DamageType=="Minigun"||e.DamageType=="Chaingun"||e.DamageType=="MonsterBullet"||e.DamageType=="MonsterShotgunBullet"||e.DamageType=="MonsterMinigun"||e.DamageType=="Autocannon"||e.DamageType=="SmallRifleBullet");
			bool isInfection=(e.DamageType=="Poison"||e.DamageType=="Venom");
			bool isInternalDamage=(e.DamageType=="Soul"||e.DamageType=="Void"||e.DamageType=="PM_BulletHellDamage");
			//bool isOrganDamage=();
			bool isDamageType=(isBiteWound||isBluntTrauma||isLaceration||isGunshotWound||isDeepTissueInjury||isBurn||isChemicalBurn||isInfection||isInternalDamage);
			//let armor = BasicArmor(players[e.PlayerNumber].mo.FindInventory("BasicArmor"));
			bool isWearingArmor = playe.CountInv("BasicArmor")>0;
			If(!isDamageType || isWearingArmor && !isBurn){playe.GiveInventory("BluntTrauma",e.Damage);}
			If(isBluntTrauma){playe.GiveInventory("BluntTrauma",e.Damage);}
			int bleedingAmount=(e.Damage / 4);
			If(isBiteWound&&!isWearingArmor){
				playe.GiveInventory("BiteWound",e.Damage);
				playe.GiveInventory("Bleeding",bleedingAmount);
			}
			If(isLaceration&&!isWearingArmor){
				playe.GiveInventory("Laceration",e.Damage);
				playe.GiveInventory("Bleeding",bleedingAmount);
			}
			If(isGunshotWound&&!isWearingArmor){
				playe.GiveInventory("GunshotWound",e.Damage);
				playe.GiveInventory("Bleeding",bleedingAmount);
				//playe.GiveInventory("ForeignBody",1);
			}
			int shrapnelAmount=(e.Damage / 10);
			If(isDeepTissueInjury&&!isWearingArmor){
				playe.GiveInventory("DeepTissueInjury",e.Damage);
				playe.GiveInventory("Bleeding",bleedingAmount);
				//playe.GiveInventory("ForeignBody",shrapnelAmount);
			}
			If(isBurn){playe.GiveInventory("Burn",e.Damage);}
			If(isChemicalBurn){playe.GiveInventory("ChemicalBurn",e.Damage);}
			If(isInfection){playe.GiveInventory("Infection",e.Damage);}
			If(isInternalDamage){playe.GiveInventory("InternalDamage",e.Damage);}
		}
	}
}
