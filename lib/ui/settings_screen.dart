// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
import 'package:my_holidays/theme/theme_model.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

/// This is the private State class that goes with MainScreen.
class _SettingsScreenState extends State<SettingsScreen> {

  final List locale =[
    {'name':'English','locale': const Locale('en')},
    {'name':'Italiano', 'locale': const Locale('it')}
  ];
  updateLanguage(Locale locale){
    Get.back();
    Get.updateLocale(locale);
  }

  buildLanguageDialog(BuildContext context){
    showDialog(context: context,
        builder: (builder){
          return AlertDialog(
            title: Text(LanguageLocalizations.of(context).changelanguage),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(child: Text(locale[index]['name']),onTap: (){
                        print(locale[index]['name']);
                        updateLanguage(locale[index]['locale']);
                      },),
                    );
                  }, separatorBuilder: (context,index){
                return const Divider(
                  color: Colors.blueGrey,
                );
              }, itemCount: locale.length
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('GoFelix'),
              systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
              elevation: 0,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SwitchListTile(
                    title: Text(
                      LanguageLocalizations.of(context).darktheme,
                    ),
                    activeColor: Colors.blueAccent,
                    value: themeNotifier.isDark,
                    onChanged: (value) {
                      themeNotifier.isDark
                          ? themeNotifier.isDark = false
                          : themeNotifier.isDark = true;
                    }),
                ListTile(
                    title: Text(
                        LanguageLocalizations.of(context).changelanguage,
                      textAlign: TextAlign.left,
                    ),
                    subtitle: Text(
                      LanguageLocalizations.of(context).language,
                      style: const TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                    onTap: (){
                      buildLanguageDialog(context);
                    }),
              ],
            ),
          );
        }
        );
  }
}