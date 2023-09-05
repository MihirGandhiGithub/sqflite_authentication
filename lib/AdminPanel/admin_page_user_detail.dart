import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Constants/Global_Widgets/Appbar/appbar_with_text.dart';

class AdminPageUserDetail extends StatefulWidget {
  final String uid;

  const AdminPageUserDetail({super.key, required this.uid});

  @override
  State<AdminPageUserDetail> createState() => _AdminPageUserDetailState();
}

class _AdminPageUserDetailState extends State<AdminPageUserDetail> {
  Map<String, dynamic>? userData;
  String? newField;
  String? newValue;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      if (snapshot.exists) {
        setState(() {
          userData = snapshot.data() as Map<String, dynamic>;
          isLoading = false; // Set isLoading to false when data is fetched
        });
      } else {
        // print('Error: User data not found.');
        isLoading = false; // Set isLoading to false on error
      }
    } catch (error) {
      // print('Error fetching user data: $error');
      isLoading = false; // Set isLoading to false on error
      // Show a snackbar or dialog to inform the user about the error
    }
  }

  Future<void> _updateUserData() async {
    try {
      // Update the user data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .update(userData!);

      // Show a snackbar to inform the user about the successful update
      const snackBar = SnackBar(content: Text('Data updated successfully!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (error) {
      // print('Error updating user data: $error');
      // Show a snackbar or dialog to inform the user about the error
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> _addNewField(String field, dynamic value) async {
    try {
      // Update the user data in the local state
      setState(() {
        userData![field] = value;
      });

      // Close the dialog box
      Navigator.pop(context);

      // Show a snackbar to inform the user about the successful addition
      const snackBar = SnackBar(content: Text('New field added successfully!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (error) {
      // print('Error adding new field: $error');
      // Show a snackbar or dialog to inform the user about the error
    }
  }

  void _showAddFieldDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Add New Field',
            style: TextStyle(fontSize: 60.sp, color: Colors.black),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                style: TextStyle(fontSize: 60.sp, color: Colors.black),
                onChanged: (value) {
                  setState(() {
                    newField = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Field Name'),
              ),
              TextFormField(
                style: TextStyle(fontSize: 60.sp, color: Colors.black),
                onChanged: (value) {
                  setState(() {
                    newValue = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Field Value'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel',
                  style: TextStyle(fontSize: 60.sp, color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () => _addNewField(newField!, newValue),
              child: Text('Add',
                  style: TextStyle(fontSize: 60.sp, color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _removeUserData(String field) async {
    try {
      // Get the reference to the user's document using the UID
      DocumentReference userRef =
          _firestore.collection('users').doc(widget.uid);

      // Update the specified field with FieldValue.delete()
      await userRef.update({field: FieldValue.delete()});
      _fetchUserData();

      return true; // Success
    } catch (error) {
      // print('Error removing user data: $error');
      return false; // Failure
    }
  }

  void _showRemoveDialog() async {
    String? field;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Remove Data From All Field',
            style: TextStyle(fontSize: 60.sp, color: Colors.black),
          ),
          content: TextField(
            style: TextStyle(fontSize: 60.sp, color: Colors.black),
            onChanged: (text) => field = text,
            decoration: const InputDecoration(
              labelText: 'Field',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 60.sp, color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Remove',
                style: TextStyle(fontSize: 60.sp, color: Colors.black),
              ),
              onPressed: () async {
                // Perform add/update operation here based on the selectedUser, field, and value
                // You can use _firestore to add/update data

                // After the operation is complete, show a snackbar message

                final success = _removeUserData(field!);
                true; // Set this based on your operation's success
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(await success
                      ? 'Operation successful'
                      : 'Operation failed'),
                ));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWithText(
        appbarText: 'User Detail',
        centerTitle: false,
      ),
      body:
          isLoading // Check isLoading to decide whether to show progress or user data
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (userData != null)
                        Expanded(
                          child: ListView(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10.sp, right: 10.sp, bottom: 50.sp),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: _showAddFieldDialog,
                                      icon: Icon(
                                        Icons.add,
                                        size: 50.sp,
                                      ),
                                      label: Text(
                                        'Add Field',
                                        style: TextStyle(fontSize: 50.sp),
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: _showRemoveDialog,
                                      icon: Icon(
                                        Icons.remove,
                                        size: 50.sp,
                                      ),
                                      label: Text(
                                        'Remove Field',
                                        style: TextStyle(fontSize: 50.sp),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: _updateUserData,
                                      child: Text(
                                        'Update Data',
                                        style: TextStyle(fontSize: 50.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  // Render the data items
                                  final fieldName =
                                      userData!.keys.elementAt(index);
                                  final fieldValue =
                                      userData![fieldName].toString();

                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: 10.sp, bottom: 30.sp),
                                    child: TextFormField(
                                      style: TextStyle(
                                          fontSize: 60.sp, color: Colors.black),
                                      initialValue: fieldValue,
                                      onChanged: (value) {
                                        setState(() {
                                          userData![fieldName] = value;
                                        });
                                      },
                                      decoration:
                                          InputDecoration(labelText: fieldName),
                                    ),
                                  );
                                },
                                itemCount: userData!
                                    .length, // Add 1 for the additional row
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [],
      ),
    );
  }
}
