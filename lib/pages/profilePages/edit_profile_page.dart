import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  static const id = 'EditProfilePage';
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Color(0xFF757575)),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "Complete Profile",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Complete your details or continue \nwith social media",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF757575)),
                  ),
                  // const SizedBox(height: 16),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  const ComplateProfileForm(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),

                  const Text(
                    "By continuing your confirm that you agree \nwith our Term and Condition",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF757575),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Color(0xFF757575)),
  borderRadius: BorderRadius.all(Radius.circular(6)),
);

class ComplateProfileForm extends StatefulWidget {
  const ComplateProfileForm({super.key});

  @override
  State<ComplateProfileForm> createState() => _ComplateProfileFormState();
}

class _ComplateProfileFormState extends State<ComplateProfileForm> {
  var formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser;
  TextEditingController? _nameController;
  TextEditingController? _phoneController;
  TextEditingController? _addressController;
  @override
  void initState() {
    setInitiData();
    super.initState();
  }

  void setInitiData() {
    _nameController = TextEditingController(text: user?.displayName ?? '');
    _phoneController =
        TextEditingController(text: _phoneController?.text ?? '');
    _addressController =
        TextEditingController(text: _addressController?.text ?? '');
    setState(() {});
  }

  Future<void> insertUserData() async {
    final userData = {
      'name': _nameController?.text ?? '',
      'phone': _phoneController?.text ?? '',
      'address': _addressController?.text ?? '',
    };
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .set(userData);
  }

  @override
  void dispose() {
    _nameController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                hintText: "Enter your  name",
                labelText: "First Name",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: const TextStyle(color: Color(0xFF757575)),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                suffix: Icon(Icons.person_4),
                border: authOutlineInputBorder,
                enabledBorder: authOutlineInputBorder,
                focusedBorder: authOutlineInputBorder.copyWith(
                    borderSide: const BorderSide(color: ColorUtility.main))),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                hintText: "Enter your phone number",
                labelText: "Phone Number",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: const TextStyle(color: Color(0xFF757575)),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                suffix: Icon(Icons.phone),
                border: authOutlineInputBorder,
                enabledBorder: authOutlineInputBorder,
                focusedBorder: authOutlineInputBorder.copyWith(
                    borderSide: const BorderSide(color: ColorUtility.main))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                  hintText: "Enter your address",
                  labelText: "Address",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: const TextStyle(color: Color(0xFF757575)),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  suffix: Icon(Icons.location_history),
                  border: authOutlineInputBorder,
                  enabledBorder: authOutlineInputBorder,
                  focusedBorder: authOutlineInputBorder.copyWith(
                      borderSide: const BorderSide(color: ColorUtility.main))),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              insertUserData();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: ColorUtility.deepYellow,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            child: const Text("Continue"),
          )
        ],
      ),
    );
  }
}
