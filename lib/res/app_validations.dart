class AppValidations {
  // Character limit constants
  static const int experienceDescriptionMaxLength = 250;

  // Word limit constants
  static const int questionTextMaxWords = 600;

  static bool isCharacterLimitExceeded(String text, int maxLength) {
    return text.length > maxLength;
  }

  static String truncateToMaxLength(String text, int maxLength) {
    if (text.length > maxLength) {
      return text.substring(0, maxLength);
    }
    return text;
  }

  static String getCharacterCountText(int currentLength, int maxLength) {
    return '$currentLength/$maxLength';
  }

  static bool isApproachingLimit(
    int currentLength,
    int maxLength, {
    int warningThreshold = 230,
  }) {
    return currentLength > warningThreshold;
  }

  // Word limit validation methods
  static int getWordCount(String text) {
    if (text.trim().isEmpty) {
      return 0;
    }
    return text.trim().split(RegExp(r'\s+')).length;
  }

  static bool isWordLimitExceeded(String text, int maxWords) {
    return getWordCount(text) > maxWords;
  }

  static String truncateToMaxWords(String text, int maxWords) {
    final words = text.trim().split(RegExp(r'\s+'));
    if (words.length > maxWords) {
      return words.take(maxWords).join(' ');
    }
    return text;
  }

  static String getWordCountText(int currentWords, int maxWords) {
    return '$currentWords/$maxWords';
  }

  static bool isApproachingWordLimit(
    int currentWords,
    int maxWords, {
    int warningThreshold = 550,
  }) {
    return currentWords > warningThreshold;
  }
}
