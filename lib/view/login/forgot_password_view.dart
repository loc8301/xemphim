import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_text_field.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  TextEditingController txtEmail = TextEditingController();
TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 100,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/img/back_btn.png",
                  width: 13,
                  height: 13,
                  color: TColor.subtext,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "BACK",
                  style: TextStyle(
                      color: TColor.subtext,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: TColor.bg,
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColor.primary1,
        onPressed: () {
          TColor.tModeDark = !TColor.tModeDark;
          if (mounted) {
            setState(() {});
          }
        },
        child: Icon(
          TColor.tModeDark ? Icons.light_mode : Icons.dark_mode,
          color: TColor.text,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: media.width * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: media.width,
                height: media.width * 0.5,
                alignment: const Alignment(0, 0.5),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Image.asset(
                    "assets/img/app_logo.png",
                    width: media.width * 0.30,
                    height: media.width * 0.30,
                  ),
                ),
              ),
              Text(
                "QUÊN MẬT KHẨU?",
                style: TextStyle(
                    color: TColor.text,
                    fontSize: 13,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Nhập địa chỉ email bạn đã sử dụng để\n tạo tài khoản và chúng tôi sẽ gửi email\ncho bạn về liên kết đặt lại mật khẩu.",
                textAlign: TextAlign.center,
                style: TextStyle(color: TColor.subtext, fontSize: 15),
              ),
              const SizedBox(
                height: 30,
              ),
              RoundTextField(
                title: "EMAIL",
                hintText: "địa chỉ email",
                keyboardType: TextInputType.emailAddress,
                controller: txtEmail, onChanged: (String query) {  },
              ),
              const SizedBox(
                height: 20,
              ),
              RoundButton(
                title: "GỬI EMAIL",
                onPressed: () {
                  sendPasswordResetEmail();
                },
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendPasswordResetEmail() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: txtEmail.text);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Chúng tôi đã gửi một email đặt lại mật khẩu đến ${txtEmail.text}. Vui lòng kiểm tra hộp thư của bạn.'),
          duration: Duration(seconds: 5),
        ),
      );
    } catch (e) {
      print('Lỗi gửi email đặt lại mật khẩu: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gửi email đặt lại mật khẩu thất bại. Vui lòng thử lại.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
