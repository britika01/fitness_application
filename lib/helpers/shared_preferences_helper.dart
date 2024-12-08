import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferencesHelper class
///

/// This class provides utility methods for interacting with `SharedPreferences`.
/// It is used for saving, retrieving, and removing user-related data such as
/// the user’s name and their goals. SharedPreferences is used for persistent storage.

class SharedPreferencesHelper {
  /// Save user name to SharedPreferences
  ///
  /// Author: Memeber 1
  ///
  /// This method saves the user’s name to SharedPreferences. It uses the `setString` method
  /// to store the name with the key 'userName'.
  Future<void> saveUserName(String name) async {
    // Retrieve the SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();
    // Store the user name
    await prefs.setString('userName', name);
  }

  /// Get the user name from SharedPreferences
  ///
  /// Author: Memeber 1
  ///
  /// This method retrieves the user’s name from SharedPreferences using the key 'userName'.
  /// If no name is found, it returns `null`.
  Future<String?> getUserName() async {
    // Retrieve the SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();
    // Fetch and return the user name, or null if not found
    return prefs.getString('userName');
  }

  /// Save a goal to SharedPreferences
  ///
  /// Author: Memeber 2
  ///
  /// This method adds a new goal to the list of goals stored in SharedPreferences.
  /// If no goals are stored, it initializes an empty list.
  /// The goal is then appended to the list, and the updated list is saved back to SharedPreferences.
  Future<void> saveGoal(String goal) async {
    // Retrieve the SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();
    // Get the current list of goals, or initialize an empty list if none exist
    List<String> goals = prefs.getStringList('goals') ?? [];
    // Add the new goal to the list
    goals.add(goal);
    // Save the updated list of goals
    await prefs.setStringList('goals', goals);
  }

  /// Get all goals from SharedPreferences
  ///
  /// Author: Memeber 2
  ///
  /// This method retrieves the list of goals stored in SharedPreferences.
  /// If no goals are found, it returns an empty list.
  Future<List<String>> getGoals() async {
    // Retrieve the SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();
    // Fetch the list of goals, or return an empty list if none exist
    return prefs.getStringList('goals') ?? [];
  }

  /// Remove a goal from SharedPreferences
  ///
  /// Author: Member 2
  ///
  /// This method removes a specific goal from the list of goals stored in SharedPreferences.
  /// After removing the goal, the updated list is saved back to SharedPreferences.
  Future<void> removeGoal(String goal) async {
    // Retrieve the SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();
    // Get the current list of goals, or initialize an empty list if none exist
    List<String> goals = prefs.getStringList('goals') ?? [];
    // Remove the specified goal from the list
    goals.remove(goal);
    // Save the updated list of goals
    await prefs.setStringList('goals', goals);
  }
}
