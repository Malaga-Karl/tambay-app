import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPTest extends StatelessWidget {
  const SPTest({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController id_controller = TextEditingController();
    TextEditingController value_controller = TextEditingController();

    void _showSnackBar(BuildContext context, String message) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }

    return Scaffold(
      appBar: AppBar(title: Text("Shared Preferences Test")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Id",
              ),
              controller: id_controller,
            ),
            SizedBox(height: 50),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Value",
              ),
              controller: value_controller,
            ),
            SizedBox(height: 50),
            Text("Actions:"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FilledButton(
                  onPressed: () async {
                    try {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString(
                        id_controller.value.text,
                        value_controller.value.text,
                      );
                      _showSnackBar(context, "Successfully added!");
                    } catch (e) {
                      _showSnackBar(context, "Failed to add: $e");
                    }
                  },
                  child: Text("Add"),
                ),
                FilledButton(
                  onPressed: () async {
                    try {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      final value = prefs.getString(id_controller.value.text);
                      if (value != null) {
                        _showSnackBar(context, "Value: $value");
                      } else {
                        _showSnackBar(
                          context,
                          "No value found for the given ID.",
                        );
                      }
                    } catch (e) {
                      _showSnackBar(context, "Failed to read: $e");
                    }
                  },
                  child: Text("Read"),
                ),
                FilledButton(
                  onPressed: () async {
                    try {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.remove(id_controller.value.text);
                      _showSnackBar(context, "Successfully deleted!");
                    } catch (e) {
                      _showSnackBar(context, "Failed to delete: $e");
                    }
                  },
                  child: Text("Delete with ID"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
