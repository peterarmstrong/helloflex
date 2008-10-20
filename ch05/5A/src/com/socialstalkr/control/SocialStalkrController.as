package com.socialstalkr.control {
  import com.adobe.cairngorm.control.FrontController;
  import com.socialstalkr.control.EventNames;
  import com.socialstalkr.command.ShowUserFriends;
  import com.socialstalkr.command.ShowUserTweets;
  import com.socialstalkr.command.ShowFriendTweets;
  import com.socialstalkr.command.LocateTweet;
  import com.socialstalkr.command.PostTweet;
  import com.socialstalkr.command.VerifyCredentials;
  
  public class SocialStalkrController extends FrontController {
    public function SocialStalkrController() {
      addCommand(EventNames.SHOW_USER_FRIENDS, ShowUserFriends);
      addCommand(EventNames.SHOW_USER_TWEETS, ShowUserTweets);
      addCommand(EventNames.SHOW_FRIEND_TWEETS, ShowFriendTweets);
      addCommand(EventNames.LOCATE_TWEET, LocateTweet);
      addCommand(EventNames.POST_TWEET, PostTweet);
      addCommand(EventNames.VERIFY_CREDENTIALS,
        VerifyCredentials);
    }
  }
}
