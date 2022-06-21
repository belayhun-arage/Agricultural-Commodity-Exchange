import "../../libs.dart";

class ForgotPassword extends StatefulWidget {
  Function loginWidgetFunction;
  ForgotPassword(this.loginWidgetFunction, {Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  String forgotPasswordMessage = "";
  Color forgotPasswordMessageColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 10,
          left: 10,
          child: GestureDetector(
            onTap: () {
              widget.loginWidgetFunction();
            },
            child: Container(
              child: Icon(
                Icons.arrow_back,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<UserBloc, UserState>(builder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  // color: Theme.of(context).primaryColor,
                  border: Border.all(
                    color: () {
                      if (state
                          is UserPasswordSentLoginAndChangePasswordState) {
                        return Colors.green;
                      } else if (state is AuthForgotPasswordRequestFailed) {
                        return Colors.red;
                      }
                      return Colors.white;
                    }(),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(15),
                child: () {
                  if (state is UserForgotPasswordInProgressState) {
                    return CircularProgressIndicator();
                  } else if (state
                      is UserPasswordSentLoginAndChangePasswordState) {
                    widget.loginWidgetFunction();
                    return Text(
                      " forgoten email sent to your email",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else if (state is AuthForgotPasswordRequestFailed) {
                    return Text(
                      state.message,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  return Text(
                    "",
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  );
                }(),
              );
            }),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                " Forgot Password ",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                forgotPasswordMessage,
                style: TextStyle(
                  color: forgotPasswordMessageColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  focusColor: Theme.of(context).primaryColorLight,
                  labelText: "email",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(30),
              child: FlatButton.icon(
                onPressed: () async {
                  if (emailController.text != "") {
                    context
                        .read<UserBloc>()
                        .add(UserForgotPasswordEvent(emailController.text));
                  }
                },
                icon: Icon(Icons.send_to_mobile),
                label: Text(" Sent Email "),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
