import 'package:flutter/material.dart';
import 'package:gymmerator/ui_component/app_button.dart';

class AccountEditScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String address;
  const AccountEditScreen(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.address});

  @override
  State<AccountEditScreen> createState() => _AccountEditScreenState();
}

class _AccountEditScreenState extends State<AccountEditScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Account Edit'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: const AssetImage(
                  'assets/images/profile.png'), // Replace with your image asset
              child: Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt, size: 15),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: firstNameController..text = widget.firstName,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person_outline),
                hintText: 'Enter your first name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: lastNameController..text = widget.lastName,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person_outline),
                hintText: 'Enter your last name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController..text = widget.email,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                hintText: 'Enter your email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: phoneNumberController..text = widget.phoneNumber,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone_outlined),
                hintText: 'Mobile Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: addressController..text = widget.address,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.location_on_outlined),
                hintText: 'Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const Spacer(),
            AppButton(
              text: "Save",
              onPressed: () {
                // Handle save button action
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
