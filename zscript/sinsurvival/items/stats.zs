
Class SinStat : Inventory{
	Default{
		Inventory.Amount 1;
		Inventory.MaxAmount 1000;
		+INVENTORY.UNDROPPABLE;
		+INVENTORY.UNTOSSABLE;
	}
}
Class SinVigor : SinStat{
	Override bool TryPickup(in out Actor toucher){
		If(toucher){
			int vigor = toucher.CountInv(self.GetClass())+self.amount;
			int newHealth = vigor*5;
			let playe = (toucher.player ? toucher.player.mo : null);
			If(playe){playe.maxHealth=newHealth;}
			toucher.startHealth=newHealth;
			toucher.A_SetHealth(newHealth);
			//playe.A_Log("Vigor: " .. vigor .. " | Max HP: " .. playe.maxHealth);
		}
		Return Super.TryPickup(toucher);
	}
	//	NOTE: I'm a little leery about overriding this hook for Vigor.. Might be buggy..
	Override void DoEffect(){
		If(owner){
			int vigor = owner.CountInv(self.GetClass());
			int newHealth = vigor*5;
			let playe = (owner.player ? owner.player.mo : null);
			If(playe){playe.maxHealth=newHealth;}
			owner.startHealth=newHealth;
			//If(playe.health>playe.maxHealth){playe.health=playe.maxHealth;}
		}
	}
	Override void DetachFromOwner(){
		If(owner){
			let playe = (owner.player ? owner.player.mo : null);
			If(playe){playe.maxHealth=5;}
			owner.startHealth=5;
			owner.A_SetHealth(5);
			owner.GiveInventory(self.GetClass(),1);
		}
		Super.DetachFromOwner();
	}
}
Class SinEndurance : SinStat{
	Override bool TryPickup(in out Actor toucher){
		let playe = SinPlayer(toucher);
		If(!playe){Return 0;}
		int endurance = playe.CountInv(self.GetClass())+self.amount;
		int newStamina = endurance*5;
		playe.maxStamin=newStamina;
		playe.stamin=newStamina;
		Return Super.TryPickup(toucher);
	}
	Override void DoEffect(){
		If(owner){
			let playe = SinPlayer(owner);
			If(!playe||!owner.player){Return;}
			int endurance = playe.CountInv(self.GetClass());
			int newStamina = endurance*5;
			If(!owner.player.cmd.buttons&BT_RUN){playe.stamin+=350;playe.A_Log("Stamina Regenerating..");}
			playe.maxStamin=newStamina;
			If(playe.stamin>playe.maxStamin){playe.stamin=playe.maxStamin;}
		}
	}
	Override void DetachFromOwner(){
		If(owner){
			let playe = SinPlayer(owner);
			If(!playe){Return;}
			playe.stamin=5;
			playe.maxStamin=5;
			playe.GiveInventory(self.GetClass(),1);
			Super.DetachFromOwner();
		}
	}
}
Class SinStrength : SinStat{
	Override void DetachFromOwner(){
		If(owner){
			let playe = SinPlayer(owner);
			If(!playe){Return;}
			playe.GiveInventory(self.GetClass(),1);
			Super.DetachFromOwner();
		}
	}
}
Class SinDexterity : SinStat{
	Override void DetachFromOwner(){
		If(owner){
			let playe = SinPlayer(owner);
			If(!playe){Return;}
			playe.GiveInventory(self.GetClass(),1);
			Super.DetachFromOwner();
		}
	}
}
Class SinPosture : SinStat{}
Class SinPoise : SinStat{
	Override bool TryPickup(in out Actor toucher){
		If(toucher){
			toucher.GiveInventory("SinPosture",self.amount);
		}
		Return Super.TryPickup(toucher);
	}
	Override void DoEffect(){
		If(owner){
			let poise = owner.FindInventory(self.GetClass());
			let posture = owner.FindInventory("SinPosture");
			If(!poise||posture.amount<poise.amount){owner.GiveInventory("SinPosture",1);}
			If(posture.amount>poise.amount){posture.amount=self.amount;}
		}
	}
	Override void DetachFromOwner(){
		If(owner){
			owner.TakeInventory("SinPosture",self.amount);
			Super.DetachFromOwner();
		}
	}
}
Class SinFocus : SinStat{}
Class SinResolve : SinStat{}
//	NOTE: This is for Monsters, not Players.
/*
Class SinStamina : SinStat{
	Override void DoEffect(){
		let playe = SinPlayer(owner);
		If(playe){
			self.maxAmount=playe.maxStamin;
			//playe.stamin=self.amount;
			self.amount=playe.stamin;
		}
	}
}
*/
