import 'package:flutter/material.dart';


class LanguageLocalizations {
  LanguageLocalizations(this.locale);

  final Locale locale;

  static LanguageLocalizations of(BuildContext context) {
    return Localizations.of<LanguageLocalizations>(context, LanguageLocalizations)!;
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'wallet': 'Wallet',
      'explore': 'Explore',
      'profile': 'Profilo',
    },
    'it': {
      'wallet': 'Portafoglio',
      'explore': 'Esplora',
      'profile': 'Profilo',
    },
  };

  static List<String> languages ()=> _localizedValues.keys.toList();

  String get wallet {
    return _localizedValues[locale.languageCode]!['wallet']!;
  }

  String get explore {
    return _localizedValues[locale.languageCode]!['explore']!;
  }

  String get profile {
    return _localizedValues[locale.languageCode]!['profile']!;
  }


}