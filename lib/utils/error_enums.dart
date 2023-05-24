enum PopularBooksError {
  networkError,
}

enum CategoriesError {
  networkError,
}

enum RecommendedBooksError {
  networkError,
}

enum WishListError {
  loadingListError,
  loadingStatusError,
  addingError,
  removingError,
}

enum BooksError {
  networkError,
}

enum BookDetailsError {
  networkError,
}

enum NotificationsError {
  networkError,
}

enum UnreadNotificationsError {
  networkError,
}

enum ProfileError {
  networkError,
}

enum NotificationsOptionError {
  loadingError,
  updatingError,
}

enum FAQError {
  networkError,
}

enum ReviewsError {
  loadingError,
  submittingError,
  invalidRate,
  fetchingAvatar,
}

enum SearchError {
  networkError,
}

enum RegisterError {
  networkError,
  emptyCategories,
  emptyName,
  emptyCountry,
  invalidPhoneNumber,
  uploadAvatarError,
  emptyBirthDay,
  emptyUsername,
  emptyEmail,
  shortPassword,
  nonMatchingPasswords,
}

enum AuthError {
  networkError,
  uploadProfileError,
  passwordsNotMatching,
}

enum EditProfileError {
  networkError,
  emptyName,
  emptyCountry,
  invalidPhoneNumber,
  uploadAvatarError,
  emptyBirthDay,
}

enum SearchHistoryError {
  loadingError,
  addingError,
  removingError,
  clearingError,
}
