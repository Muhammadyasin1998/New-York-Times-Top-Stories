class ApiEndpoints {
  static const topStories = "/svc/topstories/v2";
  static String topStoriesSection(String section) =>
      "$topStories/$section.json";
  static const login = "/login";
  static const register = "/register";
  static const profile = "/profile";
  static const updateProfile = "/profile/update";
  static const resetPassword = "/password/reset";
  static const changePassword = "/password/change";
  static const logout = "/logout";
}
