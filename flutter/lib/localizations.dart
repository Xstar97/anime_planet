
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

class AppLocalizations {

  var _locals = ["en","ja"];

  List<Locale> getLocales(){
    var list = List<Locale>();
    for (var i=0; i<_locals.length; i++) {
      list.add(Locale(_locals[i]));
    }
    return list;
  }

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
    locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }


  title() => Intl.message(
    'Anime-Planet',
    name: "title",
    desc: "project title",
  );
  hello() => Intl.message(
    'Hello World',
    name: "hello",
    desc: "hello world message",
  );
  
  text(counter) => Intl.message(
    'You have pushed the button $counter times:',
    name: "text",
    args: [counter],
    desc: "Our Text to localize",
  );

}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations()._locals.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
