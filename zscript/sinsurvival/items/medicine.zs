
Class SinBandage : SinPowerup{
	Default{
		Scale 1.0;
		Tag "Bandage";
		Inventory.Icon "BNDGA0";
		Inventory.Amount 2;
		Inventory.MaxAmount 10;
		SinItem.Description "A versatile medical dressing designed to stop \c[green]bleeding\c[grey]. It promotes the healing of \c[green]blunt trauma\c[grey], \c[green]burns\c[grey], and \c[green]wounds\c[grey] by protecting the affected area and providing a stable environment for recovery.";
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
Class SinOintment : SinPowerup{
	Default{
		Scale 0.75;
		Tag "Burn Ointment";
		Inventory.Icon "OINTA0";
		Inventory.Amount 4;
		Inventory.MaxAmount 10;
		SinItem.Description "A soothing topical treatment formulated to relieve pain and reduce inflammation caused by \c[green]burns\c[grey]. It aids in healing by keeping the affected area moisturized and protected from \c[green]infection\c[grey], promoting faster skin recovery.";
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
Class SinSaline : SinPowerup{
	Default{
		Scale 0.75;
		Tag "Ringer's Solution";
		Inventory.Icon "SALNA0";
		Inventory.Amount 2;
		Inventory.MaxAmount 10;
		SinItem.Description "A sterile intravenous fluid containing salts and electrolytes, designed to mimic the composition of body fluids. It is used to restore hydration, maintain electrolyte balance, and support \c[green]circulation\c[grey] during medical treatments or emergencies.";
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
Class SinSuture : SinPowerup{
	Default{
		Scale 0.75;
		Tag "Suture";
		Inventory.Icon "BNDGA0";
		Inventory.Amount 4;
		Inventory.MaxAmount 20;
		SinItem.Description "Medical threads used to stitch and close \c[green]wounds\c[grey], aiding in proper \c[green]healing\c[grey] and reducing the risk of \c[green]infection\c[grey]. They are essential for repairing \c[green]deep cuts\c[grey] or \c[blue]surgical incisions\c[grey], ensuring the skin or tissue remains aligned during recovery.";
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
			if(hasBiteWound){owner.GiveBody(5); owner.TakeInventory("BiteWound",5); owner.GiveInventory("Stitches",5);}
			if(hasBleeding){owner.TakeInventory("Bleeding",5);}
			if(hasDeepTissueInjury){owner.GiveBody(5); owner.TakeInventory("DeepTissueInjury",5); owner.GiveInventory("Stitches",5);}
			if(hasGunshotWound){owner.GiveBody(5); owner.TakeInventory("GunshotWound",5); owner.GiveInventory("Stitches",5);}
			if(hasLaceration){owner.GiveBody(5); owner.TakeInventory("Laceration",5); owner.GiveInventory("Stitches",5);}
			owner.A_StartSound("SinSurvival/Syringe",CHAN_AUTO,CHANF_OVERLAP);
			owner.A_SetBlend("White",1,20);
		}
		Return Super.Use(pickup);
	}
}
