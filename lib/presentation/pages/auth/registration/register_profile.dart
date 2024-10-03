import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kpopmerchapplication/presentation/controllers/auth_controller.dart';

class RegisterProfile extends StatefulWidget {
  const RegisterProfile({super.key});

  @override
  _RegisterProfileState createState() => _RegisterProfileState();
}

class _RegisterProfileState extends State<RegisterProfile>
    with SingleTickerProviderStateMixin {
  final AuthController authController = Get.put(AuthController());

  // AnimationController สำหรับค่อยๆ เพิ่มค่าของ LinearProgressIndicator
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // กำหนด AnimationController และ Tween สำหรับ progress
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // ระยะเวลาของ animation
    );

    _animation =
        Tween<double>(begin: 0.1, end: 0.25).animate(_animationController);

    // เริ่ม animation เมื่อ initState ถูกเรียก
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    authController.profileImage.value = '';
    super.dispose();
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
                  'Step 2 ',
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
                    Get.offAllNamed('/login');
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

            // Progress Bar พร้อม animation
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return LinearProgressIndicator(
                  value: _animation.value, // ใช้ค่าจาก animation
                  backgroundColor: Colors.grey[300],
                  color: Colors.black, // สีของแถบ Progress
                  minHeight: 5,
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Add a photo.',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Add a photo so other members ',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
            Text(
              'know who you are.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // รูปโปรไฟล์พร้อมการคลิกเพื่อเลือกภาพใหม่
            Obx(() {
              return Column(
                children: [
                  if (authController.profileImage.isNotEmpty)
                    GestureDetector(
                      onTap: () async {
                        await authController
                            .pickProfileImage(); // เลือกรูปภาพใหม่เมื่อกดที่รูป
                      },
                      child: ClipOval(
                        child: Image.file(
                          File(authController.profileImage.value),
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  else
                    GestureDetector(
                      onTap: () async {
                        await authController.pickProfileImage();
                      },
                      child: Image.asset(
                        'assets/images/stage_images.png',
                        height: 200,
                      ),
                    ),
                  const SizedBox(height: 20),
                ],
              );
            }),
            const Spacer(),
            // ปุ่มด้านล่าง
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ปุ่ม Skip
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'Back',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
                // ปุ่ม Upload a photo
                ElevatedButton(
                  onPressed: () async {
                    await authController.register();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 25),
                    backgroundColor: const Color.fromRGBO(50, 103, 200, 1.000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
