
Class SinMedicine : SinPowerup{
	int healBiteWound; property HealBiteWound : healBiteWound;
	int healBurn; property HealBurn : healBurn;
	int healChemicalBurn; property HealChemicalBurn : healChemicalBurn;
	int healBleeding; property HealBleeding : healBleeding;
	int healBloodLoss; property HealBloodLoss : healBloodLoss;
	int healBluntTrauma; property HealBluntTrauma : healBluntTrauma;
	int healDeepTissueInjury; property HealDeepTissueInjury : healBiteWound;
	int healGunshotWound; property HealGunshotWound : healGunshotWound;
	int healInfection; property HealInfection : healInfection;
	int healInternalDamage; property HealInternalDamage : healInternalDamage;
	int healOrganDamage; property HealOrganDamage : healOrganDamage;
	int healLaceration; property HealLaceration : healLaceration;
	Default{
		Inventory.Amount 1;
		Inventory.MaxAmount 9999;
		SinItem.Stackable 1;
		SinItem.SpawnSaveDrives 0;
		SinMedicine.HealBiteWound 0;
		SinMedicine.HealBurn 0;
		SinMedicine.HealChemicalBurn 0;
		SinMedicine.HealBleeding 0;
		SinMedicine.HealBloodLoss 0;
		SinMedicine.HealBluntTrauma 0;
		SinMedicine.HealDeepTissueInjury 0;
		SinMedicine.HealGunshotWound 0;
		SinMedicine.HealInfection 0;
		SinMedicine.HealInternalDamage 0;
		SinMedicine.HealOrganDamage 0;
		SinMedicine.HealLaceration 0;
	}
	Override bool Use(bool pickup){
		If(owner){
			HealAffliction("BiteWound",healBiteWound);
			HealAffliction("Burn",healBurn);
			HealAffliction("ChemicalBurn",healChemicalBurn);
			//HealAffliction("Bleeding",healBleeding);
			owner.TakeInventory("Bleeding",healBleeding);
			HealAffliction("BloodLoss",healBloodLoss);
			HealAffliction("BluntTrauma",healBluntTrauma);
			HealAffliction("DeepTissueInjury",healDeepTissueInjury);
			HealAffliction("GunshotWound",healGunshotWound);
			HealAffliction("Infection",healInfection);
			HealAffliction("InternalDamage",healInternalDamage);
			HealAffliction("OrganDamage",healOrganDamage);
			HealAffliction("Laceration",healLaceration);
			owner.TakeInventory(self.GetClass(),1);
		}
		Return Super.Use(pickup);
	}
	Virtual void HealAffliction(string affliction, int healAmount){
		If(healAmount>0){
			let hasAffliction = owner.FindInventory(affliction);
			if (hasAffliction){
				int removedAmount = min(hasAffliction.amount,healAmount);
				owner.TakeInventory(affliction,removedAmount);
				owner.GiveBody(removedAmount);
				//	BUG: Inaccurate method of healing. Heals more HP than expected.
				/*
				int heal = min(hasAffliction.amount,healAmount);
				owner.GiveBody(heal);
				owner.TakeInventory(affliction,heal);
				*/
			}
		}
	}
	//	NOTE: Old override. Might keep it for future references.
	/*
	Override bool Use(bool pickup){
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
		If(hasBiteWound&&healBiteWound>0){owner.GiveBody(healBiteWound);owner.TakeInventory("BiteWound",healBiteWound);}
		If(hasBurn&&healBurn>0){owner.GiveBody(healBurn);owner.TakeInventory("Burn",healBurn);}
		If(hasChemicalBurn&&healChemicalBurn>0){owner.GiveBody(healChemicalBurn);owner.TakeInventory("ChemicalBurn",healChemicalBurn);}
		If(hasBleeding&&healBleeding>0){owner.TakeInventory("Bleeding",healBleeding);}
		If(hasBloodLoss&&healBloodLoss>0){owner.GiveBody(healBloodLoss);owner.TakeInventory("BloodLoss",healBloodLoss);}
		If(hasBluntTrauma&&healBluntTrauma>0){owner.GiveBody(healBluntTrauma);owner.TakeInventory("BluntTrauma",healBluntTrauma);}
		If(hasDeepTissueInjury&&healDeepTissueInjury>0){owner.GiveBody(healDeepTissueInjury);owner.TakeInventory("DeepTissueInjury",healDeepTissueInjury);}
		If(hasGunshotWound&&healGunshotWound>0){owner.GiveBody(healGunshotWound);owner.TakeInventory("GunshotWound",healGunshotWound);}
		If(hasInfection&&healInfection>0){owner.GiveBody(healInfection);owner.TakeInventory("Infection",healInfection);}
		If(hasInternalDamage&&healInternalDamage>0){owner.GiveBody(healInternalDamage);owner.TakeInventory("InternalDamage",healInternalDamage);}
		If(hasOrganDamage&&healOrganDamage>0){owner.GiveBody(healOrganDamage);owner.TakeInventory("OrganDamage",healOrganDamage);}
		If(hasLaceration&&healLaceration>0){owner.GiveBody(healLaceration);owner.TakeInventory("Laceration",healLaceration);}
		//owner.A_SetBlend("White",1,20);
		owner.TakeInventory(self.GetClass(),1);
		Return Super.Use(pickup);
	}
	*/
}
Class SinAnalgesic : PowerProtection{
	Default{
		Inventory.Amount 1;
		Inventory.MaxAmount 9999;
		Powerup.Duration 300;
		DamageFactor "Normal",0.90;
	}
	Override bool HandlePickup(Inventory item){
		If(item.GetClass() == self.GetClass()){self.amount += item.amount;}
		Return Super.HandlePickup(item);
	}
	//Override void PostBeginPlay(){amount = effectTics;}
	Override void DoEffect(){
		If(owner && self.effectTics == 1){
			effectTics = 300;
			self.amount--;
		}
	}
}
