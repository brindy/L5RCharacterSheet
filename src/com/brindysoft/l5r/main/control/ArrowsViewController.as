package com.brindysoft.l5r.main.control
{
	import com.brindysoft.l5r.main.model.Arrows;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;

	public class ArrowsViewController
	{
		[Inject]
		public var sheet:CharacterSheetController;
		
		public function ArrowsViewController()
		{
		}
		
		public function addArrows() : void {
			
			if (!sheet.currentSheet.arrows) { 
				sheet.currentSheet.arrows = new ArrayCollection();
			}
			
			sheet.currentSheet.arrows.addItemAt(new Arrows(), 0);
			sheet.dirty = true;
		}
		
		
		public function deleteArrows(arrows:Arrows) : void {
			
			Alert.show("Are you sure you want to delete these arrorws?", "Confirm", Alert.YES | Alert.NO, null,
				function(event:CloseEvent) : void {
					if (event.detail == Alert.YES) {
						var index:int = sheet.currentSheet.arrows.getItemIndex(arrows);
						sheet.currentSheet.arrows.removeItemAt(index);
						sheet.dirty = true;
						
						if (sheet.currentSheet.arrows.length == 0) {
							sheet.currentSheet.arrows = null;
						}
					}
				});
			
		}
		
	}
}