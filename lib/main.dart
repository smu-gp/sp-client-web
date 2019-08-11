import 'package:bloc/bloc.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:flutter_web/material.dart';
import 'package:sp_client/app.dart';
import 'package:sp_client/bloc/simple_bloc_delegate.dart';
import 'package:sp_client/repository/repositories.dart';

void main() async {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  fb.initializeApp(
    apiKey: 'AIzaSyAgVki9oTGUgsScsVa5cWZWiVn6Ss6NPho',
    authDomain: 'smu-gp.firebaseapp.com',
    databaseURL: "https://smu-gp.firebaseio.com",
    storageBucket: "smu-gp.appspot.com",
    projectId: 'smu-gp',
  );

  runApp(App(
    preferenceRepository: LocalPreferenceRepository(),
  ));
}
