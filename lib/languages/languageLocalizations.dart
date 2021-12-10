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
      'profile': 'Profile',
      'username': 'Username',
      'date_selector': 'Date Selector',
      'cancel': 'Cancel',
      'book': 'Book'
    },
    'it': {
      'wallet': 'Portafoglio',
      'explore': 'Esplora',
      'profile': 'Profilo',
      'username': 'Utente',
      'date_selector': 'Seleziona Date',
      'cancel': 'Cancella',
      'book': 'Prenota'
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

  String get username {
    return _localizedValues[locale.languageCode]!['username']!;
  }

  String get date_selector {
    return _localizedValues[locale.languageCode]!['date_selector']!;
  }

  String get cancel {
    return _localizedValues[locale.languageCode]!['cancel']!;
  }

  String get book {
    return _localizedValues[locale.languageCode]!['book']!;
  }


}