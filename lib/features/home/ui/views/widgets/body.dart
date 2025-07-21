import 'package:flutter/material.dart';

class NewsWidget extends StatelessWidget {
  final String title;
  final String source;
  final String category;
  final String imageUrl;
  final String timestamp;
  final String author;
  final VoidCallback? onTap;

  const NewsWidget({
    super.key,
    required this.title,
    required this.source,
    required this.category,
    required this.imageUrl,
    required this.timestamp,
    required this.author,
    this.onTap,
  });

  // 🔽 عند الضغط على زر الخيارات، يعرض Bottom Sheet فيه "مشاركة" و"حفظ"
  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text("مشاركة"),
            onTap: () {
              Navigator.pop(context);
              // ✳️ TODO: تنفيذ عملية المشاركة
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark_border),
            title: const Text("حفظ"),
            onTap: () {
              Navigator.pop(context);
              // ✳️ TODO: تنفيذ عملية الحفظ
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // 🔗 ينفذ العملية عند الضغط على الـ NewsWidget
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3), // ↕️ هامش عمودي
        padding: const EdgeInsets.all(8), // 🧱 Padding داخلي للمحتوى
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), // ⭕️ زوايا مستديرة
          color: Colors.white,
          boxShadow: [
            // 🌫️ ظل خفيف لإعطاء إحساس بالبطاقة (Card)
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖼 صورة الخبر
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                // ❌ في حال فشل تحميل الصورة
                errorBuilder: (_, __, ___) => Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image),
                ),
                // ⏳ أثناء تحميل الصورة
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 10), // ↔️ مسافة بين الصورة والنصوص

            // 📄 محتوى الخبر
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 👤 اسم الكاتب
                  Text(
                    author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // 📰 عنوان الخبر
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // 📅 معلومات إضافية مثل المصدر والتوقيت
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 🌐 مصدر الخبر
                      Flexible(
                        child: Text(
                          source,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),

                      // 🕒 أيقونة التوقيت
                      Icon(
                        Icons.access_time,
                        size: 12,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 2),

                      // 🧭 وقت النشر
                      Text(
                        timestamp,
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                      ),

                      const Spacer(), // ⚖️ يدفع زر الخيارات لأقصى اليمين

                      // ⋯ زر "المزيد"
                      IconButton(
                        onPressed: () => _showOptions(context),
                        icon: Icon(
                          Icons.more_horiz,
                          size: 18,
                          color: Colors.grey[600],
                        ),
                        constraints: const BoxConstraints(), // 🔒 يقلل الحجم
                        padding: EdgeInsets.zero, // ❌ بدون هوامش داخلية
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
