
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
		Inventory.Amount 1;
		Inventory.MaxAmount 9999;
		Powerup.Duration 350;
	}
	Override bool HandlePickup(Inventory item){
		If(item.GetClass() == self.GetClass()){self.amount += item.amount;}
		Return Super.HandlePickup(item);
	}
	Override void DoEffect(){
		if(self.effectTics == 1){
			effectTics = 350;
			/*
			If(owner.health == 1){owner.A_DamageSelf(1);}
			Else{owner.A_SetHealth(owner.health -= 1);}
			*/
			If(owner.health > 1){
				owner.A_SetHealth(owner.health -= 1);
				owner.GiveInventory("BloodLoss",1);
				owner.TakeInventory("Bleeding",1);
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
Class Infection : Affliction{Default{Inventory.Icon "AFINA0";}}
Class Laceration : Affliction{Default{Inventory.Icon "AFLCA0";}}
Class InternalDamage : Affliction{Default{Inventory.Icon "AFIDA0";}}
