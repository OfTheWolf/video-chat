/**
 * VIDEOSOFTWARE.PRO
 * Copyright 2011 VideoSoftware.PRO
 * All Rights Reserved.
 *
 * This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
 *  as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
 *  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *  See the GNU General Public License for more details.
 *  You should have received a copy of the GNU General Public License along with this program.
 *  If not, see <http://www.gnu.org/licenses/>.
 * 
 *  Author: Our small team and fast growing online community at videosoftware.pro
 */
package jabbercam.lang
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.events.PropertyChangeEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	[Event(name="complete", type="flash.events.Event")]
	public class LanguageLoader extends EventDispatcher
	{
		private const languageFile : String = "jabbercam/language/lang_xx.ini";
		
		[Bindable]
		public static var languages : Array = ["English", "Spanish", "Chinese", "Russian", "German", 
			"French", "Thai", "Turkish", "Czech", "Bulgarian", "Romanian", "Hungarian"];
			
		[Bindable]
		public var codes : Array = ["en", "es", "ch", "ru", "de", "fr", "th", "tr", "cz", "bg", "ro", "hu"];
		private var serviceLoader : HTTPService;
		private var lang : Object;
		private var _langs : Object;
		private var _currentLang : int = 0;
		
		private var _ready : Boolean = false;
		
		[Bindable]
		public var backgroundImage : String;
		
		[Bindable]
		public var backgroundImage2 : String;
		
		[Bindable]
		public var backgroundImage3 : String;
		
		[Bindable]
		public var backgroundImage4 : String;
		
		[Bindable]
		public var backgroundImage5 : String;
		
		[Bindable]
		public var backgroundImage6 : String;
		
		[Bindable]
		public var getSourceCodeLink : String;
		
		[Bindable]
		public var getSourceCodeImage : String;
		
		public function LanguageLoader()
		{
			super();
			
			serviceLoader = new HTTPService();
			serviceLoader.resultFormat = HTTPService.RESULT_FORMAT_TEXT;
			serviceLoader.addEventListener(FaultEvent.FAULT, errorLoadingSettings);
			serviceLoader.addEventListener(ResultEvent.RESULT, completeLoadingSettings);
		}
		
		public function loadLanguage(id : int) : void {
			if(id < 0 || id > this.codes.length - 1)
			return;
			
			this._ready = false;
			this._currentLang = id;
			
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE, false, false, null, "currentLanguage"));
			
			if(this._langs && this._langs[this.codes[id]]) {
				this.completeLoadingSettings({result:this._langs[this.codes[id]]});
				return;
			} else if(!this._langs) {
				this._langs = new Object();
			}
	
			serviceLoader.url = languageFile.replace(/xx/, this.codes[id]);
			serviceLoader.send();
		}
		
		private function errorLoadingSettings(ev : FaultEvent) : void {
			if(!lang && this._currentLang != 0)
			loadLanguage(0);
		}
		
		private function parseLang(text : String) : Object {
			var lang : Object = {};
			if(text != null) {
				text = text.replace(/\r+|(?:\r\n)+|\n+/g, '\n');
				
				var matches : Array;
				var reg : RegExp = /^\s*(\w+)\s*=\s*(.+)\s*$/mg;
				while((matches = reg.exec(text)) != null) {
					lang[matches[1]] = matches[2];
				}
			}
			
			return lang;
		}
		
		private function completeLoadingSettings(ev : Object) : void {
			this.lang = parseLang(ev.result as String);
			this._langs[this.codes[this._currentLang]] = this.lang;
			
			this._ready = true;
			
			this.backgroundImage = this.lang.backgroundImage_1.toString();
			this.backgroundImage2 = this.lang.backgroundImage_2.toString();
			this.backgroundImage3 = this.lang.backgroundImage_3.toString();
			this.backgroundImage4 = this.lang.backgroundImage_4.toString();
			this.backgroundImage5 = this.lang.backgroundImage_5.toString();
			this.backgroundImage6 = this.lang.backgroundImage_6.toString();
			
			this.getSourceCodeImage = this.lang.getSourceCodeImage.toString();
			this.getSourceCodeLink = this.lang.getSourceCode.toString();
			
//			Simple trick to execute bindings this.rvcTooltip = 
			this.videosoftwareTooltip = this.myspaceTooltip = this.facebookTooltip = this.twitterTooltip = this.buzzTooltip = this.rvcTooltip = this.btnAdTooltip = this.btnHelpTooltip = this.btnAboutTooltip = "bum";
			
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get ready() : Boolean {
			return this._ready;
		}
		
		[Bindable]
		public function get currentLanguage() : int {
			return this._currentLang;
		}
		public function set currentLanguage(value : int) : void {
			this.loadLanguage(value);
		}
		
		//videosoftware.pro
		public function set videosoftwareTooltip(value : String) : void {
			
		}
		[Bindable]
		public function get videosoftwareTooltip() : String {
			return lang.videosoftwareLogoTooltip.toString();
		}
		
		//Facebook
		public function set facebookTooltip(value : String) : void {
			
		}
		[Bindable]
		public function get facebookTooltip() : String {
			return lang.facebookButtonTooltip.toString();
		}
		
		//Twitter
		public function set twitterTooltip(value : String) : void {
			
		}
		[Bindable]
		public function get twitterTooltip() : String {
			return lang.twitterButtonTooltip.toString();
		}
		
		//Google buzz
		public function set buzzTooltip(value : String) : void {
			
		}
		[Bindable]
		public function get buzzTooltip() : String {
			return lang.buzzButtonTooltip.toString();
		}
		
		//mySpace
		public function set myspaceTooltip(value : String) : void {
			
		}
		[Bindable]
		public function get myspaceTooltip() : String {
			return lang.myspaceButtonTooltip.toString();
		}
		
		//RVC
		public function set rvcTooltip(value : String) : void {
			
		}
		[Bindable]
		public function get rvcTooltip() : String {
			return lang.rvcButtonTooltip.toString();
		}
		
		//RVC Ad button
		public function set btnAdTooltip(value : String) : void {
			
		}
		[Bindable]
		public function get btnAdTooltip() : String {
			return lang.adButtonTooltip.toString();
		}
		
		//RVC About
		public function set btnAboutTooltip(value : String) : void {
			
		}
		[Bindable]
		public function get btnAboutTooltip() : String {
			return lang.aboutTooltip.toString();
		}
		
		//RVC Help
		public function set btnHelpTooltip(value : String) : void {
			
		}
		[Bindable]
		public function get btnHelpTooltip() : String {
			return lang.helpTooltip.toString();
		}
		
		public function getSimpleProperty(key : String) : String {
			try {
				return lang[key].toString();
			} catch(e : Error) {
				return "";
			}
			
			return "";
		}
		
		public function getCompoundProperty(key : String, index : int = 0) : String {
			try {
				return lang[key+"_"+index].toString();
			} catch(e : Error) {
				return "";
			}
			
			return "";
		}
		
		public function getSetting(key : String) : String {
			try {
				return lang[key].toString();
			} catch(e : Error) {
				return "";
			}
			
			return "";
		}
	}
}