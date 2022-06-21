import "../../libs.dart";

class LoginWidget extends StatefulWidget {
  Function forgotFunction;
  BuildContext screenContext;
  LoginWidget(this.forgotFunction, this.screenContext, {Key? key})
      : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool logging = false;
  bool hidePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: EdgeInsets.all(5),
          child: Text(
            " Login ",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontFamily: "Moms TypeWriter",
              fontSize: 22,
              // fontSize: 18
            ),
          ),
        ),
        Container(
          child: BlocBuilder<UserBloc, UserState>(
            builder: (contexts, state) {
              if (state is Authenticated) {
                return Text(
                  "",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Elegant TypeWriter",
                    // fontSize: 18
                  ),
                );
              } else if (state is NotAuthenticated) {
                return Container(
                  // width: 40,
                  height: 40,
                  child: Text(
                    " ${state.Msg} ",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Elegant TypeWriter",
                      // fontSize: 18,
                    ),
                  ),
                );
              } else if (state is UserLoginOnProgressState) {
                return Container(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                    strokeWidth: 3,
                  ),
                );
              }
              return Text(
                "  ",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Elegant TypeWriter",
                  // fontSize: 18,
                ),
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: TextField(
            cursorColor: Theme.of(context).primaryColorLight,
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Email or Phone",
              fillColor: Theme.of(context).primaryColorLight,
              hoverColor: Theme.of(context).primaryColorLight,
              suffixIcon: Icon(Icons.mail_outline),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColorLight,
                  style: BorderStyle.none,
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextField(
            cursorColor: Theme.of(context).primaryColorLight,
            obscureText: hidePassword,
            controller: passwordController,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(),
              suffix: GestureDetector(
                  child: hidePassword
                      ? Image.asset('assets/icons/icons8-eyelashes-3d-30.png',
                          color: Theme.of(context).primaryColor,
                          width: 20,
                          height: 20)
                      : Image.asset(
                          'assets/icons/icons8-eyebrow-30.png',
                          color: Theme.of(context).primaryColor,
                          width: 20,
                          height: 20,
                          errorBuilder: (context, stg, stgh) {
                            return Icon(Icons.security,
                                color: Theme.of(context).primaryColor);
                          },
                        ),
                  onTap: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  }),
            ),
          ),
        ),
        Container(
          child: Stack(children: [
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor),
                animationDuration: Duration(seconds: 1),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 10,
                  ),
                ),
                elevation: MaterialStateProperty.all<double>(0),
              ),
              onPressed: () async {
                // checking the validity of input values
                if ((StaticDataStore.isEmail(emailController.text) ||
                        MatchesPattern(emailController.text, PhoneRegexp)) &&
                    passwordController.text == "") {
                  context.read<UserBloc>().add(UserLoginNotSuccesfulEvent(
                      "please fill your email/phone and password"));
                  return;
                } else if (emailController.text == "") {
                  context.read<UserBloc>().add(UserLoginNotSuccesfulEvent(
                      "please fill the email/phone entry"));
                  return;
                } else if (passwordController.text == "") {
                  context.read<UserBloc>().add(
                      UserLoginNotSuccesfulEvent("Please fill the password"));
                  return;
                } else if (!(StaticDataStore.isEmail(emailController.text) ||
                    MatchesPattern(emailController.text, PhoneRegexp))) {
                  context.read<UserBloc>().add(UserLoginNotSuccesfulEvent(
                      "Invalid email/phone address"));
                  return;
                }
                if (emailController.text != "" &&
                    passwordController.text != "") {
                  // Either the email controller or the password controller are empty string.
                  context.read<UserBloc>().add(UserLoginInProgressEvent());
                  String dtext = emailController.text;
                  if (MatchesPattern(emailController.text, PhoneRegexp) &&
                      (emailController.text.trim()[0] == "0")) {
                    dtext = emailController.text.substring(1);
                    dtext = "+251" + dtext;
                  }
                  //
                  final userSate = await context
                      .read<UserBloc>()
                      .login(UserLoginEvent(dtext, passwordController.text));
                  if (userSate is Authenticated) {
                    Navigator.of(context).pushNamed(HomeScreen.RouteName);
                    setState(() {});
                    context
                        .read<UserBloc>()
                        .add(UserLoggedInEvent(userSate.user, userSate.role));
                  } else if (userSate is NotAuthenticated) {
                    context
                        .read<UserBloc>()
                        .add(UserLoginNotSuccesfulEvent(userSate.Msg));
                  } else if (userSate is UserLoginOnProgressState) {
                    context.read<UserBloc>().add(UserLoginInProgressEvent());
                  }
                }
              },
              icon: Icon(Icons.login),
              label: Text(
                " Login ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // !(context.watch<AuthBloc>().state is AuthAdminLoginOnProgress)
          ]),
        ),
        // GestureDetector(
        //   onTap: () {
        //     widget.forgotFunction();
        //   },
        //   child: Container(
        //     padding: EdgeInsets.all(10),
        //     child: Text(
        //       "forgot password ",
        //       style: TextStyle(
        //         fontWeight: FontWeight.bold,
        //         color: Theme.of(context).primaryColor,
        //       ),
        //     ),
        //   ),
        // )
        FlatButton(
            child: Text(
              "Confirmation ",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.blue,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(ConfirmationScreen.RouteName, );
            }),
      ],
    );
  }
}
