package com.brindysoft.l5r.main.control
{
	
	import com.brindysoft.l5r.main.model.CharacterSheet;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.net.registerClassAlias;
	
	import hr.binaria.asx3m.Asx3m;
	import hr.binaria.asx3m.Asx3mer;
	import hr.binaria.asx3m.mapper.IMapper;
	
	import mx.binding.utils.ChangeWatcher;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.events.PropertyChangeEvent;
	import mx.utils.ObjectProxy;
	
	import org.spicefactory.lib.reflect.cache.DefaultReflectionCache;
	
	[Bindable]
	public class CharacterSheetController 
	{
		
		public var canSave:Boolean;
		
		public var canSaveAs:Boolean;
		
		public var currentSheet:CharacterSheet;

		private var _dirty:Boolean;
		
		private var file:File;
		
		private var filename:String;
		
		private var asx3m:Asx3m;

		public function CharacterSheetController()
		{
			this.currentSheet = new CharacterSheet();
			asx3m = new Asx3m(Asx3mer.instance, null, new XMLMapper(), null);
		}
		
		public function set dirty(o:Boolean) : void {
			_dirty = o;
			canSave = true;
			canSaveAs = true;
		}
		
		public function get dirty() : Boolean {
			return _dirty;
		}
		
		public function load(filename:String = null) : void {
			this.filename = filename;
			
			if (dirty) {
				Alert.show("Do you want to abandon your unsaved changes?",
					"Confirm", Alert.YES | Alert.NO, null, onConfirmLoad);
			} else {
				onConfirmLoad();
			}
			
		}
		
		public function save() : void {
			if (!file) {
				saveAs();
			} else {
				doSave();
			}
		}
		
		public function saveAs() : void {
			if (!file) {
				file = File.userDirectory.resolvePath(currentSheet.name + ".l5r");
			}
			
			file.addEventListener(Event.SELECT, onSaveFileSelected);
			file.browseForSave("Save Character Sheet As...");
		}
		
		public function newSheet() : void {
			
			if (_dirty) {
				
				Alert.show("Do you want to abandon your unsaved changes?",
					"Confirm", Alert.YES | Alert.NO, null, onConfirmNew);
				
			} else {
				
				onConfirmNew();
				
			}
			
		}
		
		private function onConfirmNew(event:CloseEvent = null) : void {
			if (!event || event.detail == Alert.YES) {
			
				file = null;
				currentSheet = new CharacterSheet();
				
			}
		}
		
		
		private function onConfirmLoad(event:CloseEvent = null) : void {
			if (!event || event.detail == Alert.YES) {
				
				if (filename) {
					file = new File(filename);
					onLoadFileSelected();
					return;
				} else if (!file) {
					file = File.userDirectory;
				}
				file.addEventListener(Event.SELECT, onLoadFileSelected);
				file.browseForOpen("L5R Character Sheet", [new FileFilter("L5R Character Sheets", "*.l5r")]);
			}
			
		}

		private function onSaveFileSelected(event:Event) : void {
			file.removeEventListener(Event.SELECT, onSaveFileSelected);
			var response:String = doSave();
			if (response) {
				Alert.show(response, "Error loading file. :(");
			} else {
				Alert.show("File saved!", "Seikou! ^_^");
			}
		}

		private function onLoadFileSelected(event:Event = null) : void {
			file.removeEventListener(Event.SELECT, onLoadFileSelected);
			var response:String = doLoad();
			if (response) {
				Alert.show(response, "Error loading file. :(");
			} else {
				Alert.show("Konichwa, " + currentSheet.name + "!", "Seikou! ^_^");
			}
		}

		/** Try and save using the given name, or the existing name if null.
		 *  
		 * @return null if successful, error message otherwise. 
		 */
		private function doSave() : String {
			
			var xml:XML = 
				// Asx3mer.instance.toXML(currentSheet, "L5RCharacterSheet");
				asx3m.toCustomTypedXML(currentSheet, "L5RCharacterSheet");
			
			try {
	
				var stream:FileStream = new FileStream();
				stream.open(file, FileMode.WRITE);
				stream.writeUTFBytes(xml.toXMLString());
				stream.close();
	
				this.dirty = false;
				this.canSave = false;
			} catch(error:Error) {
				return error.message;
			}
			return null;
		}
		
		private function doLoad() : String {
			 try {
				var stream:FileStream = new FileStream();
				stream.open(file, FileMode.READ);

				var xml:XML = new XML(stream.readUTFBytes(stream.bytesAvailable));
				
				stream.close();
					
				var obj:CharacterSheet = 
					//Asx3mer.instance.fromXML(xml) as CharacterSheet;
					asx3m.fromXML(xml) as CharacterSheet;
				
				this.currentSheet = obj;				
				this.canSaveAs = true;
				this.dirty = false;
			} catch(error:Error) {
				return error.message;
			}
			return null;
		}
		
	}
		
}


import com.brindysoft.l5r.main.model.Advantage;
import com.brindysoft.l5r.main.model.Arrows;
import com.brindysoft.l5r.main.model.CharacterSheet;
import com.brindysoft.l5r.main.model.Disadvantage;
import com.brindysoft.l5r.main.model.Kata;
import com.brindysoft.l5r.main.model.ShugenjaTechnique;
import com.brindysoft.l5r.main.model.Skill;
import com.brindysoft.l5r.main.model.Spell;
import com.brindysoft.l5r.main.model.Technique;
import com.brindysoft.l5r.main.model.TechniqueRank;
import com.brindysoft.l5r.main.model.Weapon;

import hr.binaria.asx3m.mapper.ClassAliasingMapper;
import hr.binaria.asx3m.mapper.DefaultMapper;

class XMLMapper extends ClassAliasingMapper
{
	public function XMLMapper()
	{
		super(new DefaultMapper());
		
		addClassAlias("L5RCharacterSheet", CharacterSheet);
		addClassAlias("Skill", Skill);
		addClassAlias("Weapon", Weapon);
		addClassAlias("Arrows", Arrows);
		addClassAlias("Advantage", Advantage);
		addClassAlias("Disadvantage", Disadvantage);
		addClassAlias("Technique", Technique);
		addClassAlias("TechniqueRank", TechniqueRank);
		addClassAlias("Kata", Kata);
		addClassAlias("ShugenjaTechnique", ShugenjaTechnique);
		addClassAlias("Spell", Spell);
		
	}
	
}
