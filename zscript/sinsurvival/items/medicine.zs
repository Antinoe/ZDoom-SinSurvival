
//	Base Healing Class
Class SinPowerHealing : Powerup abstract{
	enum SinRemedy{
		NONE = 0, //No remedy.
		ALL = 1, //Heals everything.
		BANDAGE = 2, //Heals everything except for Blood Loss, Infection and Internal/Organ Damage.
		ANTISEPTIC = 3, //Heals Infection.
		OINTMENT = 4, //Heals Burns and Infection.
		FLUID = 5, //Heals Blood Loss.
		VITAMIN = 6 //Heals Internal Damage and Organ Damage.
	}
	int remedy; property Remedy : remedy; //Type of injuries to heal, refer to SinRemedy.
	int effectTicsMax;
	Default{
		Inventory.Amount 1;
		Inventory.MaxAmount 50;
		Powerup.Duration 175;
		SinPowerHealing.Remedy NONE;
	}
	Override void PostBeginPlay(){
		effectTicsMax = effectTics;
	}
	Override bool HandlePickup(Inventory item){
		If(item.GetClass() == self.GetClass()){self.amount += item.amount;}
		Return Super.HandlePickup(item);
	}
	Override void DoEffect(){
		If(owner && self.effectTics == 1){
			effectTics = effectTicsMax;
			Heal();
		}
	}
	//	This is made virtual so you can execute your own code when healing.
	//	If you plan on having all this run, remember to add "Super.Heal();" to the end of your code.
	Virtual void Heal(){
		let hasBiteWound = owner.FindInventory("BiteWound");
		let hasBurn = owner.FindInventory("Burn");
		let hasChemicalBurn = owner.FindInventory("ChemicalBurn");
		let hasBleeding = owner.FindInventory("Bleeding");
		let hasBloodLoss = owner.FindInventory("BloodLoss");
		let hasBluntTrauma = owner.FindInventory("BluntTrauma");
		let hasDeepTissueInjury = owner.FindInventory("DeepTissueInjury");
		let hasGunshotWound = owner.FindInventory("GunshotWound");
		let hasInfection = owner.FindInventory("Infection");
		let hasInternalDamage = owner.FindInventory("InternalDamage");
		let hasOrganDamage = owner.FindInventory("OrganDamage");
		let hasLaceration = owner.FindInventory("Laceration");
		If(hasBiteWound&&(remedy==1||remedy==2)){owner.GiveBody(1); owner.TakeInventory("BiteWound",1);}
		If(hasBurn&&(remedy==1||remedy==2||remedy==4)){owner.GiveBody(1); owner.TakeInventory("Burn",1);}
		If(hasChemicalBurn&&(remedy==1||remedy==4)){owner.GiveBody(1); owner.TakeInventory("ChemicalBurn",1);}
		If(hasBleeding&&(remedy==1||remedy==2||remedy==2)){owner.TakeInventory("Bleeding",1);}
		If(hasBloodLoss&&(remedy==1||remedy==5)){owner.GiveBody(1); owner.TakeInventory("BloodLoss",1);}
		If(hasBluntTrauma&&(remedy==1||remedy==2)){owner.GiveBody(1); owner.TakeInventory("BluntTrauma",1);}
		If(hasDeepTissueInjury&&(remedy==1||remedy==2)){owner.GiveBody(1); owner.TakeInventory("DeepTissueInjury",1);}
		If(hasGunshotWound&&(remedy==1||remedy==2)){owner.GiveBody(1); owner.TakeInventory("GunshotWound",1);}
		If(hasInfection&&(remedy==1||remedy==3||remedy==4)){owner.GiveBody(1); owner.TakeInventory("Infection",1);}
		If(hasInternalDamage&&(remedy==1||remedy==6)){owner.GiveBody(1); owner.TakeInventory("InternalDamage",1);}
		If(hasOrganDamage&&(remedy==1||remedy==6)){owner.GiveBody(1); owner.TakeInventory("OrganDamage",1);}
		If(hasLaceration&&(remedy==1||remedy==2)){owner.GiveBody(1); owner.TakeInventory("Laceration",1);}
		//owner.A_SetBlend("White",1,20);
		owner.TakeInventory(self.GetClass(),1);
	}
}

//	Items
Class SinSurvivalStimpack : SinStimpack replaces SinStimpack{
	Default{Health 0;}
	Override bool Use(bool pickup){
		If(owner){
			let playe = SinPlayer(owner);
			If(playe&&playe.health<playe.maxhealth){
				owner.TakeInventory("Bleeding",10);
				owner.GiveInventory("SinPowerStimpack",10);
			}
		}
		Return Super.Use(pickup);
	}
}
Class SinPowerStimpack : SinPowerHealing{
	Default{
		Inventory.Icon "STIMA0";
		SinPowerHealing.Remedy ALL;
	}
}
Class SinSurvivalMedikit : SinMedikit replaces SinMedikit{
	Default{Health 0;}
	Override bool Use(bool pickup){
		If(owner){
			let playe = SinPlayer(owner);
			If(playe&&playe.health<playe.maxhealth){
				owner.TakeInventory("Bleeding",25);
				owner.GiveInventory("SinPowerMedikit",25);
			}
		}
		Return Super.Use(pickup);
	}
}
Class SinPowerMedikit : SinPowerHealing{
	Default{
		Inventory.Icon "MEDIA0";
		SinPowerHealing.Remedy ALL;
	}
}
Class SinSurvivalBerserk : SinBerserk replaces SinBerserk{
	Override bool Use(bool pickup){
		If(owner){
			let playe = SinPlayer(owner);
			If(playe&&playe.health<playe.maxhealth){
				owner.TakeInventory("BiteWound",100);
				owner.TakeInventory("Burn",100);
				owner.TakeInventory("ChemicalBurn",100);
				owner.TakeInventory("Bleeding",100);
				owner.TakeInventory("BloodLoss",100);
				owner.TakeInventory("BluntTrauma",100);
				owner.TakeInventory("DeepTissueInjury",100);
				owner.TakeInventory("GunshotWound",100);
				owner.TakeInventory("Infection",100);
				owner.TakeInventory("InternalDamage",100);
				owner.TakeInventory("Laceration",100);
				owner.GiveInventory("SinPowerBerserk",100);
			}
		}
		Return Super.Use(pickup);
	}
}
Class SinPowerBerserk : SinPowerHealing{
	Default{
		Inventory.Icon "PSTRA0";
		Powerup.Duration 35;
		SinPowerHealing.Remedy ALL;
	}
}
