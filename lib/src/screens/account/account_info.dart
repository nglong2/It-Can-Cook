import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/bloc/account_bloc.dart';
import 'package:it_can_cook/src/models/account.dart';

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

  Future<void> changePassword() async {
    //show poup have form to change password
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
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
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      //call api to change password
                    }
                  },
                  child: const Text('Change password'),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                title: const Text('Change password'),
                onTap: () {
                  changePassword();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
