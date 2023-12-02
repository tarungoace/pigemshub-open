

enum PiAnalyticsEnum{

  ///Authentication Event
  emailSignup, // to be called when user signups through email
  numberSignup,
  googleAuthSignup,

  emailLogin,
  numberLogin,
  googleLogin,
  termsOfServiceCheckbox,
  termsOfServiceLink,

  forgotPassword,

  ///features of app
  sortChipPressed,

  deactivateAccount,
  deleteAccount,
  accountUpdate,
  logout,

  ///Safety Event
  reportUser, // recheck
  blockUser,

  ///User event
  addFavorite,
  removeFavorite,

  productDetailScreen,
  productEditScreen,

  ///NavigationEvent
  bottomNavigationEvent,
  homeScreen,
  profileScreen,
  checkoutScreen,

}


enum AnalyticsServicesEnum {
  firebase,
  inviteReferral,
}
