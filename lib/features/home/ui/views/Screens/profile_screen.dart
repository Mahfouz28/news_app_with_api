import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app_with_api/features/auth/ui/signun/widgets/CustomTextButton.dart';
import 'package:news_app_with_api/features/home/ui/views/Screens/edit_profile_screen.dart';
import 'package:news_app_with_api/features/home/ui/views/Screens/new_post_.dart';
import 'package:news_app_with_api/features/home/ui/views/Screens/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.all(Radius.circular(50.r)),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewPostScreen()),
            );
          },
          child: const Icon(FontAwesomeIcons.add),
        ),

        body: SafeArea(
          child: Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.r),
              child: Column(
                children: [
                  // Top header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Profile",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 120.w),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsScreen(),
                            ),
                          );
                        },
                        icon: const FaIcon(FontAwesomeIcons.gear),
                      ),
                    ],
                  ),

                  // Scrollable content
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            radius: 50.r,
                            backgroundImage: const AssetImage(
                              "assets/Ellipse 13.png",
                            ),
                          ),
                          buildStat("2156", "Followers"),
                          buildStat("567", "Following"),
                          buildStat("23", "News"),
                        ],
                      ),
                      20.verticalSpace,
                      Text(
                        "Wilson Franci",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextButton(
                              label: 'Edit profile',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfileScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                          16.horizontalSpace,
                          Expanded(
                            child: CustomTextButton(
                              label: 'Website',
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      20.verticalSpace,
                    ],
                  ),

                  // Tab bar
                  TabBar(
                    dividerHeight: 0.h,
                    indicatorColor: Colors.blue,

                    labelColor: Colors.black,
                    labelStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelColor: Colors.grey,

                    tabs: const [
                      Tab(text: "News"),
                      Tab(text: "Recent"),
                    ],
                  ),

                  // Tab content
                  SizedBox(
                    height: 400.h,
                    child: TabBarView(
                      children: [
                        ListView.builder(
                          itemCount: 50,
                          itemBuilder: (BuildContext context, int index) {
                            return const Align(
                              alignment: Alignment.center,
                              child: Text("ok"),
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: 50,
                          itemBuilder: (BuildContext context, int index) {
                            return const Align(
                              alignment: Alignment.center,
                              child: Text("ok"),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStat(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
