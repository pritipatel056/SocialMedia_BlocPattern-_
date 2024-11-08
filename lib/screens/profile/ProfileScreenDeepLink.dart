// screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_plus/share_plus.dart';
import 'model/UserModel.dart';

class ProfileScreenDeepLink extends StatefulWidget {
  final String userId;
  ProfileScreenDeepLink({required this.userId});

  @override
  _ProfileScreenDeepLinkState createState() => _ProfileScreenDeepLinkState();
}

class _ProfileScreenDeepLinkState extends State<ProfileScreenDeepLink> {
  UserModel? user;
  List<UserModel> mutualFriends = [];

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    // Fetch user data from Firestore
    DocumentSnapshot userDoc =
    await FirebaseFirestore.instance.collection('users').doc(widget.userId).get();

    if (userDoc.exists) {
      setState(() {
        user = UserModel.fromDocument(userDoc.data() as Map<String, dynamic>);
      });
      _fetchMutualFriends();
    }
  }

  Future<void> _fetchMutualFriends() async {
    if (user == null) return;

    // Fetch current user (logged-in user)
    String currentUserId = "CURRENT_USER_ID"; // Replace with logged-in user ID
    DocumentSnapshot currentUserDoc =
    await FirebaseFirestore.instance.collection('users').doc(currentUserId).get();

    List<String> currentUserFriends =
    List<String>.from((currentUserDoc.data() as Map<String, dynamic>)['friends'] ?? []);

    // Identify mutual friends
    List<String> mutualFriendIds =
    currentUserFriends.where((friendId) => user!.friends.contains(friendId)).toList();

    // Fetch mutual friends details
    for (String friendId in mutualFriendIds) {
      DocumentSnapshot friendDoc =
      await FirebaseFirestore.instance.collection('users').doc(friendId).get();
      if (friendDoc.exists) {
        mutualFriends.add(UserModel.fromDocument(friendDoc.data() as Map<String, dynamic>));
      }
    }
    setState(() {});
  }

  void _shareProfile() {
    if (user != null) {
      Share.share("Check out ${user!.name}'s profile: myapp://profile/${user!.id}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user!.profilePicUrl),
            radius: 50,
          ),
          SizedBox(height: 10),
          Text(user!.name, style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _shareProfile,
            child: Text("Share Profile"),
          ),
          SizedBox(height: 20),
          Text("Mutual Friends", style: TextStyle(fontSize: 18)),
          Expanded(
            child: ListView.builder(
              itemCount: mutualFriends.length,
              itemBuilder: (context, index) {
                final friend = mutualFriends[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(friend.profilePicUrl),
                  ),
                  title: Text(friend.name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
