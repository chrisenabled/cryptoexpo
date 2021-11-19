

class CoinCommunityData{
  final num? facebookLikes;
  final num? twitterFollowers;
  final num? redditAveragePosts48h;
  final num? redditAverageComments48h;
  final num? redditSubscribers;
  final num? redditAccountsActive48h;
  final num? telegramChannelUserCount;

  CoinCommunityData({
    this.facebookLikes,
    this.twitterFollowers,
    this.redditAveragePosts48h,
    this.redditAverageComments48h,
    this.redditSubscribers,
    this.redditAccountsActive48h,
    this.telegramChannelUserCount
  });

  static CoinCommunityData fromJson(dynamic _json) {
    final json = _json as Map<String, dynamic>;
    return CoinCommunityData(
      facebookLikes: json['facebook_likes'],
      twitterFollowers: json['twitter_followers'],
      redditAveragePosts48h: json['reddit_average_posts_48h'],
      redditAverageComments48h: json['reddit_average_comments_48h'],
      redditSubscribers: json['reddit_subscribers'],
      redditAccountsActive48h: json['reddit_accounts_active_48h'],
      telegramChannelUserCount: json['telegram_channel_user_count'],
    );
  }
}