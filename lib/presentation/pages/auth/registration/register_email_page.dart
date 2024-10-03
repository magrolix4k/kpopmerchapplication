import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kpopmerchapplication/presentation/controllers/auth_controller.dart';
import 'package:kpopmerchapplication/presentation/pages/auth/registration/register_profile.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController authController = Get.put(AuthController());
  RxBool isPasswordVisible = false.obs;
  RxBool isSignUpEnabled = false.obs; // สถานะของปุ่ม Sign Up

  // สถานะการตรวจสอบ Password Checklist
  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasDigit = false;
  bool hasSpecialChar = false;
  bool isLongEnough = false;

  // ฟังก์ชันตรวจสอบว่าข้อมูลกรอกครบหรือยัง
  void checkIfCanSignUp() {
    if (authController.username.value.isNotEmpty &&
        authController.email.value.isNotEmpty &&
        authController.password.value.isNotEmpty) {
      isSignUpEnabled.value = true;
    } else {
      isSignUpEnabled.value = false;
    }
  }

  // ฟังก์ชันตรวจสอบความแข็งแรงของรหัสผ่าน
  void checkPasswordStrength(String password) {
    setState(() {
      hasUpperCase = RegExp(r'[A-Z]').hasMatch(password);
      hasLowerCase = RegExp(r'[a-z]').hasMatch(password);
      hasDigit = RegExp(r'[0-9]').hasMatch(password);
      hasSpecialChar = RegExp(r'[!@#\$&*~]').hasMatch(password);
      isLongEnough = password.length >= 8;
    });
    checkIfCanSignUp();
  }

  Widget buildPasswordChecklistItem(bool condition, String text) {
    return Row(
      children: [
        Icon(
          condition ? Icons.check_circle : Icons.cancel,
          color: condition ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.inter(
            textStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.lock, color: Colors.black), // ไอคอน Step
                const SizedBox(width: 8),
                Text(
                  'Step 1 ',
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  'of 4',
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'Exit',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Progress Bar สำหรับ Step 1
            LinearProgressIndicator(
              value: 0.0, // 0% สำหรับ Step 1
              backgroundColor: Colors.grey[300],
              color: Colors.black, // สีของแถบ Progress
              minHeight: 4,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text(
                'Create account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Find the things that you love!',
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Divider ระหว่าง Google Sign Up และ Email Sign Up
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                      endIndent: 10,
                    ),
                  ),
                  Text(
                    'Sign up with Email',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Username',
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                onChanged: (value) {
                  authController.username.value = value;
                  checkIfCanSignUp();
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
              ),
              const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email',
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                onChanged: (value) {
                  authController.email.value = value;
                  checkIfCanSignUp();
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
              ),
              const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password',
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Obx(() {
                return TextField(
                  onChanged: (value) {
                    authController.password.value = value;
                    checkPasswordStrength(value); // เช็คความแข็งแรงของรหัสผ่าน
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 1.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        isPasswordVisible.value = !isPasswordVisible.value;
                      },
                    ),
                  ),
                  obscureText: !isPasswordVisible.value, // ซ่อน/แสดงรหัสผ่าน
                );
              }),
              const SizedBox(height: 20),
              // Password Strength Checklist
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildPasswordChecklistItem(
                      isLongEnough, 'At least 8 characters'),
                  const SizedBox(height: 5),
                  buildPasswordChecklistItem(
                      hasUpperCase, 'Contains uppercase letter'),
                  const SizedBox(height: 5),
                  buildPasswordChecklistItem(
                      hasLowerCase, 'Contains lowercase letter'),
                  const SizedBox(height: 5),
                  buildPasswordChecklistItem(hasDigit, 'Contains digit'),
                  const SizedBox(height: 5),
                  buildPasswordChecklistItem(
                      hasSpecialChar, 'Contains special character'),
                  const SizedBox(height: 5),
                ],
              ),
              const SizedBox(height: 20), // เพิ่มระยะห่างระหว่างฟิลด์และปุ่ม
              // ปุ่ม Sign Up ที่ตรวจสอบการเปิด/ปิด
              Obx(() {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isSignUpEnabled.value
                        ? () {
                            Get.to(
                              () => const RegisterProfile(),
                              transition: Transition.rightToLeft,
                            );
                          }
                        : null, // Disable ปุ่มหากข้อมูลไม่ครบ
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: isSignUpEnabled.value
                          ? const Color.fromRGBO(50, 103, 200, 1.000)
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),

              // ข้อความ Terms and Conditions และ Privacy Policy
              Text.rich(
                TextSpan(
                  text: 'By continuing you accept our ',
                  children: [
                    TextSpan(
                      text: 'standard terms and conditions',
                      style: const TextStyle(
                        color: Colors.black87,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // เปิดหน้า Terms and Conditions
                        },
                    ),
                    const TextSpan(text: ' and our '),
                    TextSpan(
                      text: 'privacy policy.',
                      style: const TextStyle(
                        color: Colors.black87,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // เปิดหน้า Privacy Policy
                        },
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // ลิงก์ไปหน้า Log in
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed('/login');
                    },
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(50, 103, 200, 1.000),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
