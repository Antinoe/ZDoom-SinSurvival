
/*
Class TEST : Powerup{
	Default{
		Inventory.Icon "MEDIA0";
		Inventory.Amount 1;
		Inventory.MaxAmount 9999;
		Powerup.Duration -9999;
	}
	Override bool HandlePickup(Inventory item){
		If(item.GetClass() == self.GetClass()){self.amount += item.amount;}
		return Super.HandlePickup(item);
	}
}
*/

Class Injury : Powerup abstract{
	int timer;
	int timerTicks; property TimerTicks : timerTicks;
	Default{
		Inventory.Icon "";
		Inventory.Amount 1;
		Inventory.MaxAmount 9999;
		+INVENTORY.UNDROPPABLE;
		+INVENTORY.UNTOSSABLE;
		Powerup.Duration 0x7FFFFFFF;
		Injury.TimerTicks 350;
	}
	Override bool HandlePickup(Inventory item){
		If(item.GetClass() == self.GetClass()){self.amount += item.amount;}
		Return Super.HandlePickup(item);
	}
	Override void AttachToOwner(Actor other){
		timer = timerTicks;
		Super.AttachToOwner(other);
	}
	Override void Tick(){
		timer--;
		If(timer <= 0){
			timer = timerTicks;
			InjuryTick();
		}
		Super.Tick();
	}
	Virtual void InjuryTick(){}
	Override void DetachFromOwner(){
		timer = 0;
		Super.DetachFromOwner();
	}
	/*
	Override bool TryPickup(in out Actor toucher){return Super.TryPickup(toucher);}
	Override bool HandlePickup(Inventory item){return Super.HandlePickup(item);}
	Override void AttachToOwner(Actor other){}
	Override void Tick(){}
	Override void DetachFromOwner(){}
	Override void InitEffect(){}
	Override void DoEffect(){}
	Override void EndEffect(){}
	*/
}

Class InjuryBluntForceTrauma : Injury{
	Default{Inventory.Icon "SMITA0"; Injury.TimerTicks 350;}
	Override void InjuryTick(){
		owner.GiveBody(1);
		owner.TakeInventory("InjuryBluntForceTrauma",1);
	}
}
Class InjuryLaceration : Injury{
	Default{Inventory.Icon "CSAWA0"; Injury.TimerTicks 350;}
	Override void InjuryTick(){
		owner.GiveBody(1);
		owner.TakeInventory("InjuryLaceration",1);
	}
}
Class InjuryBleeding : Injury{
	Default{Inventory.Icon "BLUDA0"; Injury.TimerTicks 350;}
	Override void InjuryTick(){
		owner.GiveInventory("InjuryBloodLoss",1);
		owner.TakeInventory("InjuryBleeding",1);
		If(owner.health == 1){owner.A_DamageSelf(1);}
		Else{owner.A_SetHealth(owner.health -= 1);}
		//owner.A_DamageSelf(1);
	}
}
Class InjuryBloodLoss : Injury{
	Default{Inventory.Icon "BLUDC0"; Injury.TimerTicks 350;}
	Override void InjuryTick(){
		owner.GiveBody(1);
		owner.TakeInventory("InjuryBloodLoss",1);
	}
}
Class InjurySepsis : Injury{
	Default{Inventory.Icon "BLUDC0"; Injury.TimerTicks 350;}
	Override void InjuryTick(){
		owner.GiveInventory("InjurySepsis",1);
		If(owner.health == 1){owner.A_DamageSelf(1);}
		Else{owner.A_SetHealth(owner.health -= 1);}
		//owner.A_DamageSelf(1);
	}
}
Class InjuryBurn : Injury{
	Default{Inventory.Icon "FIREA0"; Injury.TimerTicks 350;}
	Override void InjuryTick(){
		//owner.GiveInventory("InjurySepsis",1);
		owner.TakeInventory("InjuryBurn",1);
	}
}
Class InjuryGunshotWound : Injury{
	Default{Inventory.Icon "BLUDC0"; Injury.TimerTicks 350;}
	Override void InjuryTick(){
		owner.GiveBody(1);
		owner.TakeInventory("InjuryGunshotWound",1);
	}
}
Class InjuryDeepTissueInjury : Injury{
	Default{Inventory.Icon "FBXPA0"; Injury.TimerTicks 350;}
	Override void InjuryTick(){
		owner.GiveBody(1);
		owner.TakeInventory("InjuryDeepTissueInjury",1);
	}
}
Class InjuryForeignBody : Injury{Default{Inventory.Icon "ROCKA0"; Injury.TimerTicks 350;}}
