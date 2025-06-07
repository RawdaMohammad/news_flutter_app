import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/features/auth/sign_up_screen.dart';
import 'package:news_app/features/profile/country/country_screen.dart';
import 'package:news_app/features/profile/profile_controller.dart';
import 'package:news_app/features/profile/user_details_screen.dart';
import 'package:news_app/features/terms/terms_conditions.dart';
import 'package:provider/provider.dart';

import '../../core/constants/storage_key.dart';
import '../../core/services/prefrences_manager.dart';
import '../../core/widgets/custom_svg_picture.dart';
import '../auth/sign_in_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileController>(
      create: (context) => ProfileController()..init(),
      child: Consumer(
          builder: (BuildContext context, ProfileController profileController, Widget? child) {
            return  Scaffold(
              appBar: AppBar(title: const Text('Profile'),  automaticallyImplyLeading: false,),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Center(
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                backgroundImage: profileController.userImagePath == null
                                    ? AssetImage('assets/images/person.png')
                                    : FileImage(File(profileController.userImagePath!)),
                                radius: 50,
                                backgroundColor: Colors.transparent,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  showImageSourceDialog(context, (XFile file) {
                                    profileController.saveImage(file);
                                    profileController.userImagePath = file.path;
                                  });
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Color(0xFFD1DAD6)),
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .onPrimary,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 26,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6),
                          Text(
                            profileController.username,
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelSmall,
                          ),
              
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Profile Info',
                      style: Theme
                          .of(context)
                          .textTheme
                          .labelSmall,
                    ),
                    SizedBox(height: 24),
                    ListTile(
                      onTap: () async {
                        final result = await Navigator.push(
                            context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return UserDetailsScreen(
                              userName: profileController.username,
                              userPhone: profileController.userPhone,
                              userMail: profileController.userMail,
                            );
                          },
                        ));
                        if (result != null && result) {
                          profileController.loadData();
                        }
                      },
                      contentPadding: EdgeInsets.zero,
                      title: Text('Personal Info'),
                      leading: CustomSvgPicture(
                          path: 'assets/images/profile_icon.svg'),
                      trailing: CustomSvgPicture(
                          path: 'assets/images/arrow_right.svg'),
                    ),
                    Divider(thickness: 1, color: Color(0xFFD1DAD6),),
                    ListTile(
                      onTap: () async {
                        final result = await Navigator.push(
                            context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return CountryScreen();
                          },
                        ));
                        if (result != null && result) {
                          profileController.loadData();
                        }
                      },
                      contentPadding: EdgeInsets.zero,
                      title: Text('Country'),
                      leading: CustomSvgPicture(
                          path: 'assets/images/country.svg'),
                      trailing: CustomSvgPicture(
                          path: 'assets/images/arrow_right.svg'),
                    ),
                    Divider(thickness: 1, color: Color(0xFFD1DAD6),),
                    ListTile(
                      onTap: () async {
                        final result = await Navigator.push(
                            context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return TermsConditionsScreen();
                          },
                        ));
                        if (result != null && result) {
                          profileController.loadData();
                        }
                      },
                      contentPadding: EdgeInsets.zero,
                      title: Text('Terms & Conditions'),
                      leading: CustomSvgPicture(
                          path: 'assets/images/terms.svg'),
                      trailing: CustomSvgPicture(
                          path: 'assets/images/arrow_right.svg'),
                    ),
                    Divider(thickness: 1, color: Color(0xFFD1DAD6),),
                    ListTile(
                      onTap: () async {
                        // PreferencesManager().remove(StorageKey.username);
                        // PreferencesManager().remove(StorageKey.useremail);
                        // PreferencesManager().remove(StorageKey.userImage);
                        // PreferencesManager().remove(StorageKey.userphone);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return SignInScreen();
                            },
                          ),
                              (Route<dynamic> route) => false,
                        );
                      },
                      contentPadding: EdgeInsets.zero,
                      title: Text('Log Out', style: Theme.of(context).textTheme.titleSmall,),
                      leading: CustomSvgPicture(
                          path: 'assets/images/logout_icon.svg',
                      isLogOut: true,),
                      trailing: CustomSvgPicture(
                          path: 'assets/images/arrow_right.svg',
                          isLogOut: true),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }

}

void showImageSourceDialog(BuildContext context, Function(XFile) selectedFile) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text(
          'Choose Image Source',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: [
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
              if (image != null) {
                selectedFile(image);
              }
            },
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.camera_alt),
                SizedBox(width: 8),
                Text('Camera'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (image != null) {
                selectedFile(image);
              }
            },
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.photo_library),
                SizedBox(width: 8),
                Text('Gallery'),
              ],
            ),
          )
        ],
      );
    },
  );
}

