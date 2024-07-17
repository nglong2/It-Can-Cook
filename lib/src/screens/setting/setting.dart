import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/account_bloc/account_bloc.dart';
import 'package:it_can_cook/src/bloc/system_bloc/system_bloc.dart';
import 'package:it_can_cook/src/screens/account/account_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> changePassword() async {
    //show poup have form to change password
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final systemState = context.watch<SystemBloc>().state;
        final accountState = context.watch<AccountBloc>()?.state;
        return Scaffold(
          body: ListView(children: [
            ListTile(
              leading: const Icon(Icons.person),
              title:
                  Text('${accountState?.firstName} ${accountState?.lastName}'),
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  scrollControlDisabledMaxHeightRatio: 0.5,
                  showDragHandle: true,
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: const AccountInfoScreen(),
                    );
                  },
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(S.of(context).language),
              trailing: // language picker widget

                  DropdownButton<String>(
                value: systemState.language,
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
                value: systemState.themeMode == 'dark' ? true : false,
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
              onTap: () async {
                // Logout shared preferences
                //show confirmation dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(S.of(context).logout),
                      content: Text(S.of(context).logoutConfirmation),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(S.of(context).cancel),
                        ),
                        TextButton(
                          onPressed: () async {
                            var prefs = await SharedPreferences.getInstance();
                            await prefs.remove('jwtToken');
                            if (accountState?.email != null) {
                              context.read<AccountBloc>().add(LogOutEvent());
                            }
                            await Navigator.of(context).pushNamedAndRemoveUntil(
                                'login', (Route<dynamic> route) => false);
                          },
                          child: Text(S.of(context).logout),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ]),
        );
      },
    );
  }
}
