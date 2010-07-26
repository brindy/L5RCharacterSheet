package com.brindysoft.l5r.main.control
{
	import com.brindysoft.l5r.main.model.ShugenjaTechnique;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;

	[Bindable]
	public class ShugenjaViewController
	{
		
		[Inject]
		public var sheet:CharacterSheetController;
		
		public function ShugenjaViewController()
		{
		}
		
		public function addTechnique() : void {
			
			if (!sheet.currentSheet.shugenjaTechniques) {
				sheet.currentSheet.shugenjaTechniques = new ArrayCollection();	
			}
			sheet.currentSheet.shugenjaTechniques.addItem(new ShugenjaTechnique());
			sheet.dirty = true;
		}
		
		public function deleteTechnique(technique:ShugenjaTechnique) : void {
			
			Alert.show("Are you sure you want to delete this technique?", "Confirm", Alert.YES | Alert.NO, null,
				function(event:CloseEvent) : void {
					if (event.detail == Alert.YES) {
						var index:int = sheet.currentSheet.shugenjaTechniques.getItemIndex(technique);
						sheet.currentSheet.shugenjaTechniques.removeItemAt(index);
						sheet.dirty = true;
						
						if (sheet.currentSheet.shugenjaTechniques.length == 0) {
							sheet.currentSheet.shugenjaTechniques = null;
						}
						
					}
				});
			
		}
		
	}
}