import 'package:flutter/material.dart';

class LanguagePicker extends StatefulWidget {
  const LanguagePicker({super.key});

  @override
  LanguagePickerState createState() => LanguagePickerState();
}

class LanguagePickerState extends State<LanguagePicker> {
  String selectedLanguage = 'English';

  List<String> languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Italian',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedLanguage,
      onChanged: (String? newValue) {
        setState(() {
          selectedLanguage = newValue!;
        });
      },
      items: languages.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
