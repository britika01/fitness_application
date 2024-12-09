import 'package:flutter/material.dart';
import '../helpers/shared_preferences_helper.dart';

/// GoalsPage widget
///
/// Author: YashviPatel
/// This page allows the user to set and manage fitness goals. It lets the user enter exercise
/// details and calorie target, and saves them to SharedPreferences. The page displays the list of
/// saved goals, and the user can delete goals if needed.
class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  // TextEditingControllers for input fields to enter exercise and calorie target
  final TextEditingController _exerciseController = TextEditingController();
  final TextEditingController _calorieTargetController =
      TextEditingController();

  // List of goals fetched from SharedPreferences
  List<String> _goals = [];

  // SharedPreferencesHelper instance to handle storing and retrieving data
  final SharedPreferencesHelper _prefsHelper = SharedPreferencesHelper();

  @override
  void initState() {
    super.initState();
    // Load saved goals when the screen is initialized
    _loadGoals();
  }

  /// Loads saved goals from SharedPreferences
  ///
  /// Author: Memeber 2
  ///
  /// This method retrieves the list of goals stored in SharedPreferences using the helper method.
  /// Once goals are fetched, it updates the state to display them in the UI.
  void _loadGoals() async {
    List<String> goals = await _prefsHelper.getGoals();
    setState(() {
      _goals = goals; // Update the list of goals
    });
  }

  /// Adds a new goal to the list of saved goals
  ///
  /// Author: Memeber 2
  ///
  /// This method is triggered when the user presses the "Add Goal" button. It checks if the
  /// exercise and calorie target fields are not empty, creates a new goal string, saves it
  /// using SharedPreferences, and then reloads the goals list.
  void _addGoal() async {
    if (_exerciseController.text.isNotEmpty &&
        _calorieTargetController.text.isNotEmpty) {
      // Create a new goal string combining exercise and calorie target
      String goal =
          '${_exerciseController.text} - ${_calorieTargetController.text} calories';

      // Save the new goal to SharedPreferences
      await _prefsHelper.saveGoal(goal);

      // Clear the input fields
      _exerciseController.clear();
      _calorieTargetController.clear();

      // Reload the list of goals to reflect the added goal
      _loadGoals();
    }
  }

  /// Deletes a specific goal from the saved list
  ///
  /// Author: Memeber 2
  ///
  /// This method is called when the user taps the delete button next to a goal. It removes the
  /// goal from SharedPreferences and reloads the goals list to reflect the deletion.
  void _deleteGoal(String goal) async {
    await _prefsHelper.removeGoal(goal);
    _loadGoals(); // Reload goals after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header text for the page
          const Text(
            'Set Goals',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          // TextField for entering the exercise goal
          TextField(
            controller: _exerciseController,
            decoration: const InputDecoration(
              labelText: 'Enter exercise', // Label for the exercise input
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          // TextField for entering the calorie target
          TextField(
            controller: _calorieTargetController,
            decoration: const InputDecoration(
              labelText: 'Calorie Target', // Label for the calorie target input
              border: OutlineInputBorder(),
            ),
            keyboardType:
                TextInputType.number, // Input is expected to be a number
          ),
          const SizedBox(height: 10),
          // Button to add a new goal
          ElevatedButton(
            onPressed: _addGoal, // Calls the _addGoal method when pressed
            child: const Text('Add Goal'),
          ),
          const SizedBox(height: 20),
          // Header text for the goals list
          const Text(
            'Goals',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // Display the list of goals
          Expanded(
            child: ListView.builder(
              itemCount: _goals.length,
              itemBuilder: (context, index) {
                final goal = _goals[index]; // Get each goal from the list
                return ListTile(
                  title: Text(goal), // Display the goal
                  trailing: IconButton(
                    icon: const Icon(Icons.delete,
                        color: Colors.red), // Delete icon
                    onPressed: () =>
                        _deleteGoal(goal), // Calls _deleteGoal when pressed
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
