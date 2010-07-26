package com.brindysoft.l5r.main.model 
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class CharacterSheet
	{
		
		public var name:String;
		
		public var version:String = "0.0.2";
		
		public var basicDetails:BasicDetails = new BasicDetails();
		
		public var personalInformation:PersonalInformation = new PersonalInformation();
		
		public var stats:Stats = new Stats();
		
		public var rings:Rings = new Rings();
		
		public var armor:Armor = new Armor();
		
		public var skills:ArrayCollection;
		
		public var weapons:ArrayCollection;
		
		public var arrows:ArrayCollection;
		
		public var advantages:ArrayCollection;
		
		public var disadvantages:ArrayCollection;
		
		public var techniques:ArrayCollection;
		
		public var katas:ArrayCollection;
		
		public var shugenjaTechniques:ArrayCollection;
		
		public var spellSlots:SpellSlots = new SpellSlots();
		
		public var spells:ArrayCollection;
		
		public function CharacterSheet()
		{
		}
		
	}
}