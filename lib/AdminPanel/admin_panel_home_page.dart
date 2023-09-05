import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Constants/Global_Widgets/Appbar/appbar_with_action.dart';
import '../Constants/Global_Widgets/Search Bar/search_bar.dart';
import '../Screens/Home_page/home_page.dart';
import 'admin_page_user_detail.dart';

enum SampleItem { itemOne, itemTwo }

class AdminPanelHome extends StatefulWidget {
  const AdminPanelHome({super.key});

  @override
  State<AdminPanelHome> createState() => _AdminPanelHomeState();
}

class _AdminPanelHomeState extends State<AdminPanelHome> {
  bool isloading = true;
  bool isRefreshing = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  FirebaseFirestore db = FirebaseFirestore.instance;

  static Map<String, int?> itemCounts = {
    'users': null,
    'Counters': null,
    'advertise link': null,
  };

  Future<void> _counter() async {
    try {
      await Future.wait(itemCounts.keys.map((collectionName) async {
        final res = await db.collection(collectionName).count().get();
        itemCounts[collectionName] = res.count;
      }));
      // print('Inside try \n \n \n \n');
      setState(() {
        isloading = false;
      });

      // Navigator.of(context).pop();
    } catch (e) {
      // print("Error completing: $e");
    }
  }

  Future<void> _onRefresh() async {
    try {
      await _counter();
    } catch (e) {
      // Handle the error if fetching counters fails
      // print('Error: $e');
    } finally {
      setState(() {
        isRefreshing = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _counter();
  }

  List<UserModel> userList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWithAction(
        appbarText: 'TC Admin Panel',
        appbarIcon: Icons.home_filled,
        appbarIconOnPress: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        },
        centerTitle: true,
      ),
      body: RefreshIndicator(
        color: Colors.lightBlueAccent,
        backgroundColor: Colors.white,
        strokeWidth: 4.0,
        onRefresh: () {
          setState(() {
            isRefreshing = false;
          });
          return _onRefresh();
        },
        child: isloading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : Column(
                children: [
                  //Total User

                  Card(
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.blue, width: 0.4),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      tileColor: Colors.white,
                      contentPadding: const EdgeInsets.all(8.0),
                      leading: const CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        '${itemCounts['users']}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          // Show the popup menu
                          showMenu(
                            context: context,
                            position:
                                const RelativeRect.fromLTRB(100, 100, 0, 0),
                            items: <PopupMenuEntry<SampleItem>>[
                              const PopupMenuItem<SampleItem>(
                                value: SampleItem.itemOne,
                                child: Text('Add Field All User'),
                              ),
                              const PopupMenuItem<SampleItem>(
                                value: SampleItem.itemTwo,
                                child: Text('Remove Field All User'),
                              ),
                            ],
                          ).then((value) {
                            // Handle the selection
                            if (value == SampleItem.itemOne) {
                              _showAddDialog();
                            } else if (value == SampleItem.itemTwo) {
                              _showRemoveDialog();
                            }
                          });
                        },
                        icon: const Icon(Icons.more_vert),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SearchbarWithIcon(
                      searchbarText: 'Search Name Here ...',
                      onChange: (value) {
                        setState(() {
                          _searchController.text = value;
                        });
                      },
                      controller: _searchController,
                      clearButtonPressed: () {
                        setState(() {
                          _searchController.clear();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: _fetchUserList(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          List<UserModel> userList = snapshot.data ?? [];

                          if (_searchController.text.isEmpty) {
                            return ListView.builder(
                              padding: EdgeInsets.only(top: 20.h),
                              physics: const BouncingScrollPhysics(),
                              itemCount: userList
                                  .length, // Number of items in the list
                              itemBuilder: (BuildContext context, int index) {
                                UserModel user = userList[index];

                                // Build each list item
                                return AdminsmallBlueWhiteBox(
                                  userData: user,
                                );
                              },
                            );
                          } else {
                            List<UserModel> filteredList =
                                userList.where((user) {
                              // Compare search text with relevant fields
                              String searchText =
                                  _searchController.text.toLowerCase();

                              return user.name!
                                      .toLowerCase()
                                      .contains(searchText) ||
                                  user.email!
                                      .toLowerCase()
                                      .contains(searchText) ||
                                  user.mobile!
                                      .toLowerCase()
                                      .contains(searchText);
                              // Add more conditions for other fields if needed
                            }).toList();
                            if (filteredList.isNotEmpty) {
                              return ListView.builder(
                                padding: EdgeInsets.only(top: 20.h),
                                physics: const BouncingScrollPhysics(),
                                itemCount: filteredList
                                    .length, // Number of items in the list
                                itemBuilder: (BuildContext context, int index) {
                                  UserModel user = filteredList[index];

                                  // Build each list item
                                  return AdminsmallBlueWhiteBox(
                                    userData: user,
                                  );
                                },
                              );
                            } else {
                              return Container();
                            }
                          }
                        }
                      },
                    ),
                  ),

                  // SizedBox(
                  //   height: 50.sp,
                  // ),
                ],
              ),
      ),
    );
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

  Future<bool> _removeUserData(String field) async {
    try {
      // Remove the specified field from all users
      QuerySnapshot usersSnapshot = await _firestore.collection('users').get();
      for (DocumentSnapshot userSnapshot in usersSnapshot.docs) {
        await userSnapshot.reference.update({field: FieldValue.delete()});
      }
      return true; // Success
    } catch (error) {
      // print('Error removing user data: $error');
      return false; // Failure
    }
  }

  void _showAddDialog() async {
    String? field;
    String? value;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add/Update Data',
            style: TextStyle(fontSize: 60.sp, color: Colors.black),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                style: TextStyle(fontSize: 60.sp, color: Colors.black),
                onChanged: (text) => field = text,
                decoration: const InputDecoration(
                  labelText: 'Field',
                ),
              ),
              TextField(
                style: TextStyle(fontSize: 60.sp, color: Colors.black),
                onChanged: (text) => value = text,
                decoration: const InputDecoration(labelText: 'Value'),
              ),
            ],
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
                'Add/Update',
                style: TextStyle(fontSize: 60.sp, color: Colors.black),
              ),
              onPressed: () async {
                // Perform add/update operation here based on the selectedUser, field, and value
                // You can use _firestore to add/update data

                // After the operation is complete, show a snackbar message

                final success = _addUserData(field!, value!);
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

  Future<bool> _addUserData(String field, String value) async {
    try {
      // Add the data to all users
      QuerySnapshot usersSnapshot = await _firestore.collection('users').get();
      for (DocumentSnapshot userSnapshot in usersSnapshot.docs) {
        await userSnapshot.reference.update({field: value});
      }
      return true; // Success
    } catch (error) {
      // print('Error adding user data: $error');
      return false; // Failure
    }
  }

  Stream<List<UserModel>> _fetchUserList() {
    try {
      Stream<QuerySnapshot> usersStream = _firestore
          .collection('users')
          .orderBy('timestmap', descending: true)
          .snapshots();

      return usersStream.map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return UserModel(
            uid: doc.id,
            email: doc.get('email'),
            name: doc.get('name'),
            mobile: doc.get('contactNumber'),
            dateTime: doc.get('timestmap'),
          );
        }).toList();
      });
    } catch (error) {
      // print('Error fetching user list: $error');
      return const Stream.empty(); // Return an empty stream in case of an error
    }
  }
}

class UserModel {
  String? uid;
  String? email;
  String? name;
  String? mobile;
  Timestamp? dateTime;

  UserModel({this.uid, this.email, this.name, this.mobile, this.dateTime});
}

class AdminsmallBlueWhiteBox extends StatelessWidget {
  final UserModel userData;

  const AdminsmallBlueWhiteBox({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.blue, width: 0.4),
          borderRadius: BorderRadius.circular(15.0),
        ),
        tileColor: Colors.white,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminPageUserDetail(
                        uid: "${userData.uid}",
                      )));
        },
        title: Text(
          '${userData.name}',
          style: const TextStyle(color: Colors.blue),
        ),
        subtitle: Text(
            '${userData.email}\n${userData.mobile}\nDate:${userData.dateTime!.toDate().day}/${userData.dateTime!.toDate().month}/${userData.dateTime!.toDate().year}'),
        trailing: const Icon(Icons.remove_red_eye_outlined),
      ),
    );
  }
}
