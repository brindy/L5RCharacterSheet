package com.brindysoft.l5r.main.control
{
	import com.brindysoft.l5r.main.model.Technique;
	import com.brindysoft.l5r.main.model.TechniqueRank;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;

	[Bindable]
	public class TechniquesViewController
	{
		
		[Inject]
		public var sheet:CharacterSheetController;
		
		public function TechniquesViewController()
		{
		}
		
		public function addTechnique() : void {
			
			if (!sheet.currentSheet.techniques) {
				sheet.currentSheet.techniques = new ArrayCollection();
			}
			
			sheet.currentSheet.techniques.addItemAt(new Technique(), 0);
			sheet.dirty = true;
		}
		
		public function deleteTechnique(technique:Technique) : void {
			
			Alert.show("Are you sure you want to delete this technique?", "Confirm", Alert.YES | Alert.NO, null,
				function(event:CloseEvent) : void {
					if (event.detail == Alert.YES) {
						var index:int = sheet.currentSheet.techniques.getItemIndex(technique);
						sheet.currentSheet.techniques.removeItemAt(index);
						sheet.dirty = true;
						
						if (sheet.currentSheet.techniques.length == 0) {
							sheet.currentSheet.techniques = null;
						}
					}
				});
			
		}
		
		public function addRank(technique:Technique) : void {
			if (!technique.ranks) {
				technique.ranks = new ArrayCollection();
			}
			technique.ranks.addItem(new TechniqueRank());
			sheet.dirty = true;
		}
		
		public function deleteRank(technique:Technique, rank:TechniqueRank) : void {
			Alert.show("Are you sure you want to delete this rank?", "Confirm", Alert.YES | Alert.NO, null,
				function(event:CloseEvent) : void {
					if (event.detail == Alert.YES) {
						var index:int = technique.ranks.getItemIndex(rank);
						technique.ranks.removeItemAt(index);
						sheet.dirty = true;
						
						if (technique.ranks.length == 0) {
							technique.ranks = null;
						}
					}
				});
		}
			
	}
}