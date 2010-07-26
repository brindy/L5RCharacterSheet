package com.brindysoft.l5r.main.control
{
	import com.brindysoft.l5r.main.model.Spell;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	[Bindable]
	public class SpellsViewController
	{
		
		[Inject]
		public var sheet:CharacterSheetController;
		
		public function SpellsViewController()
		{
		}
		
		public function addSpell() : void {
			
			if (!sheet.currentSheet.spells) { 
				sheet.currentSheet.spells = new ArrayCollection();
			}
			
			sheet.currentSheet.spells.addItemAt(new Spell(), 0);
			sheet.dirty = true;
		}
		
		
		public function deleteSpell(spell:Spell) : void {
			
			Alert.show("Are you sure you want to delete this spell?", "Confirm", Alert.YES | Alert.NO, null,
				function(event:CloseEvent) : void {
					if (event.detail == Alert.YES) {
						var index:int = sheet.currentSheet.spells.getItemIndex(spell);
						sheet.currentSheet.spells.removeItemAt(index);
						sheet.dirty = true;
						
						if (sheet.currentSheet.spells.length == 0) {
							sheet.currentSheet.spells = null;
						}
						
					}
				});
			
		}
		
		
	}
}