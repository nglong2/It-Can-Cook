import 'dart:convert';
import 'package:it_can_cook/src/api/rest.dart';
import 'package:it_can_cook/src/models/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountController {
  final RestApi api = RestApi();

  Future<AccountModel?> login(String email, String password) async {
    var body = {
      'emailOrUserName': email,
      'password': password,
    };

    var value = await api.post("api/auth/login", body);

    if (value.statusCode == 200) {
      if (jsonDecode(value.body)["statusCode"] == 200) {
        var token = jsonDecode(value.body)["message"];
        var prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwtToken', token);
        return await getUserToken(token);
      }
      throw Exception(jsonDecode(value.body)["message"]);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<bool> register(String email, String password, String passwordConfirm,
      String firstName, String lastName, String phone) async {
    var data = {
      'email': email,
      'password': password,
      'confirmPassword': passwordConfirm,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone
    };
    var value = await api.post("api/auth/register", data);
    if (value.statusCode == 200) {
      if (jsonDecode(value.body)["statusCode"] == 200) {
        return true;
      }
      throw Exception(jsonDecode(value.body)["message"]);
    }

    if (value.statusCode != 200) {
      throw Exception('Failed to register');
    }
    return false;
  }

  Future<bool> sendEmail(String email, String code) async {
    var value = await api.get("api/auth/confirm-mail?Email=$email&Code=$code");
    if (value.statusCode == 200) {
      if (jsonDecode(value.body)["statusCode"] == 200) {
        return true;
      }
      throw Exception(jsonDecode(value.body)["message"]);
    }

    if (value.statusCode != 200) {
      throw Exception('Failed to send email');
    }
    return false;
  }

  Future<void> logout() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwtToken');
  }

  Future<bool> isLoggedIn() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('jwtToken');
    return token != null;
  }

  Future<AccountModel?> getUserToken(String jwt) async {
    var valueUser = await api.get("api/user/get-user-token?token=$jwt");
    if (valueUser.statusCode == 200) {
      if (jsonDecode(valueUser.body)["statusCode"] == 200) {
        return AccountModel.fromJson(jsonDecode(valueUser.body)["data"]);
      }
      throw Exception(jsonDecode(valueUser.body)["message"]);
    }
    return null;
  }
}
