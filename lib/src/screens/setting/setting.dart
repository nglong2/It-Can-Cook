import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/system_bloc.dart';
import 'package:it_can_cook/src/models/system/system.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  static const routeName = 'settings';

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemBloc, SystemModel>(
      builder: (context, state) {
        return Scaffold(
          body: ListView(children: [
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(S.of(context).language),
              trailing: // language picker widget

                  DropdownButton<String>(
                value: state.language,
                onChanged: (String? newValue) {
                  context.read<SystemBloc>().add(
                        ChangeLanguageEvent(
                          newValue!,
                        ),
                      );
                },
                items: <String>['en', 'vi']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value == 'en' ? 'English' : 'Tiếng Việt'),
                  );
                }).toList(),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.dark_mode_outlined),
              title: Text(S.of(context).theme),
              trailing: // theme switcher widget
                  Switch(
                value: state.themeMode == 'dark' ? true : false,
                onChanged: (value) {
                  context.read<SystemBloc>().add(
                        ChangeThemeEvent(
                          value ? 'dark' : 'light',
                        ),
                      );
                },
              ),
              onTap: () {
                // Navigate to the theme setting page
              },
            ),
            const Divider(),
            //logout button
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(S.of(context).logout),
              onTap: () {
                // Logout
              },
            ),
          ]),
        );
      },
    );
  }
}
