import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// DietPage widget
///
/// Author: Abhishek Bhardwaj
/// This page allows the user to set their diet plan by inputting the amount of proteins, fats,
/// and carbohydrates. The diet plans are saved and loaded using SharedPreferences. The user can
/// add multiple diet plans, and the list of saved plans is displayed on the screen.
class DietPage extends StatefulWidget {
  const DietPage({super.key});

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  // Controllers to manage user inputs for proteins, fats, and carbs
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();

  // List to store the diet plans
  final List<String> _dietPlans = [];

  @override
  void initState() {
    super.initState();
    // Load saved diet plans when the screen is initialized
    _loadDietPlans();
  }

  /// Loads saved diet plans from SharedPreferences
  ///
  /// Author: Memebr 3
  ///
  /// This method retrieves the list of diet plans stored in SharedPreferences. If no diet plans
  /// exist, it initializes the list as empty. After loading, it updates the state to display the
  /// loaded plans in the UI.
  void _loadDietPlans() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _dietPlans.clear(); // Clear current list before adding new plans
      _dietPlans
          .addAll(prefs.getStringList('dietPlans') ?? []); // Load saved plans
    });
  }

  /// Saves the current list of diet plans to SharedPreferences
  ///
  /// Author: Memeber 3
  ///
  /// This method saves the updated list of diet plans to SharedPreferences, ensuring that the
  /// user's data persists across app sessions.
  void _saveDietPlans() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('dietPlans',
        _dietPlans); // Save the diet plans list to SharedPreferences
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title for the page
          const Text(
            'Set Your Diet Plan',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          // TextField for entering the amount of proteins
          TextField(
            controller: _proteinController,
            decoration: const InputDecoration(
              labelText: 'Proteins (g)', // Label for protein input field
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number, // Ensure input is numeric
          ),
          const SizedBox(height: 10),
          // TextField for entering the amount of fats
          TextField(
            controller: _fatController,
            decoration: const InputDecoration(
              labelText: 'Fats (g)', // Label for fat input field
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number, // Ensure input is numeric
          ),
          const SizedBox(height: 10),
          // TextField for entering the amount of carbohydrates
          TextField(
            controller: _carbsController,
            decoration: const InputDecoration(
              labelText: 'Carbohydrates (g)', // Label for carbs input field
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number, // Ensure input is numeric
          ),
          const SizedBox(height: 10),
          // Button to add a new diet plan
          ElevatedButton(
            onPressed: () {
              setState(() {
                // Add the new diet plan to the list
                _dietPlans.add(
                  'Proteins: ${_proteinController.text}, Fats: ${_fatController.text}, Carbs: ${_carbsController.text}',
                );
                // Save the updated diet plans list
                _saveDietPlans();

                // Clear the input fields after adding the goal
                _proteinController.clear();
                _fatController.clear();
                _carbsController.clear();
              });
            },
            child: const Text('Add Diet Plan'), // Button label
          ),
          const SizedBox(height: 20),
          // Header for the list of diet plans
          const Text(
            'Diet Plans',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // ListView to display all saved diet plans
          Expanded(
            child: ListView.builder(
              itemCount: _dietPlans.length, // Number of diet plans to display
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_dietPlans[index]), // Display each diet plan
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
