import 'package:flutter/material.dart';

class SummaryPage extends StatelessWidget {
  final List<String> morningAzkar;
  final List<String> eveningAzkar;

  SummaryPage({
    required this.morningAzkar,
    required this.eveningAzkar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ملخص الأذكار'.toUpperCase()),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildAzkarSection('أذكار الصباح', morningAzkar),
            SizedBox(height: 16.0),
            _buildAzkarSection('أذكار المساء', eveningAzkar),
          ],
        ),
      ),
    );
  }

  Widget _buildAzkarSection(String title, List<String> azkarList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        for (int i = 0; i < azkarList.length; i++)
          _buildAzkarItem(azkarList[i], i + 1),
      ],
    );
  }

  Widget _buildAzkarItem(String azkar, int counter) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            azkar,
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            'Counter: $counter',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
