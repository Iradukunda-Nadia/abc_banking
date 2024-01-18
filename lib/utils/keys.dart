

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Keys {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");
  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore  firebaseFirestore = FirebaseFirestore.instance;
}