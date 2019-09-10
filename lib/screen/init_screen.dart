import 'package:flutter_web/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sp_client/bloc/blocs.dart';
import 'package:sp_client/util/config.dart';
import 'package:sp_client/util/localization.dart';

class InitScreen extends StatefulWidget {
  final String userId;

  InitScreen({
    Key key,
    @required this.userId,
  });

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  AuthBloc _authBloc;
  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    if (!AppConfig.runOnWeb) {
      _loginBloc.dispatch(LoginSubmitted(widget.userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      bloc: _loginBloc,
      listener: (BuildContext context, LoginState state) {
        if (state.isSuccess) {
          _authBloc.dispatch(LoggedIn());
        } else {
          _loginBloc.dispatch(LoginSubmitted(widget.userId));
        }
      },
      child: Scaffold(
        appBar: AppBar(elevation: 0),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(height: 24.0),
              Text(AppLocalizations.of(context).labelAppInitialize),
            ],
          ),
        ),
      ),
    );
  }
}
