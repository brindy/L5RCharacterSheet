package com.brindysoft.l5r.main.model 
{
	
	[Bindable]
	public class CharacterSheet
	{
		
		public var name:String;
		
		public var basicDetails:BasicDetails = new BasicDetails();
		
		public function CharacterSheet()
		{
		}
		
	}
}