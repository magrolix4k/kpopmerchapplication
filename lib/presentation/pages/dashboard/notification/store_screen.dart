import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpopmerchapplication/presentation/controllers/store_controller.dart';

class StoreScreen extends StatelessWidget {
  final StoreController storeController = Get.put(StoreController());

  StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Management'),
      ),
      body: Obx(() {
        if (storeController.stores.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: storeController.stores.length,
            itemBuilder: (context, index) {
              var store = storeController.stores[index];
              return ListTile(
                title: Text(store['name']), // ชื่อร้านค้า
                subtitle: Text(store['username']), // ชื่อผู้ใช้ร้าน
              );
            },
          );
        }
      }),
    );
  }
}
