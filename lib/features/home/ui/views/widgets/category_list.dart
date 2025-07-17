import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Column(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                CategoryChip(label: 'All'),
                CategoryChip(label: 'Sports'),
                CategoryChip(label: 'Politics'),
                CategoryChip(label: 'Business'),
                CategoryChip(label: 'Health'),
                CategoryChip(label: 'Travel'),
                CategoryChip(label: 'Science'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;

  const CategoryChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(label),
      style: TextButton.styleFrom(foregroundColor: Colors.black),
    );
  }
}

const List<String> categories = [
  'All',
  'Sports',
  'Politics',
  'Business',
  'Health',
  'Travel',
  'Science',
];
