import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_border/dotted_border.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(24.0.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Text(
                      "Create News",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert),
                    ),
                  ],
                ),
              ),
              16.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0.r),
                child: DottedBorder(
                  options: RectDottedBorderOptions(
                    color: const Color(0xff4E4B66),
                    padding: const EdgeInsets.all(0),
                    dashPattern: [10.r, 10.r],
                    strokeWidth: 2.r,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      print("Taped");
                    },
                    child: Container(
                      height: 183.sp,
                      width: double.infinity,
                      color: const Color(0xffEEF1F4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_rounded,
                            size: 30.sp,
                            color: Colors.grey,
                          ),
                          const Text(
                            "Add Cover Photo",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              16.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0.r),
                child: TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color(0xffA0A3BD),
                        width: 1.0.r,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color(0xffA0A3BD),
                        width: 2.0.r,
                      ),
                    ),
                    hintText: "News title",
                    hintStyle: const TextStyle(color: Color(0xffA0A3BD)),
                  ),
                ),
              ),
              16.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0.r),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add News/Article",
                    hintStyle: TextStyle(color: Color(0xffA0A3BD)),
                  ),
                  maxLines: 5,
                ),
              ),

              275.verticalSpace, // Provides spacing before the bottom bar
              Container(
                width: double.infinity,
                height: 80.h,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.0.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 109.w,
                      height: 50.h,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                        ),
                        onPressed: () {
                          // TODO: Implement publish functionality
                        },
                        child: Text(
                          "Publish",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(), // Pushes the publish button to the right and other icons to the left
                    // Text Fields icon
                    IconButton(
                      onPressed: () {
                        // TODO: Implement text fields functionality
                      },
                      icon: Icon(Icons.text_fields_rounded),
                    ),
                    // Align Left icon
                    IconButton(
                      onPressed: () {
                        // TODO: Implement text alignment functionality
                      },
                      icon: Icon(Icons.format_align_left),
                    ),
                    // Insert Photo icon
                    IconButton(
                      onPressed: () {
                        // TODO: Implement insert photo functionality
                      },
                      icon: Icon(Icons.insert_photo),
                    ),
                    // More options icon, now triggering a horizontal bottom sheet
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 60.h, // Adjust height as needed
                              color: Colors.white,
                              child: Center(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      // Bold icon
                                      IconButton(
                                        onPressed: () {
                                          print("Bold tapped");
                                          Navigator.pop(
                                            context,
                                          ); // Close the bottom sheet
                                        },
                                        icon: Icon(Icons.format_bold),
                                      ),
                                      // Italic icon
                                      IconButton(
                                        onPressed: () {
                                          print("Italic tapped");
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.format_italic),
                                      ),
                                      // Bullet List icon
                                      IconButton(
                                        onPressed: () {
                                          print("Bullet List tapped");
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.format_list_bulleted),
                                      ),
                                      // Numbered List icon
                                      IconButton(
                                        onPressed: () {
                                          print("Numbered List tapped");
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.format_list_numbered),
                                      ),
                                      // Link icon
                                      IconButton(
                                        onPressed: () {
                                          print("Link tapped");
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.link),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.more_horiz),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
