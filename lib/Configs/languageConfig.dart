import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LanguageConfig extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'Welcome!': 'Welcome to Hello Chat',
          'Go': 'Logout',
        },
        'si_LK': {
          'Welcome!': 'Hello Chat වෙත සාදරයෙන් පිළිගනිමු',
          'Go': 'ඉවත්වන්න',
        },
      };
}
