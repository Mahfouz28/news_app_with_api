import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 1. Separate Widget for individual setting items (أداة منفصلة لعناصر الإعدادات الفردية)
class SettingsItem extends StatelessWidget {
  final String title; // عنوان العنصر (مثل "Notification")
  final IconData icon; // الأيقونة (مثل Icons.notifications_none)
  final Widget? trailingWidget; // أداة اختيارية للجانب الأيمن (مثل زر التبديل أو السهم)
  final VoidCallback? onTap; // دالة يتم استدعاؤها عند النقر على العنصر

  const SettingsItem({
    super.key,
    required this.title,
    required this.icon,
    this.trailingWidget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // يجعل الصف بأكمله قابلاً للنقر
      onTap: onTap, // يتم استدعاء دالة onTap عند النقر
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h), // مسافة بادئة متناسقة
        child: Row( // صف لتنظيم الأيقونة، النص، والأداة الختامية
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // توزيع العناصر على أقصى اليمين واليسار
          children: [
            Row( // صف للأيقونة والنص
              children: [
                Icon(icon, size: 24.sp), // الأيقونة بحجم متناسق
                15.horizontalSpace, // مسافة أفقية بين الأيقونة والنص
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            // عرض الأداة الختامية إذا تم توفيرها، وإلا سهم افتراضي
            trailingWidget ?? Icon(Icons.arrow_forward_ios_rounded, size: 18.sp),
          ],
        ),
      ),
    );
  }
}