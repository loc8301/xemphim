import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_text_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();

  final ImagePicker picker = ImagePicker();
  XFile? image;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      image = await picker.pickImage(source: ImageSource.gallery);
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: TColor.card,
                          borderRadius: BorderRadius.circular(media.width * 0.15),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 4))
                          ]),
                      child: image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(media.width * 0.15),
                              child: Image.file(
                                File(image!.path),
                                width: media.width * 0.18,
                                height: media.width * 0.18,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(media.width * 0.15),
                              child: Image.asset(
                                "assets/img/user_placeholder.png",
                                width: media.width * 0.18,
                                height: media.width * 0.18,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Thêm ảnh đại diện",
                    style: TextStyle(
                        color: TColor.text,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              RoundTextField(
                title: "TÊN",
                hintText: "tên của bạn",
                controller: txtFirstName, onChanged: (String query) {  },
              ),
              const SizedBox(
                height: 20,
              ),
              RoundTextField(
                title: "HỌ",
                hintText: "họ của bạn",
                controller: txtLastName, onChanged: (String query) {  },
              ),
              const SizedBox(
                height: 20,
              ),
              RoundTextField(
                title: "EMAIL",
                hintText: "email của bạn",
                keyboardType: TextInputType.emailAddress,
                controller: txtEmail, onChanged: (String query) {  },
              ),
              const SizedBox(
                height: 20,
              ),
              RoundTextField(
                title: "MẬT KHẨU",
                hintText: "mật khẩu của bạn",
                obscureText: true,
                controller: txtPassword, onChanged: (String query) {  },
              ),
              const SizedBox(
                height: 20,
              ),
              RoundTextField(
                title: "XÁC NHẬN MẬT KHẨU",
                hintText: "xác nhận mật khẩu của bạn",
                obscureText: true,
                controller: txtConfirmPassword, onChanged: (String query) {  },
              ),
              const SizedBox(
                height: 30,
              ),
              RoundButton(
                title: "ĐĂNG KÝ",
                onPressed: () {
                  // Validate text fields before registering the user
                  String validationMessage = validateFields();
                  if (validationMessage.isEmpty) {
                    registerUser(context);
                  } else {
                    // Show an error message if validation fails
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(validationMessage),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
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

  // Function to validate text fields
  String validateFields() {
    if (txtFirstName.text.isEmpty) {
      return 'Tên không được để trống.';
    } else if (txtLastName.text.isEmpty) {
      return 'Họ không được để trống.';
    } else if (txtEmail.text.isEmpty) {
      return 'Email không được để trống.';
    } else if (txtPassword.text.isEmpty) {
      return 'Mật khẩu không được để trống.';
    } else if (txtConfirmPassword.text.isEmpty) {
      return 'Xác nhận mật khẩu không được để trống.';
    } else {
      return ''; // Tất cả các trường đã được điền
    }
  }

  Future<void> registerUser(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: txtEmail.text,
        password: txtPassword.text,
      );

      // Lưu ảnh người dùng vào Firebase Storage và lấy URL
      String imageUrl = await uploadImage(userCredential.user!.uid);

      // Lưu thông tin người dùng vào Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'firstName': txtFirstName.text,
        'lastName': txtLastName.text,
        'email': txtEmail.text,
        'imageUrl': imageUrl,
        // Thêm các trường khác nếu cần
      });

      // Show success message using SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đăng ký thành công !'),
          duration: Duration(seconds: 2),
        ),
      );

      print('Đăng ký thành công: ${userCredential.user?.uid}');
    } catch (e) {
      // Xử lý lỗi đăng ký
      print('Lỗi đăng ký: $e');
      // Show error message using SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đăng ký thất bại. Vui lòng thử lại.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<String> uploadImage(String userId) async {
    try {
      if (image != null) {
        // Tạo reference đến Firebase Storage với đường dẫn cụ thể
        Reference storageReference = _storage.ref().child('profile_images/$userId.jpg');

        // Upload ảnh lên Firebase Storage
        await storageReference.putFile(File(image!.path));

        // Lấy URL của ảnh vừa upload
        String downloadURL = await storageReference.getDownloadURL();

        return downloadURL;
      } else {
        // Nếu không có ảnh, trả về một giá trị mặc định hoặc empty string
        return 'default_image_url'; // hoặc ''
      }
    } catch (e) {
      // Xử lý lỗi upload ảnh
      print('Lỗi upload ảnh: $e');
      return ''; // hoặc một giá trị mặc định
    }
  }
}
