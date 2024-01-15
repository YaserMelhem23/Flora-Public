import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flora/Pages/home_page.dart';
import 'package:flora/Pages/login_page.dart';
import 'package:flora/constants.dart';
import 'package:flora/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static String id = 'register page';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  FilePickerResult? _img;

  Future<void> pickAnImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        _img = result;
      });
    } else {
      return null;
    }
  }

  final DatabaseReference userRef =
      FirebaseDatabase.instance.ref().child("Users");
  final Reference profileImageRef = FirebaseStorage.instance
      .ref()
      .child("UserProfileImage/${DateTime.now().microsecondsSinceEpoch}.jpg");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(height: 75),
              Center(
                child: Column(
                  children: [
                    if (_img != null)
                      CircleAvatar(
                        backgroundImage: MemoryImage(_img!.files.first.bytes!),
                        radius: 60,
                      )
                    else
                      IconButton(
                        icon: Icon(Icons.camera_alt, size: 30),
                        onPressed: pickAnImage,
                      ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Flora",
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 75),
              const Row(
                children: [
                  Text(
                    'Register',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomFormTextField(
                hintText: "User Name",
                onChanged: (data) {},
                controller: usernameController,
              ),
              const SizedBox(height: 20),
              CustomFormTextField(
                hintText: "Email",
                onChanged: (data) {},
                controller: emailController,
              ),
              const SizedBox(height: 20),
              CustomPasswordFormTextField(
                hintText: "Password",
                onChanged: (data) {},
                controller: passwordController,
                obsecureText: true,
              ),
              const SizedBox(height: 20),
              CustomFormTextField(
                hintText: "Address",
                onChanged: (data) {},
                controller: addressController,
              ),
              const SizedBox(height: 20),
              CustomFormTextField(
                hintText: "Phone Number",
                onChanged: (data) {},
                controller: mobileNumberController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await registerUser();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5.0,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 6.0),
                ),
                child: Text(
                  "Register".toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Color(0xffc7ede6)),
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

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    addressController.dispose();
    mobileNumberController.dispose();
    super.dispose();
  }

  Future<void> registerUser() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    if (userCredential.user != null) {
      String imgurl;
      // Check if an image was picked
      if (_img != null) {
        UploadTask uploadTask =
            profileImageRef.putData(_img!.files.first.bytes!);
        imgurl = await (await uploadTask).ref.getDownloadURL();
      } else {
        imgurl =
            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
      }
      await userRef.child(userCredential.user!.uid).set({
        'userName': usernameController.text,
        'email': emailController.text,
        'address': addressController.text.isEmpty
            ? "Not provided"
            : addressController.text,
        'mobileNumber': mobileNumberController.text.isEmpty
            ? "Not provided"
            : mobileNumberController.text,
        'profilePhoto': imgurl,
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }
}

class UserDetails {
  String userName;
  String email;
  String address;
  String mobileNumber;
  String profilePhoto;

  UserDetails({
    required this.userName,
    required this.email,
    required this.address,
    required this.mobileNumber,
    required this.profilePhoto,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      'userName': userName,
      'email': email,
      'address': address,
      'mobileNumber': mobileNumber,
      'profilePhoto': profilePhoto,
    };
  }

  factory UserDetails.fromMap(Map<dynamic, dynamic> map) {
    return UserDetails(
      userName: map['userName'],
      email: map['email'],
      address: map['address'],
      mobileNumber: map['mobileNumber'],
      profilePhoto: map['profilePhoto'],
    );
  }
}

class FirebaseService {
  final User? user = FirebaseAuth.instance.currentUser;
  final DatabaseReference userRef =
      FirebaseDatabase.instance.ref().child("Users");

  Future<UserDetails?> getUserFromDatabase() async {
    try {
      if (user != null) {
        DatabaseEvent event = await userRef.child(user!.uid).once();
        if (event.snapshot.value != null) {
          Map<dynamic, dynamic> snapMap =
              Map<dynamic, dynamic>.from(event.snapshot.value as Map);

          return UserDetails.fromMap(snapMap);
        } else {
          print("User details null");
          return null;
        }
      } else {
        print("The current user is null");
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
