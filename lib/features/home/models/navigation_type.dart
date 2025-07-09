enum NavigationType {
  discover,
  search,
  bookmarks,
  profile;

  String get icon {
    switch (this) {
      case NavigationType.discover:
        return "assets/icons/ic_home_discover.svg";
      case NavigationType.search:
        return "assets/icons/ic_home_search.svg";
      case NavigationType.bookmarks:
        return "assets/icons/ic_home_bookmarks.svg";
      case NavigationType.profile:
        return "assets/icons/ic_home_profile.svg";
    }
  }
}
