import 'package:flutter/material.dart';
import '../helpers/shared_preferences_helper.dart';
import 'dashboard_screen.dart';

/// HomeScreen widget
///
/// Author: Ritika Bhardwaj
/// This screen is the initial screen of the app. It asks the user to input their name,
/// saves the name to SharedPreferences, and navigates to the DashboardScreen if the name
/// is provided. If the name is already saved, it skips the input and directly navigates
/// to the DashboardScreen.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TextEditingController to manage the input field for the user's name
  final TextEditingController nameController = TextEditingController();

  // SharedPreferencesHelper instance to handle storing and retrieving data
  final SharedPreferencesHelper _prefsHelper = SharedPreferencesHelper();

  @override
  void initState() {
    super.initState();
    // Check if the user has already saved their name, and navigate to the dashboard if true
    _checkUserName();
  }

  /// Checks if a user name is already saved in SharedPreferences
  ///
  /// Author: Member 1
  ///
  /// This method retrieves the saved user name from SharedPreferences. If a valid user name
  /// is found, it navigates to the DashboardScreen. This is used to skip the input screen
  /// when the user has already provided their name previously.
  void _checkUserName() async {
    String? savedUserName = await _prefsHelper.getUserName();
    if (savedUserName != null && savedUserName.isNotEmpty) {
      // Navigate to the DashboardScreen if a valid user name exists
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(name: savedUserName),
        ),
      );
    }
  }

  @override
  void dispose() {
    // Dispose of the TextEditingController when the screen is destroyed to avoid memory leaks
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Fitness App'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Input field for the user to enter their name
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Enter your name', // Prompt for the user
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Button to proceed to the DashboardScreen
              ElevatedButton(
                onPressed: () async {
                  // If the name input is not empty, save it and navigate to the dashboard
                  if (nameController.text.isNotEmpty) {
                    // Save the user name using SharedPreferences
                    await _prefsHelper.saveUserName(nameController.text);

                    // Navigate to the DashboardScreen with the entered name
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DashboardScreen(name: nameController.text),
                      ),
                    );
                    nameController
                        .clear(); // Clear the text field after saving the name
                  } else {
                    // Show a SnackBar if the user doesn't enter a name
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter your name!')),
                    );
                  }
                },
                child: const Text('Proceed to Dashboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
