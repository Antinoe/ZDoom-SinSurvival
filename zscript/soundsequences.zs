
Class PowerEating : PowerRegeneration
{
	//	Every time you bite/drink.
	string biteSound; property BiteSound : biteSound;
	//	Every time you swallow.
	string swallowSound; property SwallowSound : swallowSound;
	Default
	{
		Powerup.Duration 70;
		Powerup.Strength 0;
		//Inventory.Icon "STIMA0";
		//PowerEating.BiteSound "items/food/chew";
		//PowerEating.SwallowSound "items/food/swallow";
	}
	Virtual void Bite(){
		owner.GiveBody(random(sinfood_bitehealmin,sinfood_bitehealmax),9999);
		owner.A_StartSound(biteSound,CHAN_AUTO,CHANF_OVERLAP);
	}
	Virtual void Swallow(){
		owner.GiveBody(random(sinfood_bitehealmin,sinfood_bitehealmax),9999);
		owner.A_StartSound(swallowSound,CHAN_AUTO,CHANF_OVERLAP);
	}
	Override void DoEffect(){
		If(EffectTics == 80){Bite();}
		If(EffectTics == 60){Bite();}
		If(EffectTics == 40){Bite();}
		If(EffectTics == 20){Swallow();}
		//Super.DoEffect();
	}
}
Class EatGenericSingle : PowerEating	{Default{Powerup.Duration 20;PowerEating.BiteSound "items/food/chew";PowerEating.SwallowSound "items/food/swallow";}}
Class EatGeneric : PowerEating	{Default{Powerup.Duration 80;PowerEating.BiteSound "items/food/chew";PowerEating.SwallowSound "items/food/swallow";}}
Class EatApple : PowerEating	{Default{Powerup.Duration 80;PowerEating.BiteSound "items/food/apple";PowerEating.SwallowSound "items/food/swallow";}}
Class EatCarrot : PowerEating	{Default{Powerup.Duration 80;PowerEating.BiteSound "items/food/carrot";PowerEating.SwallowSound "items/food/swallow";}}
Class EatCelery : PowerEating	{Default{Powerup.Duration 50;PowerEating.BiteSound "items/food/celery";PowerEating.SwallowSound "items/food/swallow";}}
Class EatPeach : PowerEating	{Default{Powerup.Duration 80;PowerEating.BiteSound "items/food/peach";PowerEating.SwallowSound "items/food/swallow";}}
Class EatPear : PowerEating	{Default{Powerup.Duration 80;PowerEating.BiteSound "items/food/pear";PowerEating.SwallowSound "items/food/swallow";}}
