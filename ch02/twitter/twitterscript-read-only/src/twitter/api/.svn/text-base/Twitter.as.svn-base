/*
Twitter Library 2.0
*/
package twitter.api {
	
	import flash.events.*;
	import flash.net.*;
	import flash.xml.*;
	
	import twitter.api.data.*;
	import twitter.api.events.TwitterEvent;
	
	/**
	 * This is a wrapper class around the Twitter public API.
	 * The pattern for all of the calls is to:
	 * 1.) Use XML for the format
	 * 2.) Internally handle the event from the REST call
	 * 3.) Parse the XML into a strongly typed object
	 * 4.) Publish a TwitterEvent whose payload is the type object from above
	 */ 
	public class Twitter extends EventDispatcher
	{
		// constatns used for loaders
		private static const FRIENDS:String = "friends";
		private static const FRIENDS_TIMELINE:String = "friendsTimeline";
		private static const PUBLIC_TIMELINE:String = "timeline";
		private static const USER_TIMELINE:String = "userTimeline";
		private static const SET_STATUS:String = "setStatus";
		private static const FOLLOW_USER:String = "follow";
		private static const SHOW_STATUS:String = "showStatus";
		private static const REPLIES:String = "replies";
		private static const DESTROY:String = "destroy";
		private static const FOLLOWERS:String = "followers";
		private static const FEATURED:String = "featured";
		
		private static const LOAD_FRIENDS_URL:String = 
			"http://twitter.com/statuses/friends/$userId.xml";
		private static const LOAD_FRIENDS_TIMELINE_URL:String = 
			"http://twitter.com/statuses/friends_timeline/$userId.xml";
		private static const PUBLIC_TIMELINE_URL:String = 
			"http://twitter.com/statuses/public_timeline.xml"
		private static const LOAD_USER_TIMELINE_URL:String = 
			"http://twitter.com/statuses/user_timeline/$userId.xml"
		private static const FOLLOW_USER_URL:String = 
			"http://twitter.com/friendships/create/$userId.xml";
		private static const SET_STATUS_URL:String = 
			"http://twitter.com/statuses/update.xml";
		private static const SHOW_STATUS_URL:String = 
			"http://twitter.com/statuses/show/$id.xml";
		private static const REPLIES_URL:String = 
			"http://twitter.com/statuses/replies.xml";
		private static const DESTROY_URL:String = 
			"http://twitter.com/statuses/destroy/$id.xml";
		private static const FOLLOWERS_URL:String = 
			"http://twitter.com/statuses/followers.xml";
		private static const FEATURED_USERS_URL:String = 
			"http://twitter.com/statuses/featured.xml";
		private static const LITE:String = "?lite=true";
		
		// internal variables
		private var loaders:Array;
		// username and password currently not used, just rely on HTTP auth
		private var username:String;
		private var password:String;
		
		function Twitter() 
		{
			loaders = [];
			this.addLoader(FRIENDS, friendsHandler);
			this.addLoader(FRIENDS_TIMELINE, friendsTimelineHandler);
			this.addLoader(PUBLIC_TIMELINE, publicTimelineHandler);
			this.addLoader(USER_TIMELINE, userTimelineHandler);
			this.addLoader(SET_STATUS, setStatusHandler);
			this.addLoader(FOLLOW_USER, friendCreatedHandler);
			this.addLoader(SHOW_STATUS, showStatusHandler);
			this.addLoader(REPLIES, repliesHandler);
			this.addLoader(DESTROY, destroyHandler);
			this.addLoader(FOLLOWERS, followersHandler);
			this.addLoader(FEATURED, featuredHandler);
		}
	
		// Public API
		
		/**
		* Loads a list of Twitter friends and (optionally) their statuses. 
		 * Authentication required for private users.
		*/
		public function loadFriends(userId:String, lite:Boolean = true):void
		{
			var friendsLoader:URLLoader = this.getLoader(FRIENDS);
			var urlStr:String = LOAD_FRIENDS_URL.replace("$userId", userId);
			if (lite){
				urlStr += LITE;
			}
			friendsLoader.load(twitterRequest(urlStr));
		}
		/**
		* Loads the timeline of all friends on Twitter. Authentication required for private users.
		*/
		public function loadFriendsTimeline(userId:String):void
		{
			var friendsTimelineLoader:URLLoader = this.getLoader(FRIENDS_TIMELINE);
			friendsTimelineLoader.load(twitterRequest(LOAD_FRIENDS_TIMELINE_URL.replace("$userId",userId)));
		}
		/**
		* Loads the timeline of all public users on Twitter.
		*/
		public function loadPublicTimeline():void
		{
			var publicTimelineLoader:URLLoader = this.getLoader(PUBLIC_TIMELINE);
			publicTimelineLoader.load(twitterRequest(PUBLIC_TIMELINE_URL));
		}
		/**
		* Loads the timeline of a specific user on Twitter. Authentication required for private users.
		*/
		public function loadUserTimeline(userId:String):void
		{
			var userTimelineLoader:URLLoader = this.getLoader(USER_TIMELINE);
			userTimelineLoader.load(twitterRequest(LOAD_USER_TIMELINE_URL.replace("$userId", userId)));
		}
		
		/**
		 * Follows a user. Right now this uses the /friendships/create/user.format
		 */
		public function follow(userId:String):void
		{
			var req:URLRequest = twitterRequest(FOLLOW_USER_URL.replace("$userId",userId));
			req.method = "POST";
			this.getLoader(FOLLOW_USER).load(req);
		}
		/**
		* Sets user's Twitter status. Authentication required.
		*/
		public function setStatus(statusString:String):void
		{
			if (statusString.length <= 140)
			{
				var request : URLRequest = twitterRequest (SET_STATUS_URL);
				request.method = "POST"
				var variables : URLVariables = new URLVariables ();
				variables.status = statusString;
				request.data = variables;
				try
				{
					this.getLoader(SET_STATUS).load (request);
				} catch (error : Error)
				{
					trace ("Unable to set status");
				}
			} else 
			{
				trace ("STATUS NOT SET: status limited to 140 characters");
			}
		}
		
		/**
		 * Returns a single status, specified by the id parameter below.  
		 * The status's author will be returned inline.
		 */
		public function showStatus(id:String):void
		{
			var showStatusLoader:URLLoader = this.getLoader(SHOW_STATUS);
			showStatusLoader.load(twitterRequest(SHOW_STATUS_URL.replace("$id",id)));
		}
		
		/**
		 * Loads the most recent replies for the current authenticated user
		 */
		public function loadReplies():void
		{
			var repliesLoader:URLLoader = this.getLoader(REPLIES);
			repliesLoader.load(twitterRequest(REPLIES_URL));
		}
		
		public function loadFollowers(lite:Boolean=true):void
		{
			var followersLoader:URLLoader = this.getLoader(FOLLOWERS);
			var urlStr:String = FOLLOWERS_URL;
			if (lite){
				urlStr += LITE;
			}
			followersLoader.load(twitterRequest(urlStr));
		}
		
		public function loadFeatured():void
		{
			var featuredLoader:URLLoader = this.getLoader(FEATURED);
			featuredLoader.load(twitterRequest(FEATURED_USERS_URL));
		}
		
		// currently unused
		/**
		*  setAuth should be called before any methods that require authentication. PLEASE USE WITH CAUTION, Twitter user information should NOT be hardcoded in applications that are publicly available
		*/
		public function setAuth (username:String, password:String):void
		
		{	
			this.username = username;
			this.password = password;
		}		
		
		// private handlers for the events coming back from twitter
		
		private function friendsHandler(e:Event):void {
			var xml:XML = new XML(this.getLoader(FRIENDS).data);
			var userArray:Array = new Array();
            for each (var tempXML:XML in xml.children()) {
				var twitterUser:TwitterUser = new TwitterUser(tempXML);
                userArray.push(twitterUser);
            }
			var r:TwitterEvent = new TwitterEvent (TwitterEvent.ON_FRIENDS_RESULT);
			r.data = userArray;
			dispatchEvent (r);
		}
			
		private function friendsTimelineHandler(e:Event):void {
			var xml:XML = new XML(this.getLoader(FRIENDS_TIMELINE).data);
			var statusArray:Array = new Array();
            for each (var tempXML:XML in xml.children()) {
				var twitterStatus:TwitterStatus = new TwitterStatus (tempXML);
                statusArray.push(twitterStatus );
            }
			var r:TwitterEvent = new TwitterEvent (TwitterEvent.ON_FRIENDS_TIMELINE_RESULT);
			r.data = statusArray;
			dispatchEvent (r);
		}
		
		private function publicTimelineHandler(e:Event) :void{
			var xml:XML = new XML(this.getLoader(PUBLIC_TIMELINE).data);
			var statusArray:Array = new Array();
            for each (var tempXML:XML in xml.children()) {
				var twitterStatus:TwitterStatus = new TwitterStatus (tempXML);
                statusArray.push(twitterStatus );
            }
			var r:TwitterEvent = new TwitterEvent (TwitterEvent.ON_PUBLIC_TIMELINE_RESULT);
			r.data = statusArray;
			dispatchEvent (r);
		}
		
		private function userTimelineHandler(e:Event):void {
			var xml:XML = new XML(this.getLoader(USER_TIMELINE).data);
			var statusArray:Array = new Array();
            for each (var tempXML:XML in xml.children()) {
				var twitterStatus:TwitterStatus = new TwitterStatus (tempXML)
                statusArray.push(twitterStatus );
            }
			var r:TwitterEvent = new TwitterEvent (TwitterEvent.ON_USER_TIMELINE_RESULT);
			r.data = statusArray;
			dispatchEvent (r);
		}
		
		
		private function setStatusHandler (e : Event) : void{
			var r:TwitterEvent = new TwitterEvent (TwitterEvent.ON_SET_STATUS);
			r.data = "success";
			dispatchEvent (r);
		}
		
		private function friendCreatedHandler (e:Event) : void{
			trace("Friend created " + this.getLoader(FOLLOW_USER).data);
		}
		
		private function showStatusHandler(e:Event):void
		{
			var xml:XML = new XML(this.getLoader(SHOW_STATUS).data);
			var twitterStatus:TwitterStatus = new TwitterStatus(xml);
			var twitterEvent:TwitterEvent = new TwitterEvent(TwitterEvent.ON_SHOW_STATUS);
			twitterEvent.data = twitterStatus;
			dispatchEvent(twitterEvent);
		}
		
		private function repliesHandler(e:Event):void
		{
			var xml:XML = new XML(this.getLoader(REPLIES).data);
			var statusArray:Array = [];
			for each(var reply:XML in xml.children())
			{
				statusArray.push(new TwitterStatus(reply));
			}
			var twitterEvent:TwitterEvent = new TwitterEvent(TwitterEvent.ON_REPLIES);
			twitterEvent.data = statusArray;
			dispatchEvent(twitterEvent);
		}
		
		private function destroyHandler(e:Event):void
		{
			var r:TwitterEvent = new TwitterEvent (TwitterEvent.ON_DESOTRY);
			r.data = "success";
			dispatchEvent (r);
		}
		
		private function errorHandler (errorEvent : IOErrorEvent) : void
		{
			trace (errorEvent.text);
		}
		
		private function followersHandler(e:Event):void
		{			
			var xml:XML = new XML(this.getLoader(FOLLOWERS).data);
			var userArray:Array = new Array();
            for each (var tempXML:XML in xml.children()) {
				var twitterUser:TwitterUser = new TwitterUser(tempXML);
                userArray.push(twitterUser);
            }
			var r:TwitterEvent = new TwitterEvent (TwitterEvent.ON_FOLLOWERS);
			r.data = userArray;
			dispatchEvent (r);
		}
		
		private function featuredHandler(e:Event):void
		{
			var xml:XML = new XML(this.getLoader(FEATURED).data);
			var userArray:Array = new Array();
            for each (var tempXML:XML in xml.children()) {
				var twitterUser:TwitterUser = new TwitterUser(tempXML);
                userArray.push(twitterUser);
            }
			var r:TwitterEvent = new TwitterEvent (TwitterEvent.ON_FEATURED);
			r.data = userArray;
			dispatchEvent (r);
		}
		
		// private helper methods
		
		private function addLoader(name:String, completeHandler:Function):void
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, completeHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
			this.loaders[name] = loader;
		}
		
		private function getLoader(name:String):URLLoader
		{
			return this.loaders[name] as URLLoader;
		}
		
		private static function twitterRequest (URL : String):URLRequest
		{
			var r:URLRequest = new URLRequest (URL)
			return r;
		}
	}
}