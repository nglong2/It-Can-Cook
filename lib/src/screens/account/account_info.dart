import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/account_bloc/account_bloc.dart';
import 'package:it_can_cook/src/bloc/system_bloc/system_bloc.dart';
import 'package:it_can_cook/src/controller/account.dart';
import 'package:it_can_cook/src/models/account/account.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  AccountInfoScreenState createState() => AccountInfoScreenState();
}

class AccountInfoScreenState extends State<AccountInfoScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordConfirmController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _oldPasswordController.text = '';
    _newPasswordController.text = '';
    _newPasswordConfirmController.text = '';
    super.initState();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordConfirmController.dispose();
    super.dispose();
  }

  Future<void> changePassword(String id) async {
    //show poup have form to change password
    showDialog(
      context: context,
      builder: (context) {
        return LoaderOverlay(
            child: AlertDialog(
          title: Text(S.of(context).change_password),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _oldPasswordController,
                  obscureText: true,
                  decoration:
                      InputDecoration(labelText: S.of(context).old_password),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).please_enter_old_password;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: true,
                  decoration:
                      InputDecoration(labelText: S.of(context).new_password),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).please_enter_new_password;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _newPasswordConfirmController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: S.of(context).confirm_new_password),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).please_enter_confirm_password;
                    }
                    if (value != _newPasswordController.text) {
                      return S.of(context).password_not_match;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  width: 20,
                  height: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.loaderOverlay.show();
                      AccountController()
                          .changePassword(
                        id,
                        _oldPasswordController.text,
                        _newPasswordController.text,
                        _newPasswordConfirmController.text,
                      )
                          .then((value) {
                        context.loaderOverlay.hide();
                        if (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(S.current.change_password_success),
                            ),
                          );
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        }
                      }).onError((error, stackTrace) {
                        context.loaderOverlay.hide();
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text(S.current.error),
                                  content: Text(error.toString()),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(S.current.yes),
                                    )
                                  ],
                                ));
                      });
                    }
                  },
                  child: Text(S.current.change_password),
                )
              ],
            ),
          ),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var systemState = context.watch<SystemBloc>().state;
    var systemContext = context.watch<SystemBloc>();
    return BlocBuilder<AccountBloc, AccountModel?>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: Text('${state?.firstName} ${state?.lastName}'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.email),
                title: Text(state?.email ?? ''),
              ),
              const Divider(),

              ListTile(
                leading: const Icon(Icons.person),
                title: Row(
                  children: [
                    Text(S.current.numberperoninhouse),
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownButton<int>(
                      value: systemState.numberPersonInHouse,
                      onChanged: (newValue) {
                        systemContext
                            .add(ChangeNumberPersonInHouseEvent(newValue ?? 1));
                      },
                      items: List.generate(10, (index) {
                        return DropdownMenuItem<int>(
                          value: index + 1,
                          child: Text((index + 1).toString()),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              const Divider(),
              ListTile(
                leading: const Icon(Icons.phone),
                title: Text(state?.phone ?? ''),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: Text(state?.address ?? ''),
              ),
              const Divider(),
              //change password
              ListTile(
                leading: const Icon(Icons.lock),
                title: Text(S.current.change_password),
                onTap: () {
                  changePassword(state?.id ?? '');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
