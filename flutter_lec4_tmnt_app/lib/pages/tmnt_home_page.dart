import 'package:flutter/material.dart';

class TmntHomePage extends StatefulWidget {
  const TmntHomePage({super.key, required this.title});

  final String title;
  @override
  State<TmntHomePage> createState() => _TmntHomePageState();
}

class _TmntHomePageState extends State<TmntHomePage> {
  int _selectedImageIndex = 0;

  final List<String> _imageAssets = [
    'assets/images/master.png',
    'assets/images/donatello.png',
    'assets/images/leonardo.png',
    'assets/images/michelangelo.png',
    'assets/images/raphael.png',
  ];

  final List<String> _imageTitles = [
    'Master Splinter',
    'Donatello',
    'Leonardo',
    'Michelangelo',
    'Raphael',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _imageTitles[_selectedImageIndex],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: 350,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Image.asset(_imageAssets[_selectedImageIndex]),
            ),
            const SizedBox(height: 30.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: RadioGroup<int>(
                groupValue: _selectedImageIndex,
                onChanged: (int? value) {
                  setState(() {
                    _selectedImageIndex = value ?? 0;
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Image:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey,
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Radio Buttons List
                    ...List.generate(_imageAssets.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedImageIndex == index
                                ? Colors.blue.shade50
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: _selectedImageIndex == index
                                  ? Colors.blue.shade300
                                  : Colors.grey.shade300,
                              width: _selectedImageIndex == index ? 2 : 1,
                            ),
                          ),
                          child: RadioListTile<int>(
                            title: Text(
                              _imageTitles[index],
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: _selectedImageIndex == index
                                    ? Colors.blue.shade800
                                    : Colors.grey.shade700,
                              ),
                            ),
                            value: index,
                            selected: _selectedImageIndex == index,
                            activeColor: Colors.blue.shade700,
                            tileColor: Colors.transparent,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
