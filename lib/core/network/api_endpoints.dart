class ApiEndpoints {
  static const topStories = "/svc/topstories/v2";
  static String topStoriesSection(String section) =>
      "$topStories/$section.json";
}
