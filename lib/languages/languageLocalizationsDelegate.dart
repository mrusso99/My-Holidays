import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'languageLocalizations.dart';

class DemoLocalizationsDelegate
    extends LocalizationsDelegate<LanguageLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => LanguageLocalizations.languages().contains(locale.languageCode);


  @override
  Future<LanguageLocalizations> load(Locale locale) {
    return SynchronousFuture<LanguageLocalizations>(LanguageLocalizations(locale));
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}