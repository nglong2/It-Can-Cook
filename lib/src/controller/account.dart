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
    }
    if (value.statusCode == 405) {
      throw Exception("emailnotconfirm");
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

// curl -X 'PUT' \
//   'https://api.wemealkit.shop/api/auth/reset-password' \
//   -H 'accept: */*' \
//   -H 'Content-Type: application/json' \
//   -d '{
//   "id": "string",
//   "oldPassword": "string",
//   "newPassword": "string",
//   "confirmPassword": "string"
// }'

  Future<bool> changePassword(String id, String oldPassword, String newPassword,
      String confirmPassword) async {
    var data = {
      'id': id,
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword
    };
    var value = await api.put("api/auth/reset-password", data);
    if (value.statusCode == 200) {
      if (jsonDecode(value.body)["statusCode"] == 200) {
        return true;
      }
      throw Exception(jsonDecode(value.body)["message"]);
    }

    if (value.statusCode != 200) {
      throw Exception('Failed to change password');
    }
    return false;
  }

  Future<bool> forgotPassword(String email) async {
    var data = {
      'email': email,
    };
    var value = await api.post("api/auth/forgot-password", data);
    if (value.statusCode == 200) {
      if (jsonDecode(value.body)["statusCode"] == 200) {
        return true;
      }
      throw Exception(jsonDecode(value.body)["message"]);
    }

    if (value.statusCode != 200) {
      throw Exception('Failed to forgot password');
    }
    return false;
  }

  Future<bool> resetPassword(String email, String code, String newPassword,
      String confirmPassword) async {
    var data = {
      'email': email,
      'code': code,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword
    };
    var value = await api.post("api/auth/reset-password", data);
    if (value.statusCode == 200) {
      if (jsonDecode(value.body)["statusCode"] == 200) {
        return true;
      }
      throw Exception(jsonDecode(value.body)["message"]);
    }

    if (value.statusCode != 200) {
      throw Exception('Failed to reset password');
    }
    return false;
  }
}
