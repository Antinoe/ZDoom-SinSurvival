
Class SinNeed : Inventory{
	int drainRate; property DrainRate : drainRate;
	int timer;
	Default{
		Inventory.Amount 1;
		Inventory.MaxAmount 200;
		SinNeed.DrainRate 1050;
	}
	Override void BeginPlay(){timer=drainRate;}
	Override void DoEffect(){
		timer--;
		If(timer<=0){
			timer=drainRate;
			self.amount--;
			If(self.amount==0){self.Destroy();}
		}
	}
}
Class SinSleep : SinNeed{}
Class SinHunger : SinNeed{}
Class SinThirst : SinNeed{Default{SinNeed.DrainRate 525;}}
Class SinMeats : SinNeed{}
Class SinGrains : SinNeed{}
Class SinFruits : SinNeed{}
Class SinVegetables : SinNeed{}
Class SinSalts : SinNeed{}
Class SinSugars : SinNeed{}
