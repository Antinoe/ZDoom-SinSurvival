
Class ScrapKit : SinMisc{
	Default{
		Tag "Scrap Kit";
		Inventory.Icon "RKITA0";
		Inventory.Amount 10;
		Inventory.MaxAmount 10;
	}
	States{Spawn: RKIT A -1; Stop;}
	Override void OnCombine(){
		A_Log("Combined Scrapping Kit with an Item.");
	}
	Override bool Combine(SinItem other, SinInvManager invman){
		if(other.subtag == "$SINWEAP_PISTOLSUBT" || other.subtag == "Pistol" || other.subtag == "Handgun" || other.subtag == "Revolver" || other.subtag == "Handcannon"){
			let item = SinItem(owner.Spawn("SinSteel",owner.pos));
			if(item){
				item.AttachToOwner(owner);
				item.Amount = 1;
				item.SinfulPickup(invman);
			}
			other.TakeAmount(10,invman);
			self.TakeAmount(1,invman);
			Return 1;
		}
		if(other.subtag == "Ammunition"){
			let item = SinItem(owner.Spawn("SinGunpowder1",owner.pos));
			if(item){
				item.AttachToOwner(owner);
				item.SinfulPickup(invman);
			}
			other.TakeAmount(10,invman);
			self.TakeAmount(1,invman);
			Return 1;
		}
		Return 0;
	}
}
