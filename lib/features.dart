class Features {
  /// if true it will use mock images from assets,
  /// if false it will the images from it's correct source
  static const isMockImages = false;

  /// If true it will show error for all network requests,
  /// if false it will load everything normally, this's for mock purposes.
  static const isMockErrors = false;

  /// If true it will show empty lists for all loading requests,
  /// if false it will load everything normally, this's for mock purposes.
  /// If isMockErrors is true, and isEmptyLists is true, it will show errors.
  static const isEmptyLists = false;
}
