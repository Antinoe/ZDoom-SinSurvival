
Class SinBarrier : PowerProtection{
	string hitSound; property HitSound : hitSound;
	string regenSound; property RegenSound : regenSound;
	string lowSound; property LowSound : lowSound;
	string emptySound; property EmptySound : emptySound;
	bool canCharge; property CanCharge : canCharge;
	int chargeDelay;
	int chargeSpeed;
	bool active;
	Default{
		Inventory.Amount 100;
		Inventory.MaxAmount 100;
		DamageFactor "Normal",1;
		DamageFactor "Plasma",2;
		Powerup.Duration 0x7FFFFFFF;
		+INVENTORY.UNDROPPABLE;
		+INVENTORY.UNTOSSABLE;
		+INVENTORY.PERSISTENTPOWER;
		//+INVENTORY.KEEPDEPLETED;
	}
	Override void PostBeginPlay(){
		If(owner){
			active=1;
			//owner.A_Log("BARRIER INTEGRITY: " .. self.amount);
		}
	}
	Override bool HandlePickup(Inventory item){
		If(item.GetClass()==self.GetClass()){self.amount+=item.amount;}
		Return Super.HandlePickup(item);
	}
	//	Attacked by Monsters/Projectiles.
	Override void ModifyDamage(int damage, Name damageType, out int newdamage, bool passive, Actor inflictor, Actor source, int flags){
		If(!active||self.amount<=0||owner==null){Return;}
		//If(source&&passive){
		If(passive&&damage>0){
			chargeDelay=140;
			newdamage=max(0,ApplyDamageFactors(GetClass(),damageType,damage,damage/4));
			self.amount-=newdamage;
			//console.Printf("KINETIC IMPACT IMMINENT. ABSORBING: \cd%d\c-, \cy\"%s\"\c-. RESULTING FORCE: \cd%d\c-",damage,damageType,newDamage);
			//owner.A_Log("BARRIER INTEGRITY: " .. self.amount);
			let damageIntensity = newdamage/2;
			owner.A_Quake(damageIntensity,5,0,100,0);
			owner.A_SetBlend("LightBlue",1,10);
			owner.A_StartSound(hitSound,CHAN_BODY,CHANF_OVERLAP);
			newdamage=0;
		}
	}
	//	Melting in Slime/Acid/Lava. ..Or not. The hook above works just fine.
	/*
	Override void AbsorbDamage(int damage, Name damageType, out int newdamage, Actor inflictor, Actor source, int flags){
		If(!active||self.amount<=0||owner==null){
			//owner.A_Log("BARRIER INACTIVE. UNABLE TO REDUCE IMPACT.");
			Return;
		}
		If(self.amount>0&&damage>0){
			let barrierDamage = max(0,ApplyDamageFactors(GetClass(),damageType,damage,damage/4));
			self.amount-=barrierDamage;
			owner.A_StartSound(hitSound,CHAN_BODY,CHANF_OVERLAP);
			//owner.A_Log("BARRIER INTEGRITY: " .. self.amount);
			newdamage=0;
		}
	}
	*/
}
