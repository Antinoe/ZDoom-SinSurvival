
//	Instant Healing.
Class SinSurvivalHealing : SinHealing abstract{
	//	Need to work on this one.
	bool healAll; property HealAll : healAll; //Whether the item heals all injuries or not.
	string injury1; property Injury1 : injury1; //The primary type of injury to heal from.
	string injury2; property Injury2 : injury2; //The secondary type of injury to heal from.
	string injury3; property Injury3 : injury3; //The tertiary type of injury to heal from.
	Override bool Use(bool pickup){
		If(owner){
			let injurytype1 = owner.FindInventory(injury1);
			let injurytype2 = owner.FindInventory(injury2);
			let injurytype3 = owner.FindInventory(injury3);
			//	If not injury types 1-3, return..
			if(injurytype1 || injurytype2 || injurytype3){
				if(injurytype1){owner.GiveBody(health); owner.TakeInventory(injury1,health);}
				if(injurytype2){owner.GiveBody(health); owner.TakeInventory(injury2,health);}
				if(injurytype3){owner.GiveBody(health); owner.TakeInventory(injury3,health);}
				Amount--;
				If(Amount<1&&delempty){
					let invman = SinInvManager(owner.FindInventory("SinInvManager"));
					int index = invman.items.Find(self);
					If(index!=invman.items.Size()){
						invman.DeleteFrom(index);
						Destroy();
					}
				}
				Return 1;
			}
		}
		Return 0;
	}
}
//	Healing Over Time.
Class HealInjury : Powerup abstract{
	int timer;
	int timerTicks; property TimerTicks : timerTicks;
	Default{
		Inventory.Icon "";
		Inventory.Amount 1;
		Inventory.MaxAmount 9999;
		+INVENTORY.UNDROPPABLE;
		+INVENTORY.UNTOSSABLE;
		Powerup.Duration 0x7FFFFFFF;
		HealInjury.TimerTicks 105;
	}
	Override bool HandlePickup(Inventory item){
		if(item.GetClass() == self.GetClass()){self.amount += item.amount;}
		Return Super.HandlePickup(item);
	}
	Override void AttachToOwner(Actor other){
		timer = timerTicks;
		Super.AttachToOwner(other);
	}
	Override void Tick(){
		timer--;
		if(timer <= 0){
			timer = timerTicks;
			HealTick();
		}
		Super.Tick();
	}
	Virtual void HealTick(){}
	Override void DetachFromOwner(){
		timer = 0;
		Super.DetachFromOwner();
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
Class HealBluntForceTrauma : HealInjury{
	Default{HealInjury.TimerTicks 105;}
	Override void HealTick(){
		let hasBluntForceTrauma = owner.FindInventory("InjuryBluntForceTrauma",1);
		If(hasBluntForceTrauma){
			owner.GiveBody(1);
			owner.TakeInventory("InjuryBluntForceTrauma",1);
			owner.TakeInventory("HealBluntForceTrauma",1);
		}
	}
}
Class HealLaceration : HealInjury{
	Default{HealInjury.TimerTicks 105;}
	Override void HealTick(){
		let hasLaceration = owner.FindInventory("InjuryLaceration",1);
		If(hasLaceration){
			owner.GiveBody(1);
			owner.TakeInventory("InjuryLaceration",1);
			owner.TakeInventory("HealLaceration",1);
		}
	}
}
Class HealBleeding : HealInjury{
	Default{HealInjury.TimerTicks 35;}
	Override void HealTick(){
		let hasBleeding = owner.FindInventory("InjuryBleeding",1);
		If(hasBleeding){
			owner.GiveBody(1);
			owner.TakeInventory("InjuryBleeding",1);
			owner.TakeInventory("HealBleeding",1);
		}
	}
}
Class HealSepsis : HealInjury{
	Default{HealInjury.TimerTicks 35;}
	Override void HealTick(){
		let hasSepsis = owner.FindInventory("InjurySepsis",1);
		If(hasSepsis){
			owner.GiveBody(1);
			owner.TakeInventory("InjurySepsis",1);
			owner.TakeInventory("HealSepsis",1);
		}
	}
}
Class HealBurn : HealInjury{
	Default{HealInjury.TimerTicks 35;}
	Override void HealTick(){
		let hasBurn = owner.FindInventory("InjuryBurn",1);
		If(hasBurn){
			owner.GiveBody(1);
			owner.TakeInventory("InjuryBurn",1);
			owner.TakeInventory("HealBurn",1);
		}
	}
}
Class HealGunshotWound : HealInjury{
	Default{HealInjury.TimerTicks 105;}
	Override void HealTick(){
		let hasGunshotWound = owner.FindInventory("InjuryGunshotWound",1);
		If(hasGunshotWound){
			owner.GiveBody(1);
			owner.TakeInventory("InjuryGunshotWound",1);
			owner.TakeInventory("HealGunshotWound",1);
		}
	}
}
Class HealDeepTissueInjury : HealInjury{
	Default{HealInjury.TimerTicks 105;}
	Override void HealTick(){
		let hasDeepTissueInjury = owner.FindInventory("InjuryDeepTissueInjury",1);
		If(hasDeepTissueInjury){
			owner.GiveBody(1);
			owner.TakeInventory("InjuryDeepTissueInjury",1);
			owner.TakeInventory("HealDeepTissueInjury",1);
		}
	}
}
//	Push shrapnel out over time like Wolverine.
Class HealForeignBody : HealInjury{
	Default{HealInjury.TimerTicks 35;}
	Override void HealTick(){
		owner.TakeInventory("InjuryForeignBody",1);
		owner.TakeInventory("HealForeignBody",1);
	}
}
