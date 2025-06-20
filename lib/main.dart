import 'package:flutter/material.dart';

class FamilyTreeWidget extends StatelessWidget {
  final FamilyMember member;
  final double indent;

  const FamilyTreeWidget({
    required this.member,
    this.indent = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tampilan anggota keluarga
        Row(
          children: [
            SizedBox(width: indent),
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(member.imagePath),
            ),
            SizedBox(width: 10),
            Text(
              member.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        // Anak-anak (jika ada)
        if (member.children != null)
          ...member.children!.map(
            (child) => FamilyTreeWidget(
              member: child,
              indent: indent + 40.0, //tingkatkan indentasi 20 / 40
            ),
          ),
      ],
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final familyTree = FamilyMember(
    name: 'Ayah',
    imagePath: 'assets/images/ayah.jpg',
    children: [
      FamilyMember(
        name: 'Ibu',
        imagePath: 'assets/images/ibu.jpg',
        children: [
          FamilyMember(name: 'Anak 1', imagePath: 'assets/images/anak1.jpg'),
          FamilyMember(name: 'Anak 2', imagePath: 'assets/images/anak2.jpg'),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Hierarki Keluarga Farghoststore')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FamilyTreeWidget(member: familyTree),
          ),
        ),
      ),
    );
  }
}

class FamilyMember {
  final String name;
  final String imagePath;
  final List<FamilyMember>? children;

  FamilyMember({
    required this.name,
    required this.imagePath,
    this.children,
  });
}
