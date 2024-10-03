//lib/presentation/widgets/reusable_button.dart

import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final String text; // ข้อความในปุ่ม
  final VoidCallback onPressed; // ฟังก์ชันที่เรียกใช้เมื่อกดปุ่ม
  final Color color; // สีของปุ่ม
  final Color textColor; // สีของข้อความในปุ่ม
  final EdgeInsets? padding; // Padding ภายในปุ่ม

  const ReusableButton({
    required this.text,
    required this.onPressed,
    this.color = Colors.white, // ค่าเริ่มต้นสีปุ่มเป็นสีขาว
    this.textColor = Colors.black, // ค่าเริ่มต้นสีข้อความเป็นสีดำ
    this.padding, // ค่า padding ที่สามารถกำหนดได้
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // สีพื้นหลังของปุ่ม
        padding: padding ?? const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5), // มุมโค้งของปุ่ม
          side: const BorderSide(
              width: 1,
              color: Color.fromARGB(255, 223, 223, 223)), // เส้นขอบปุ่ม
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor, // สีของข้อความ
          fontSize: 16,
          fontWeight: FontWeight.bold, // น้ำหนักตัวอักษร
        ),
      ),
    );
  }
}
