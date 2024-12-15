
Class Bandage : SinPowerup{
	Default{
		Scale 1.0;
		Tag "Bandage";
		Inventory.Icon "BNDGA0";
		Inventory.Amount 2;
		Inventory.MaxAmount 10;
		SinItem.Stackable 1;
		SinItem.SpawnSaveDrives 0;
	}
	States{Spawn: BNDG A -1; Stop;}
	Override bool Use(bool pickup){
		If(owner){
			owner.TakeInventory("Bleeding",10);
			owner.GiveInventory("PowerBandage",10);
			owner.A_StartSound("SinSurvival/Bandage",CHAN_AUTO,CHANF_OVERLAP);
		}
		Return Super.Use(pickup);
	}
}
Class PowerBandage : Powerup{
	Default{
		Inventory.Icon "BNDGA0";
		Inventory.Amount 1;
		Inventory.MaxAmount 50;
		Powerup.Duration 350;
	}
	Override bool HandlePickup(Inventory item){
		If(item.GetClass() == self.GetClass()){self.amount += item.amount;}
		Return Super.HandlePickup(item);
	}
	Override void DoEffect(){
		if(self.effectTics == 1){
			let hasBiteWound = owner.FindInventory("BiteWound");
			let hasBurn = owner.FindInventory("Burn");
			let hasChemicalBurn = owner.FindInventory("ChemicalBurn");
			let hasBleeding = owner.FindInventory("Bleeding");
			let hasBluntTrauma = owner.FindInventory("BluntTrauma");
			let hasDeepTissueInjury = owner.FindInventory("DeepTissueInjury");
			let hasGunshotWound = owner.FindInventory("GunshotWound");
			let hasLaceration = owner.FindInventory("Laceration");
			if(hasBiteWound){owner.GiveBody(1); owner.TakeInventory("BiteWound",1);}
			if(hasBurn){owner.GiveBody(1); owner.TakeInventory("Burn",1);}
			if(hasChemicalBurn){owner.GiveBody(1); owner.TakeInventory("ChemicalBurn",1);}
			if(hasBleeding){owner.TakeInventory("Bleeding",1);}
			if(hasBluntTrauma){owner.GiveBody(1); owner.TakeInventory("BluntTrauma",1);}
			if(hasDeepTissueInjury){owner.GiveBody(1); owner.TakeInventory("DeepTissueInjury",1);}
			if(hasGunshotWound){owner.GiveBody(1); owner.TakeInventory("GunshotWound",1);}
			if(hasLaceration){owner.GiveBody(1); owner.TakeInventory("Laceration",1);}
			owner.A_SetBlend("White",1,20);
			effectTics = 350;
			owner.TakeInventory("PowerBandage",1);
		}
	}
}
Class Ointment : SinPowerup{
	Default{
		Scale 0.75;
		Tag "Burn Ointment";
		Inventory.Icon "OINTA0";
		Inventory.Amount 4;
		Inventory.MaxAmount 10;
		SinItem.Stackable 1;
		SinItem.SpawnSaveDrives 0;
	}
	States{Spawn: OINT A -1; Stop;}
	Override bool Use(bool pickup){
		If(owner){
			owner.GiveInventory("PowerOintment",10);
			owner.A_StartSound("SinSurvival/Syringe",CHAN_AUTO,CHANF_OVERLAP);
		}
		Return Super.Use(pickup);
	}
}
Class PowerOintment : Powerup{
	Default{
		Inventory.Icon "OINTA0";
		Inventory.Amount 1;
		Inventory.MaxAmount 50;
		Powerup.Duration 175;
	}
	Override bool HandlePickup(Inventory item){
		If(item.GetClass() == self.GetClass()){self.amount += item.amount;}
		Return Super.HandlePickup(item);
	}
	Override void DoEffect(){
		if(self.effectTics == 1){
			let hasBurn = owner.FindInventory("Burn");
			let hasChemicalBurn = owner.FindInventory("ChemicalBurn");
			let hasInfection = owner.FindInventory("Infection");
			if(hasBurn){owner.GiveBody(1); owner.TakeInventory("Burn",1);}
			if(hasChemicalBurn){owner.GiveBody(1); owner.TakeInventory("ChemicalBurn",1);}
			if(hasInfection){owner.GiveBody(1); owner.TakeInventory("Infection",1);}
			owner.A_SetBlend("White",1,20);
			effectTics = 175;
			owner.TakeInventory("PowerOintment",1);
		}
	}
}
Class Saline : SinPowerup{
	Default{
		Scale 0.75;
		Tag "Saline";
		Inventory.Icon "SALNA0";
		Inventory.Amount 2;
		Inventory.MaxAmount 10;
		SinItem.Stackable 1;
		SinItem.SpawnSaveDrives 0;
	}
	States{Spawn: SALN A -1; Stop;}
	Override bool Use(bool pickup){
		If(owner){
			owner.GiveInventory("PowerSaline",10);
			owner.A_StartSound("SinSurvival/Syringe",CHAN_AUTO,CHANF_OVERLAP);
		}
		Return Super.Use(pickup);
	}
}
Class PowerSaline : Powerup{
	Default{
		Inventory.Icon "SALNA0";
		Inventory.Amount 1;
		Inventory.MaxAmount 50;
		Powerup.Duration 175;
	}
	Override bool HandlePickup(Inventory item){
		If(item.GetClass() == self.GetClass()){self.amount += item.amount;}
		Return Super.HandlePickup(item);
	}
	Override void DoEffect(){
		if(self.effectTics == 1){
			let hasBloodLoss = owner.FindInventory("BloodLoss");
			if(hasBloodLoss){owner.GiveBody(1); owner.TakeInventory("BloodLoss",1);}
			owner.A_SetBlend("White",1,20);
			effectTics = 175;
			owner.TakeInventory("PowerSaline",1);
		}
	}
}
Class Suture : SinPowerup{
	Default{
		Scale 0.75;
		Tag "Suture";
		Inventory.Icon "BNDGA0";
		Inventory.Amount 4;
		Inventory.MaxAmount 20;
		SinItem.Stackable 1;
		SinItem.SpawnSaveDrives 0;
	}
	States{Spawn: BNDG A -1; Stop;}
	Override bool Use(bool pickup){
		If(owner){
			let hasBiteWound = owner.FindInventory("BiteWound");
			let hasBleeding = owner.FindInventory("Bleeding");
			let hasDeepTissueInjury = owner.FindInventory("DeepTissueInjury");
			let hasGunshotWound = owner.FindInventory("GunshotWound");
			let hasLaceration = owner.FindInventory("Laceration");
			if(hasBiteWound){owner.GiveBody(10); owner.TakeInventory("BiteWound",10);}
			if(hasBleeding){owner.TakeInventory("Bleeding",10);}
			if(hasDeepTissueInjury){owner.GiveBody(10); owner.TakeInventory("DeepTissueInjury",10);}
			if(hasGunshotWound){owner.GiveBody(10); owner.TakeInventory("GunshotWound",10);}
			if(hasLaceration){owner.GiveBody(10); owner.TakeInventory("Laceration",10);}
			owner.A_StartSound("SinSurvival/Syringe",CHAN_AUTO,CHANF_OVERLAP);
			owner.A_SetBlend("White",1,20);
		}
		Return Super.Use(pickup);
	}
}
