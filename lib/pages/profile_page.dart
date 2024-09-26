import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rethink/firebase/authentication.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = Authentication.auth.currentUser;
    return Scaffold(
        body: Center(
            child: user != null
                ? profile(user)
                : FilledButton.icon(
                    onPressed: Authentication.signInWithGoogle,
                    label: const Text('Sign in with Google'),
                    icon: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FaIcon(FontAwesomeIcons.google)))));
  }

  Widget profile(User user) => Column(children: [
        CircleAvatar(
            radius: 40,
            foregroundImage: CachedNetworkImageProvider(user.photoURL ?? ''),
            child: Text(user.displayName ?? ''))
      ]);
}
