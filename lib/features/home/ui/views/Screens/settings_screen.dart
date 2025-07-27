import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_with_api/features/home/ui/views/widgets/SettingsItem.dart';

// Main settings screen, defined as a StatefulWidget to manage internal state (like Dark Mode toggle)
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Variable to track the state of Dark Mode switch
  bool _isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // App bar at the top of the screen
      appBar: AppBar(
        // Back button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context); // Go back to previous screen
          },
        ),
        title: Text(
          "Settings",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      // Body with scrollable settings list
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Notification setting item
            SettingsItem(
              title: "Notification",
              icon: Icons.notifications_none,
              onTap: () {
                print("Notification tapped");
              },
            ),

            // Security setting item
            SettingsItem(
              title: "Security",
              icon: Icons.lock,
              onTap: () {
                print("Security tapped");
              },
            ),

            // Help setting item
            SettingsItem(
              title: "Help",
              icon: Icons.help_outline_rounded,
              onTap: () {
                print("Help tapped");
              },
            ),

            // Dark Mode toggle item
            SettingsItem(
              title: "Dark Mode",
              icon: Icons.dark_mode_outlined,
              trailingWidget: Transform.scale(
                scale: .8.r,

                child: Switch(
                  thumbColor: WidgetStateProperty.all(Colors.white),
                  trackOutlineWidth: WidgetStateProperty.all(0),
                  activeTrackColor: Colors.blue,

                  value: _isDarkModeEnabled,
                  onChanged: (newValue) {
                    // Update the UI state when switch is toggled
                    setState(() {
                      _isDarkModeEnabled = newValue;
                      print("Dark Mode switched to: $_isDarkModeEnabled");
                    });
                  },
                  activeColor: Colors.blue,
                ),
              ),
              // Also toggle Dark Mode when the whole row is tapped
              onTap: () {
                setState(() {
                  _isDarkModeEnabled = !_isDarkModeEnabled;
                  print(
                    "Dark Mode row tapped, switched to: $_isDarkModeEnabled",
                  );
                });
              },
            ),

            // Logout setting item
            SettingsItem(
              title: "Logout",
              icon: Icons.logout_rounded,
              onTap: () {
                print("Logout tapped");
              },
            ),
          ],
        ),
      ),
    );
  }
}
