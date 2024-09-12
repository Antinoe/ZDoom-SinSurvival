
Class SinSurvivalPowerOpium : PowerProtection{
	Default{
		+INVENTORY.ADDITIVETIME;
		Inventory.Icon "POT1A0";
		Powerup.Duration -120;
		DamageFactor 0.75;
		//DamageFactor "Normal", 0.25;
	}
}
Class SinSurvivalPowerAdrenaline : Powerup{
	Default{
		+INVENTORY.ADDITIVETIME;
		Inventory.Icon "POT2A0";
		Powerup.Duration -120;
	}
}
Class SinSurvivalPowerSteroids : Powerup{
	Default{
		+INVENTORY.ADDITIVETIME;
		Inventory.Icon "POT3A0";
		Powerup.Duration -10;
	}
	Override void AttachToOwner(Actor other){
		//other.bonusHealth *= 2;
		other.GiveInventory("UpgradeStamina",100);
	}
	Override void DetachFromOwner(){
		//owner.bonusHealth /= 2;
		owner.TakeInventory("UpgradeStamina",100);
	}
}
