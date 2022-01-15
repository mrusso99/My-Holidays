import 'package:flutter/material.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';

class SearchBar extends StatelessWidget {
  SearchBar({Key? key}) : super(key: key);

  final TextEditingController _searchControl = TextEditingController();
  final _focusEmail = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _focusEmail.unfocus();
        },
        child: TextField(
        focusNode: _focusEmail,
        style: const TextStyle(
          fontSize: 15.0,
        ),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20,10,20,10),
          fillColor: Colors.grey.withOpacity(0.1),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(246, 135, 30, 1), width: 1,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintText: (LanguageLocalizations.of(context).whereyougo + '?'),
          prefixIcon: const Icon(
            Icons.search,
            color: Color.fromRGBO(13, 78, 161, 1),
          ),
          hintStyle: const TextStyle(
            fontSize: 15.0,
          ),
        ),
        maxLines: 1,
        controller: _searchControl,
      )
    );
  }
}
