import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_with_api/features/auth/ui/signun/widgets/custom_text_field.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Profile has been Updated"),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.blue,
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(16),
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.check),
                    ),
                    Text(
                      "Edit Profile",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ],
                ),
                16.verticalSpace,
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: const AssetImage(
                        "assets/Ellipse 13.png",
                      ),
                      radius: 90.r,
                    ),
                    Positioned(
                      bottom: 10,
                      right: 15,
                      child: Container(
                        width: 45.w,
                        height: 45.h,
                        decoration: BoxDecoration(
                          color: Colors.blue,

                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.camera_alt_sharp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const CustomTextField(
                  hintText: "Username",
                  fieldName: "Username",
                ),
                16.verticalSpace,
                const CustomTextField(
                  hintText: "Full Name",
                  fieldName: "Full Name",
                ),
                16.verticalSpace,

                const CustomTextField(
                  hintText: "Email Address*",
                  fieldName: "Email Address*",
                ),
                16.verticalSpace,

                const CustomTextField(
                  hintText: "Phone Number*",
                  fieldName: "Phone Number*",
                ),
                16.verticalSpace,

                const CustomTextField(hintText: "Bio", fieldName: "Bio"),
                16.verticalSpace,

                const CustomTextField(
                  hintText: "Website",
                  fieldName: "Website",
                ),
                16.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
