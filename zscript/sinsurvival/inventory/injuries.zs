
/*
Class TEST : Powerup{
	Default{
		Inventory.Icon "MEDIA0";
		Inventory.Amount 1;
		Inventory.MaxAmount 9999;
		Powerup.Duration -9999;
	}
	Override bool HandlePickup(Inventory item){
		if(item.GetClass() == self.GetClass()){self.amount += item.amount;}
		return super.HandlePickup(item);
	}
}
*/

Class Injury : Powerup{
	int timer;
	Default{
		Inventory.Icon "";
		Inventory.Amount 1;
		Inventory.MaxAmount 9999;
		+INVENTORY.UNDROPPABLE;
		+INVENTORY.UNTOSSABLE;
		Powerup.Duration 0x7FFFFFFF;
	}
	Override bool HandlePickup(Inventory item){
		if(item.GetClass() == self.GetClass()){self.amount += item.amount;}
		return super.HandlePickup(item);
	}
	Override void AttachToOwner(Actor other){
		timer = 350;
		super.AttachToOwner(other);
	}
	Override void Tick(){
		timer--;
		if(timer <= 0){
			timer = 350;
			InjuryTimerTick();
		}
		super.Tick();
	}
	Virtual void InjuryTimerTick(){}
	Override void DetachFromOwner(){
		timer = 0;
		super.DetachFromOwner();
	}
	/*
	Override bool TryPickup(in out Actor toucher){return super.TryPickup(toucher);}
	Override bool HandlePickup(Inventory item){return super.HandlePickup(item);}
	Override void AttachToOwner(Actor other){}
	Override void Tick(){}
	Override void DetachFromOwner(){}
	Override void InitEffect(){}
	Override void DoEffect(){}
	Override void EndEffect(){}
	*/
}

Class InjuryBluntForceTrauma : Injury{
	Default{Inventory.Icon "SMITA0";}
	Override void InjuryTimerTick(){
		owner.GiveBody(1);
		owner.TakeInventory("InjuryBluntForceTrauma",1);
		super.InjuryTimerTick();
	}
}
Class InjuryLaceration : Injury{
	Default{Inventory.Icon "CSAWA0";}
	Override void InjuryTimerTick(){
		owner.GiveBody(1);
		owner.TakeInventory("InjuryLaceration",1);
		super.InjuryTimerTick();
	}
}
Class InjuryBleeding : Injury{
	Default{Inventory.Icon "BLUDA0";}
	Override void InjuryTimerTick(){
		if(owner.health == 1){owner.A_DamageSelf(1);}
		else{owner.A_SetHealth(owner.health -= 1);}
		owner.TakeInventory("InjuryBleeding",1);
		//super.InjuryTimerTick();
	}
}
Class InjuryBurn : Injury{
	Default{Inventory.Icon "FIREA0";}
	Override void InjuryTimerTick(){
		owner.GiveBody(1);
		owner.TakeInventory("InjuryBurn",1);
		super.InjuryTimerTick();
	}
}
Class InjuryDeepTissueInjury : Injury{
	Default{Inventory.Icon "FBXPA0";}
	Override void InjuryTimerTick(){
		owner.GiveBody(1);
		owner.TakeInventory("InjuryDeepTissueInjury",1);
		super.InjuryTimerTick();
	}
}
Class InjuryGunshotWound : Injury{
	Default{Inventory.Icon "BLUDC0";}
	Override void InjuryTimerTick(){
		owner.GiveBody(1);
		owner.TakeInventory("InjuryGunshotWound",1);
		super.InjuryTimerTick();
	}
}
Class InjuryForeignBody : Injury{Default{Inventory.Icon "ROCKA0";}}
Class InjurySepsis : Injury{Default{Inventory.Icon "BAL7Z0";}}
