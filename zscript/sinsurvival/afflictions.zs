
Class Affliction : Powerup abstract{
	Default{
		Inventory.Icon "";
		Inventory.Amount 1;
		Inventory.MaxAmount 9999;
		+INVENTORY.UNDROPPABLE;
		+INVENTORY.UNTOSSABLE;
		Powerup.Duration 0x7FFFFFFF;
	}
	Override bool HandlePickup(Inventory item){
		If(item.GetClass() == self.GetClass()){self.amount += item.amount;}
		Return Super.HandlePickup(item);
	}
}
Class BiteWound : Affliction{Default{Inventory.Icon "AFBWA0";}}
Class Bleeding : Affliction{
	Default{
		Inventory.Icon "AFBLA0";
		Powerup.Duration 350;
	}
	Override void DoEffect(){
		if(self.effectTics == 1){
			effectTics = 350;
			/*
			If(owner.health == 1){owner.A_DamageSelf(1);}
			Else{owner.A_SetHealth(owner.health -= 1);}
			*/
			If(owner.health > 1){
				If(!Random(0,3)){owner.GiveInventory("Infection",1); owner.A_SetHealth(owner.health -= 1);}
				owner.A_SetHealth(owner.health -= 1);
				owner.GiveInventory("BloodLoss",1);
				owner.TakeInventory(self.GetClass(),1);
			}
		}
	}
}
Class BloodLoss : Affliction{Default{Inventory.Icon "AFBLB0";}}
Class Burn : Affliction{Default{Inventory.Icon "AFBNA0";}}
Class ChemicalBurn : Affliction{Default{Inventory.Icon "AFBNB0";}}
Class BluntTrauma : Affliction{Default{Inventory.Icon "AFBTA0";}}
Class DeepTissueInjury : Affliction{Default{Inventory.Icon "AFEXA0";}}
Class GunshotWound : Affliction{Default{Inventory.Icon "AFGWA0";}}
Class Infection : Affliction{
	Default{
		Inventory.Icon "AFINA0";
		Powerup.Duration 1050;
	}
	Override void DoEffect(){
		if(self.effectTics == 1){
			If(owner.health > 1){
				owner.A_SetHealth(owner.health -= 1);
				owner.GiveInventory(self.GetClass(),1);
			}
		}
	}
}
Class Laceration : Affliction{Default{Inventory.Icon "AFLCA0";}}
Class InternalDamage : Affliction{Default{Inventory.Icon "AFIDA0";}}
Class OrganDamage : Affliction{Default{Inventory.Icon "AFODA0";}}
Class Stitches : Affliction{
	Default{
		Inventory.Icon "AFSTA0";
		Inventory.Amount 1;
		Inventory.MaxAmount 50;
		Powerup.Duration 175;
	}
	Override void DoEffect(){
		if(self.effectTics == 1){
			effectTics = 175;
			//owner.A_SetBlend("White",1,20);
			owner.GiveBody(1);
			owner.TakeInventory(self.GetClass(),1);
		}
	}
}
