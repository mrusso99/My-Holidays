// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_holidays/ui/smart_services.dart';

class LanguageLocalizations {
  LanguageLocalizations(this.locale);

  final Locale locale;

  static LanguageLocalizations of(BuildContext context) {
    return Localizations.of<LanguageLocalizations>(
        context, LanguageLocalizations)!;
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'wallet': 'Wallet',
      'explore': 'Explore',
      'profile': 'Profile',
      'username': 'Username',
      'forgotpassword': 'Forgot password',
      'emailrecovery':
          'Insert your email. We will send you instructions to reset your password',
      'send': 'Send',
      'confirm': 'Confirm',
      'signup': 'Sign Up',
      'account': 'Do you already have an account',
      'signin': 'Sign In',
      'newaccount': 'Create a new account',
      'settings': 'Settings',
      'darktheme': 'Dark Theme',
      'attention': 'Attention',
      'textattention': 'You must log in first',
      'delete': 'Delete',
      'whereyougo': 'Where are you going',
      'texthome': 'Your personal and smart experience during your stay',
      'language': 'English',
      'changelanguage': 'Language',
      'date_selector': 'Date Selector',
      'cancel': 'Cancel',
      'book': 'Book',
      'roomControl': 'Room Control',
      'smartServices': "Smart Services",
      'name': "Name",
      'surname': "Surname",
      'textSelected': "Chosen for you",
      'showRooms': "Show Rooms",
      'nights': "Nights",
      'yourStay': "Your Stay",
      'moreDetails': "more details",
      'lessDetails': "less details",
      'startingfrom': 'from',
      'startPrice': "\$ var_price per person by night",
      'maxBusy': " max people ",
      'lights': "LIGHTS",
      'smart_lock': "SMART LOCK",
      'temperature': "TEMPERATURE",
      'breakfast': "BREAKFAST",
      'hour_breakfast': "What time do you \nwant to have \nbreakfast? :",
      'selected_hour': "Select hour",
      'drinks': "Drinks",
      'special_request': "Special Requests",
      'taxi': "TAXI",
      'restaurant': "RESTAURANT",
    },
    'it': {
      'wallet': 'Portafoglio',
      'explore': 'Esplora',
      'profile': 'Profilo',
      'username': 'Utente',
      'forgotpassword': 'Hai dimenticato la password',
      'emailrecovery':
          'Inserisci la tua email. Ti invieremo le istruzioni per reimpostare la tua password',
      'send': 'Invia',
      'confirm': 'Conferma',
      'signup': 'Registra',
      'account': 'Hai già un account',
      'signin': 'Login',
      'newaccount': 'Crea un nuovo account',
      'settings': 'Impostazioni',
      'darktheme': 'Tema Scuro',
      'attention': 'Attenzione',
      'textattention': 'Devi prima accedere',
      'delete': 'Annulla',
      'whereyougo': 'Dove vuoi andare',
      'texthome':
          'La tua esperienza personale e intelligente durante il tuo soggiorno',
      'language': 'Italiano',
      'changelanguage': 'Lingua',
      'date_selector': 'Seleziona Date',
      'cancel': 'Cancella',
      'book': 'Prenota',
      'roomControl': 'Gestione camera',
      'smartServices': 'Servizi Smart',
      'name': "Nome",
      'surname': "Cognome",
      'textSelected': "Selezionati per te",
      'showRooms': "Seleziona Camere",
      'nights': "Notti",
      'yourStay': "Il tuo soggiorno",
      'moreDetails': "più dettagli",
      'lessDetails': "meno dettagli",
      'startingfrom': 'da',
      'startPrice': "var_price € per persona a notte",
      'maxBusy': " massimo di persone ",
      'lights': "LUCI",
      'smart_lock': "SMART LOCK",
      'temperature': "TEMPERATURA",
      'breakfast': "COLAZIONE",
      'hour_breakfast': "A che ora vuoi \nfare colazione? :",
      'drinks': "Bevande",
      'special:request': "Richieste Speciali",
      'selected_hour': "Seleziona l'orario",
      'taxi': "TAXI",
      'restaurant': "RISTORANTE",
    },
  };

  static List<String> languages() => _localizedValues.keys.toList();

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

  String get forgotpassword {
    return _localizedValues[locale.languageCode]!['forgotpassword']!;
  }

  String get emailrecovery {
    return _localizedValues[locale.languageCode]!['emailrecovery']!;
  }

  String get send {
    return _localizedValues[locale.languageCode]!['send']!;
  }

  String get confirm {
    return _localizedValues[locale.languageCode]!['confirm']!;
  }

  String get signup {
    return _localizedValues[locale.languageCode]!['signup']!;
  }

  String get account {
    return _localizedValues[locale.languageCode]!['account']!;
  }

  String get signin {
    return _localizedValues[locale.languageCode]!['signin']!;
  }

  String get newaccount {
    return _localizedValues[locale.languageCode]!['newaccount']!;
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

  String get settings {
    return _localizedValues[locale.languageCode]!['settings']!;
  }

  String get darktheme {
    return _localizedValues[locale.languageCode]!['darktheme']!;
  }

  String get attention {
    return _localizedValues[locale.languageCode]!['attention']!;
  }

  String get textattention {
    return _localizedValues[locale.languageCode]!['textattention']!;
  }

  String get delete {
    return _localizedValues[locale.languageCode]!['delete']!;
  }

  String get whereyougo {
    return _localizedValues[locale.languageCode]!['whereyougo']!;
  }

  String get texthome {
    return _localizedValues[locale.languageCode]!['texthome']!;
  }

  String get language {
    return _localizedValues[locale.languageCode]!['language']!;
  }

  String get changelanguage {
    return _localizedValues[locale.languageCode]!['changelanguage']!;
  }

  String get roomControl {
    return _localizedValues[locale.languageCode]!['roomControl']!;
  }

  String get SmartServices {
    return _localizedValues[locale.languageCode]!['smartServices']!;
  }

  String get name {
    return _localizedValues[locale.languageCode]!['name']!;
  }

  String get surname {
    return _localizedValues[locale.languageCode]!['surname']!;
  }

  String get textSelected {
    return _localizedValues[locale.languageCode]!['textSelected']!;
  }

  String get showRooms {
    return _localizedValues[locale.languageCode]!['showRooms']!;
  }

  String get nights {
    return _localizedValues[locale.languageCode]!['nights']!;
  }

  String get yourStay {
    return _localizedValues[locale.languageCode]!['yourStay']!;
  }

  String get moreDetails {
    return _localizedValues[locale.languageCode]!['moreDetails']!;
  }

  String get lessDetails {
    return _localizedValues[locale.languageCode]!['lessDetails']!;
  }

  String get startPrice {
    return _localizedValues[locale.languageCode]!['startPrice']!;
  }

  String get maxBusy {
    return _localizedValues[locale.languageCode]!['maxBusy']!;
  }

  String get startingfrom {
    return _localizedValues[locale.languageCode]!['startingfrom']!;
  }

  String get lights {
    return _localizedValues[locale.languageCode]!['lights']!;
  }

  String get temperature {
    return _localizedValues[locale.languageCode]!['temperature']!;
  }

  // ignore: non_constant_identifier_names
  String get smart_lock {
    return _localizedValues[locale.languageCode]!['smart_lock']!;
  }

  String get breakfast {
    return _localizedValues[locale.languageCode]!['breakfast']!;
  }

  String get taxi {
    return _localizedValues[locale.languageCode]!['taxi']!;
  }

  String get restaurant {
    return _localizedValues[locale.languageCode]!['restaurant']!;
  }

  String get hour_breakfast {
    return _localizedValues[locale.languageCode]!['hour_breakfast']!;
  }

  String get drinks {
    return _localizedValues[locale.languageCode]!['drinks']!;
  }

  String get special_request {
    return _localizedValues[locale.languageCode]!['special_request']!;
  }

  String get selected_hour {
    return _localizedValues[locale.languageCode]!['selected_hour']!;
  }
}
