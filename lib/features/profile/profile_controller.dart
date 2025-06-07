import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/constants/storage_key.dart';
import '../../core/services/prefrences_manager.dart';

class ProfileController with ChangeNotifier{
  late String username;
  String? userImagePath;
  String? userPhone;
  String? userMail;
  bool isLoading = true;

  init() {
    loadData();
  }

  void loadData() async {
    username = PreferencesManager().getString(StorageKey.username) ?? 'Anonymous';
    userPhone = PreferencesManager().getString(StorageKey.userphone) ?? '';
    userMail = PreferencesManager().getString(StorageKey.useremail) ?? 'user@gmail.com';
    userImagePath = PreferencesManager().getString(StorageKey.userImage);
    isLoading = false;
    notifyListeners();
  }
  void saveImage(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newFile = await File(file.path).copy('${appDir.path}/${file.name}');
    PreferencesManager().setString(StorageKey.userImage, newFile.path);
    notifyListeners();
  }
}