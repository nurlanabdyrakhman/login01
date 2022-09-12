import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login01/controllers/data_uploader.dart';
import 'package:login01/firebase.ref/loading_status.dart';

class DataUploaderCcreen extends StatelessWidget {
  DataUploaderCcreen({Key? key}) : super(key: key);
  DataUploader controller = Get.put(DataUploader());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() => Text(
            controller.loadingStatus.value == LoadingStatus.completed
                ? 'Uploading completed'
                : 'Uploading...')),
      ),
    );
  }
}
