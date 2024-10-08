import 'dart:convert';
import '../vo/user.dart';
import 'package:http/http.dart' as http;

class UserHttp {
  static const String apiUrl = 'http://13.125.57.206:8080/my_busan_log/api/user';

  // 회원가입 이메일 존재 여부 검사 (나현 추가)
  static Future<User?> findUserByEmail(String u_email) async {
    var uri = Uri.parse('$apiUrl/findbymail').replace(queryParameters: {
      'u_email': u_email,
    });

    final response = await http.get(uri);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      // 응답이 성공일 경우 JSON을 User 객체로 변환
      final Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
      return User.fromJson(json);
    } else {
      // 에러 처리
      print('사용자를 찾을 수 없습니다: ${response.statusCode}');
      return null;
    }
  }

  // 회원탈퇴 수진추가
  static Future<bool> unjoin(int u_idx, String u_pw) async {
    var uri = Uri.parse('$apiUrl/unjoin1').replace(queryParameters: {
      'u_idx': u_idx.toString(),
      'u_pw': u_pw,
    });

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseBody = response.body.trim();
      if (responseBody == 'ok') { // 응답 메시지 확인
        return true;
      } else {
        print('서버 응답 메시지: $responseBody');
        return false;
      }
    } else {
      print('HTTP 오류: ${response.statusCode}');
      print('서버 응답 본문: ${response.body}');
      return false;
    }
  }

  // 비밀번호 변경 메서드 수진추가
  static Future<bool> updatePw(int u_idx, String currentPassword, String newPassword) async {
    var uri = Uri.parse('$apiUrl/updatePw').replace(queryParameters: {
      'u_idx': u_idx.toString(),
      'current_password': currentPassword,
      'new_password': newPassword,
    });
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final responseBody = response.body;
      if (responseBody == '비밀번호 변경 완료') {
        return true;
      } else {
        print('서버 응답 메시지: $responseBody');
        return false;
      }
    } else {
      print('HTTP 오류: ${response.statusCode}');
      print('서버 응답 본문: ${response.body}');
      return false;
    }
  }

  //회원정보수정 수진추가
  static Future<User> updateUser(User user) async {
    var uri = Uri.parse('$apiUrl/updateUserApp').replace(queryParameters: {
      'u_idx': user.u_idx.toString(),
      'u_img_url': user.u_img_url.toString(),
      'u_name': user.u_name.toString(),
      'u_nick': user.u_nick.toString(),
      'u_birth': user.u_birth.toString(),
      'u_p_number': user.u_p_number.toString(),
      'u_address': user.u_address.toString(),
      'trip_preference': user.trip_preference.toString(),
      'business_license': ''.toString(),
    });
    var response = await http.post(uri);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      // 응답이 JSON 형식으로 변환될 수 있도록 수정
      final Map<String, dynamic> json = jsonDecode(response.body);
      User u = User.fromJson(json);
      return u;
    } else {
      throw Exception('프로필 수정 중 오류 발생: ${response.body}');
    }
  }

  static Future<User?> findUser(int u_idx) async {
    final url = Uri.parse('$apiUrl/findbyidx?u_idx=$u_idx'); // u_idx를 URL에 추가
    print('$apiUrl/findbyidx?u_idx=$u_idx');
    final response = await http.get(url); // GET 요청 보내기
    print(response.body);
    if (response.statusCode == 200) {
      // 응답이 성공일 경우 JSON을 User 객체로 변환
      final Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
      return User.fromJson(json);
    } else {
      // 에러 처리
      print('Failed to load user: ${response.statusCode}');
      return null;
    }
  }
  // 회원가입
  static Future<User> registerUser(User user) async {
    print('1234');
    print({
      'u_email': user.u_email.toString(),
      'u_pw': user.u_pw.toString(),
      'u_name': user.u_name.toString(),
      'u_img_url': user.u_img_url.toString(),
      'u_nick': user.u_nick.toString(),
      'u_birth': user.u_birth.toString(),
      'u_p_number': user.u_p_number.toString(),
      'u_address': user.u_address.toString(),
      'trip_preference': user.trip_preference.toString(),
      'business_license': ''.toString(),
    });
    var uri = Uri.parse('$apiUrl/save').replace(queryParameters: {
      'login_provider': user.login_provider.toString(),
      'u_email': user.u_email.toString(),
      'u_pw': user.u_pw.toString(),
      'u_name': user.u_name.toString(),
      'u_img_url': user.u_img_url.toString(),
      'u_nick': user.u_nick.toString(),
      'u_birth': user.u_birth.toString(),
      'u_p_number': user.u_p_number.toString(),
      'u_address': user.u_address.toString(),
      'trip_preference': user.trip_preference.toString(),
      'business_license': ''.toString(),
    });
    var response = await http.post(uri);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      return User();
    }
  }
  // 로그인
  static Future<User> loginUser(User user) async {
    print('1234');
    var uri = Uri.parse('$apiUrl/login').replace(queryParameters: {
      'u_email': user.u_email.toString(),
      'u_pw': user.u_pw.toString(),
    });
    var response = await http.post(uri);
    print('9876=====================================================');
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes))); // JSON을 User 객체로 변환
    } else {
      return User();
    }
  }
  // kakao 회원가입
  static Future<User> kakaoRegisterUser({required User user}) async {
    print('1234');
    print({
      'u_email': user.u_email.toString(),
      'u_pw': '1234'.toString(),
      'u_name': user.u_name.toString(),
      'u_img_url': user.u_img_url.toString(),
      'u_nick': user.u_nick.toString(),
      'u_birth': user.u_birth.toString(),
      'u_p_number': user.u_p_number.toString(),
      'u_address': ''.toString(),
      'trip_preference': '3'.toString(),
      'business_license': ''.toString(),
      'login_provider': 'kakao'.toString(),
    });
    var uri = Uri.parse('$apiUrl/save').replace(queryParameters: {
      'u_email': user.u_email.toString(),
      'u_pw': '1234'.toString(),
      'u_name': user.u_name.toString(),
      'u_img_url': user.u_img_url.toString(),
      'u_nick': user.u_nick.toString(),
      'u_birth': user.u_birth.toString(),
      'u_p_number': user.u_p_number.toString(),
      'u_address': ''.toString(),
      'trip_preference': '3'.toString(),
      'business_license': ''.toString(),
      'login_provider': 'kakao'.toString(),
    });
    var response = await http.post(uri);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      return User();
    }
  }
  // kakao 로그인
  static Future<User> kakaoLoginUser(User user) async {
    print('1234');
    print({
      "sns_id": user.u_email.toString(),
      "login_provider": user.login_provider.toString(),
    });
    var uri = Uri.parse('$apiUrl/loginWithSNS').replace(queryParameters: {
      "sns_id": user.u_email.toString(),
      "login_provider": user.login_provider.toString(),
    });
    var response = await http.post(uri);
    print('9876=====================================================');
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return User();
    }
  }
}