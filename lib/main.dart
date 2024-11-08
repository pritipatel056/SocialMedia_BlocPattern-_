import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mariadda_app/screens/home/home_screen.dart';
import 'package:mariadda_app/screens/home/profile_screen.dart';
import 'package:mariadda_app/screens/profile/ProfileScreenDeepLink.dart';
import 'package:user_repository/user_repository.dart';

import 'app.dart';
import 'simple_bloc_observer.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await Firebase.initializeApp();
	Bloc.observer = SimpleBlocObserver();
//  runApp(MyApp(FirebaseUserRepo()));
  runApp(MyAppProfile());
}

class MyAppProfile extends StatefulWidget {
	@override
	_MyAppProfile  createState() => _MyAppProfile();
}

class _MyAppProfile extends State<MyAppProfile> {
	late String userId;
	@override
	void initState() {
		super.initState();
		_setupDynamicLinks();
	}

	void _setupDynamicLinks() async {
		FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
		//https//:mariaddafeture.page.link
			// https://mariaddafeture.page.link/6SuK
			final Uri deepLink = dynamicLinkData.link;
			if (deepLink.pathSegments.contains('profile')) {
				String userId	 = deepLink.pathSegments.last;
				Navigator.push(
					context,
					MaterialPageRoute(
						builder: (context) =>  ProfileScreenDeepLink(  userId: userId),
					),
				);
			}
		});
	}

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			home: MyApp(FirebaseUserRepo()),
			routes: {
				'/profile': (context) => ProfileScreenDeepLink(  userId: userId)
			},
		);


}}
