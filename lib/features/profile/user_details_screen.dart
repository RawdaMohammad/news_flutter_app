import 'package:flutter/material.dart';

import '../../core/constants/storage_key.dart';
import '../../core/services/prefrences_manager.dart';
import '../../core/widgets/custom_text_form_field.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({
    super.key,
    required this.userName,
    this.userMail,
    this.userPhone,
  });

  final String userName;
  final String? userMail;
  final String? userPhone;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late final TextEditingController userNameController;

  late final TextEditingController userMailController;

  late final TextEditingController userPhoneController;


  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: widget.userName);
    userMailController = TextEditingController(text: widget.userMail);
    userPhoneController = TextEditingController(text: widget.userPhone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextFormField(
                  controller: userNameController,
                  hint: 'User Name',
                  title: "User Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter User Name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  controller: userMailController,
                  hint: 'User Email',
                  title: "User Email",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter User Email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  controller: userPhoneController,
                  hint: 'User Phone',
                  title: "User Phone",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter User Phone";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 400),

                ElevatedButton(
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      await PreferencesManager().setString(StorageKey.username, userNameController.value.text);
                      await PreferencesManager().setString(StorageKey.useremail, userMailController.value.text);
                      await PreferencesManager().setString(StorageKey.userphone, userPhoneController.value.text);

                      Navigator.pop(context, true);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 40),
                  ),
                  child: Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
