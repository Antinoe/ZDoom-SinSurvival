
Class SinBallisticArmor : SinArmor abstract{
	enum SinBallisticLevel{
		LEVEL1 = 0, //	Stab protection; Knives, Axes.
		LEVEL2 = 1, //	Low-Velocity Handgun protection; 9mm, .357 Magnum.
		LEVEL3A = 2, //	High-Velocity Handgun protection; 12-Gauge Buckshot, 12-Gauge Birdshot, .44 Magnum.
		LEVEL3 = 3, //	High-Velocity Rifle protection; .308cal, 5.56mm, 7.62mm.
		LEVEL4 = 4, //	High-Velocity Armor-Piercing Rifle protection; .30cal Steel Core.
	}
	int ballisticlevel; property BallisticLevel : ballisticlevel; //Level of ballistic protection. Refer to BallisticLevel.
	Default{
		SinItem.RemoveWhenEmpty 1;
		SinArmor.Protection 50;
		SinBallisticArmor.BallisticLevel LEVEL1;
	}
	Override void AbsorbDamage (int damage, Name damageType, out int newdamage, Actor inflictor, Actor source, int flags){
		//	Level 1
		If(ballisticlevel>=0){
			If(damageType == "Axe" || damageType == "Cut" || damageType == "Claw" || damageType == "ImpClaw" || damageType == "Dagger" || damageType == "Stab" || damageType == "Slash" || damageType == "Poke" || damageType == "Pierce" || damageType == "Puncture" || damageType == "Penetrate" || damageType == "Sharp" || damageType == "Knife" || damageType == "Hatchet" || damageType == "Sword"){
				newdamage = damage * 0.10;
			}
		}
		//	Level 2
		If(ballisticlevel>=1){
			If(damageType == "Pistol" || damageType == "Handgun" || damageType == "45ACP" || damageType == ".45ACP" || damageType == "9mm" || damageType == "357Magnum" || damageType == ".357Magnum"){
				newdamage = damage * 0.50;
			}
		}
		//	Level 3A
		If(ballisticlevel>=2){
			If(damageType == "Shotgun" || damageType == "12Gauge" || damageType == "12GaugeBuckshot" || damageType == "12GaugeBirdshot" || damageType == "44Magnum" || damageType == ".44Magnum"){
				newdamage = damage * 0.50;
			}
		}
		//	Level 3
		If(ballisticlevel>=3){
			If(damageType == "Rifle" || damageType == "556mm" || damageType == "5.56mm" || damageType == "762mm" || damageType == "7.62mm"){
				newdamage = damage * 0.50;
			}
		}
	}
	Override void OnEquip(SinPlayer user){
		If(self.ballisticlevel == 0){self.subtag = "Level I";}
		If(self.ballisticlevel == 1){self.subtag = "Level II";}
		If(self.ballisticlevel == 2){self.subtag = "Level IIIA";}
		If(self.ballisticlevel == 3){self.subtag = "Level III";}
		If(self.ballisticlevel == 4){self.subtag = "Level IV";}
	}
	Override void OnUnequip(SinPlayer user){
		If(self.ballisticlevel == 0){self.subtag = "Level I";}
		If(self.ballisticlevel == 1){self.subtag = "Level II";}
		If(self.ballisticlevel == 2){self.subtag = "Level IIIA";}
		If(self.ballisticlevel == 3){self.subtag = "Level III";}
		If(self.ballisticlevel == 4){self.subtag = "Level IV";}
	}
	//	NOTE: Had to ommit this because of the way Doom's Armor system functions;
	//	Nothing is saved. When you equip/unequip Armor items, their properties are reset.
	/*
	Override bool Combine(SinItem other, SinInvManager invman){
		If(other.subtag=="Level IIIA"){
			self.amount += 25;
			self.maxamount += 25;
			self.ballisticlevel = 2;
			self.subtag = "Level IIIA";
			other.TakeAmount(1,invman);
			Return 1;
		}
		If(other.subtag=="Level III"){
			self.amount += 100;
			self.maxamount += 100;
			self.ballisticlevel = 3;
			self.subtag = "Level III";
			other.TakeAmount(1,invman);
			Return 1;
		}
		If(other.subtag=="Level IV"){
			self.amount += 50;
			self.maxamount += 50;
			self.ballisticlevel = 4;
			self.subtag = "Level IV";
			other.TakeAmount(1,invman);
			Return 1;
		}
		Return 0;
	}
	*/
}
