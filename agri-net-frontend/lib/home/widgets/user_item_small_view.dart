import "../../libs.dart";
import "package:flutter/material.dart";

class UserSmallViewItem extends StatelessWidget {
  int userid;
  int storeid;
  UserSmallViewItem({this.storeid = 0, this.userid = 0});

  @override
  Widget build(BuildContext context) {
    if (context.watch<UsersBloc>().state is UsersLoadedState) {
      print((context.watch<UsersBloc>().state as UsersLoadedState).merchants);
    } else {
      print("The Users Status is not in the users loaded state ");
    }
    final a = (context.watch<UsersBloc>().getUserByID(userid) ??
        context.watch<UsersBloc>().getMerchantByStoreID(storeid));
    String role = a is Merchant
        ? ROLE_MERCHANT
        : (a is Agent
            ? ROLE_AGENT
            : (a is Admin
                ? ROLE_ADMIN
                : (a is SuperAdmin ? ROLE_SUPERADMIN : ROLE_AGENT)));
    print("$userid and $storeid $role $a");
    return this.userid > 0 || this.storeid > 0
        ? Container(
            child: ((context.watch<UsersBloc>().state is UsersLoadedState) &&
                    ((a) == null))
                ? Container(
                    child: Column(children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ]),
                  )
                : Stack(
                    children: [
                      Container(
                        child: Column(children: [
                          Text(a!.firstname),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: a.imgurl == ""
                                          ? Image.asset(
                                              'assets/images/logo.jpg',
                                              width: 80,
                                              height: 80,
                                            )
                                          : Image.network(
                                              a.imgurl,
                                            ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  translate(lang, "Fullname"),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(" : "),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Text(
                                                    " ${a.firstname} ${a.lastname} "),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  translate(lang, "Phone"),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(" : "),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Text("${a.phone}"),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  translate(lang, "Joined "),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(" : "),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Text(
                                                    "${(UnixTime(((a.createdAt ?? DateTime.now()).microsecondsSinceEpoch / 1000).round())).toString()}  ${translate(lang, " before ")}"),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                      ),
                      (role == ROLE_AGENT || role == ROLE_MERCHANT)
                          ? Positioned(
                              bottom: 10,
                              right: 10,
                              child: IconButton(
                                icon: Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  if (role == ROLE_AGENT) {
                                    showMap(
                                      context,
                                      (a as Agent).address.Latitude,
                                      a.address.Longitude,
                                      title: translate(lang, "User address"),
                                    );
                                  } else {
                                    if (role == ROLE_MERCHANT) {
                                      showMap(
                                        context,
                                        (a as Merchant).address.Latitude,
                                        a.address.Longitude,
                                        title: translate(lang, "User address"),
                                      );
                                    }
                                  }
                                },
                              ))
                          : SizedBox()
                    ],
                  ),
          )
        : SizedBox();
  }
}
