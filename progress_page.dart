import 'package:flutter/material.dart';
import '../helpers/shared_preferences_helper.dart';

/// ProgressPage widget
///
/// Author: Jashandeep Singh
/// This page allows the user to track the progress of their goals. It retrieves the user's saved goals
/// from SharedPreferences, calculates the progress (simulated for demonstration purposes), and displays the
/// progress message to the user.
class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  final SharedPreferencesHelper _prefsHelper = SharedPreferencesHelper();

  // List of goals fetched from SharedPreferences
  List<String> _goals = [];

  // Message that will be displayed to the user about their progress
  String _progressMessage = "";

  /// Fetches the user's goals from SharedPreferences and calculates the progress
  ///
  /// Author: Member 4
  ///
  /// This method retrieves the goals from SharedPreferences using the helper method.
  /// If no goals are found, it sets a message indicating that no goals are set yet.
  /// If goals are present, it calculates a simulated progress percentage (60% complete)
  /// and displays a message with the calculated progress.
  void _viewProgress() async {
    // Fetch the list of goals stored in SharedPreferences
    List<String> goals = await _prefsHelper.getGoals();

    // Check if the user has set any goals
    if (goals.isEmpty) {
      // If no goals are set, update the message to inform the user
      setState(() {
        _progressMessage = "No goals set yet.";
      });
    } else {
      // Simulate progress percentage calculation (60% of goals are completed for demo)
      int completedGoals =
          (goals.length * 0.6).floor(); // Assuming 60% of goals are completed
      double progressPercentage = (completedGoals / goals.length) * 100;

      // Update the progress message based on the calculated percentage
      setState(() {
        _progressMessage =
            "You have completed ${progressPercentage.toStringAsFixed(1)}% of your goals!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header text indicating the purpose of the page
          const Text(
            'Track Your Progress',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Button that triggers the process of viewing progress
          ElevatedButton(
            onPressed:
                _viewProgress, // When pressed, it calls the _viewProgress method
            child: const Text('View Progress'),
          ),
          const SizedBox(height: 20),

          // Display the progress message
          Text(
            _progressMessage, // Displays the message based on calculated progress
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
