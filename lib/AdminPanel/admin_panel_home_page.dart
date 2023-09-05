import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kt1_textile_calculation/Authentication/Login%20Screen/login_page.dart';
import '../Constants/Global_Widgets/Appbar/appbar_with_action.dart';
import '../Constants/Global_Widgets/Search Bar/search_bar.dart';
import '../Screens/Home_page/home_page.dart';
import 'admin_page_user_detail.dart';

class AdminPanelHome extends StatefulWidget {
  const AdminPanelHome({super.key});

  @override
  State<AdminPanelHome> createState() => _AdminPanelHomeState();
}

class _AdminPanelHomeState extends State<AdminPanelHome> {
  bool isadmin = true;
  bool isloading = true;
  bool isRefreshing = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore db = FirebaseFirestore.instance;

  static Map<String, int?> itemCounts = {
    'users': null,
    'Counters': null,
    'advertise link': null,
    // 'SpinningMill Dictionary': null,
    // 'WeavingMill Dictionary': null,
    // '1 Kappas BT': null,
    // '2 Cotton Bales BT': null,
    // '3 Cotton Seed BT': null,
    // '4 Cotton Yarn BT': null,
    // '5 Cotton Waste BT': null,
    // '6 Cotton Cloth BT': null,
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

  //Log Out
  Future<void> logout() async {
    try {
      await _auth.signOut();
      // Sign out from Google account
      await googleSignIn.signOut();
      // Navigate back to the login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (error) {
      SnackBar snackBar = SnackBar(content: Text('Logout error: $error'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Scaffold(
      appBar: AppbarWithAction(
        appbarText: 'TC Admin Panel',
        appbarIcon: Icons.logout,
        appbarIconOnPress: () {
          logout();
        },
        centerTitle: true,
      ),
      body: Container(
        margin:
            EdgeInsets.only(left: 40.w, right: 40.w, top: 40.h, bottom: 0.h),
        child: RefreshIndicator(
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
                    Container(
                      margin: EdgeInsets.only(
                          left: 10.sp, right: 10.sp, bottom: 20.sp),
                      // height: 330.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          width: 0.2,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40.sp),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1,
                            color: Colors.grey.withOpacity(1),
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => UserList()));
                        },
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 100.sp,
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  ('Total User'),
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 60.sp,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Text(
                                  '${itemCounts['users']}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 70.sp),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    //Update and remove Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          onPressed: _showAddDialog,
                          label: const Text('Add Field All User'),
                          icon: Icon(
                            Icons.add,
                            size: 50.sp,
                          ),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          onPressed: _showRemoveDialog,
                          label: const Text('Remove Field All User'),
                          icon: Icon(
                            Icons.remove,
                            size: 50.sp,
                          ),
                        ),
                      ],
                    ),

                    SearchbarWithIcon(
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
                                    detailPageCollecationName: '',
                                    imagepath: '',
                                    userdata: user,
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    UserModel user = filteredList[index];

                                    // Build each list item
                                    return AdminsmallBlueWhiteBox(
                                      detailPageCollecationName: '',
                                      imagepath: '',
                                      userdata: user,
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
      ),
      floatingActionButton: keyboardIsOpened
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: const Icon(Icons.home),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
      Stream<QuerySnapshot> usersStream =
          _firestore.collection('users').snapshots();

      return usersStream.map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return UserModel(
              uid: doc.id,
              email: doc.get('email'),
              name: doc.get('name'),
              mobile: '');
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

  UserModel({this.uid, this.email, this.name, this.mobile});
}

class AdminsmallBlueWhiteBox extends StatelessWidget {
  final UserModel userdata;
  final String detailPageCollecationName;

  final String imagepath;
  const AdminsmallBlueWhiteBox(
      {super.key,
      required this.userdata,
      required this.detailPageCollecationName,
      required this.imagepath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 20.sp),
      // height: 330.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
          width: 0.2,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.sp),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: Colors.grey.withOpacity(1),
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminPageUserDetail(
                        uid: "${userdata.uid}",
                      )));
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ('${userdata.name}'),
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 50.sp,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Text(
                          '${userdata.email}',
                          style: TextStyle(
                              fontSize: 40.sp,
                              color: Colors.black,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminPageUserDetail(
                                    uid: "${userdata.uid}",
                                  )));
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.black,
                      size: 100.sp,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
