import 'package:flutter/material.dart';

class AzkarPage extends StatefulWidget {
  final String azkarType;
  final List<String> azkarList;
  final bool isNightMode;
  final Function(bool) updateNightModeCallback;

  AzkarPage({
    required this.azkarType,
    required this.azkarList,
    required this.isNightMode,
    required this.updateNightModeCallback,
  });

  @override
  _AzkarPageState createState() => _AzkarPageState();
}

class _AzkarPageState extends State<AzkarPage> {
  int currentIndex = 0;
  int counter = 0; // تعداد مرات عرض الذكر
  TextEditingController azkarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.azkarType.toUpperCase()),
        actions: [
          IconButton(
            icon: Icon(widget.isNightMode ? Icons.brightness_7 : Icons.brightness_3),
            onPressed: () {
              widget.updateNightModeCallback(!widget.isNightMode);
            },
          ),
        ],
      ),
      backgroundColor: widget.isNightMode ? Colors.black : Colors.lightBlue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (counter < 3) {
                    counter++;
                  } else {
                    if (currentIndex < widget.azkarList.length - 1) {
                      currentIndex++;
                      counter = 0; // إعادة تصفير العداد عند الانتقال للذكر الجديد
                    } else {
                      currentIndex = 0;
                      counter = 0;
                    }
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Text(
                      widget.azkarList[currentIndex].toUpperCase(),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Counter: $counter',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (currentIndex < widget.azkarList.length - 1) {
                                currentIndex++;
                                counter = 0;
                              } else {
                                currentIndex = 0;
                                counter = 0;
                              }
                            });
                          },
                          child: Text('Next'.toUpperCase()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                await _showAddAzkarDialog(context);
              },
              child: Text('إضافة ذكر جديد'.toUpperCase()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddAzkarDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('إضافة ذكر جديد'),
          content: TextField(
            controller: azkarController,
            decoration: InputDecoration(labelText: 'اكتب الذكر هنا'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                String newAzkar = azkarController.text;
                if (newAzkar.isNotEmpty) {
                  Navigator.pop(context);
                  setState(() {
                    widget.azkarList.add(newAzkar);
                  });
                }
              },
              child: Text('إضافة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        );
      },
    );
  }
}
