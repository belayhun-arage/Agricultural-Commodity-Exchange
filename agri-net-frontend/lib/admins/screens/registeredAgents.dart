import '../../libs.dart';

class RegisteredAgentsScreen extends StatefulWidget {
  static String RouteName = "agents";
  const RegisteredAgentsScreen({Key? key}) : super(key: key);

  @override
  State<RegisteredAgentsScreen> createState() => _RegisteredAgentsScreenState();
}

class _RegisteredAgentsScreenState extends State<RegisteredAgentsScreen> {
  @override
  void initState() {
    super.initState();
    print("Init state");
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      final UserBloc _userBloc = BlocProvider.of<UserBloc>(context);
      if ((_userBloc.state is Authenticated)) {
        print("SchedulerBinding state");
        BlocProvider.of<AdminsBloc>(context).add(GetAllAgentsEvent(
            admin: (_userBloc.state as Authenticated).user as Admin));
      } else {
        print("Exception state");
        throw Exception("Not an admin");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 5,
        toolbarHeight: MediaQuery.of(context).size.height / 13,
        leading: IconButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: BackButton()),
        title: Text(
          "Registered Agents",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RegisterAgentForm.RouteName);
                },
                icon: Icon(Icons.add),
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterAgentForm()),
                    );
                  },
                  child: Text(
                    "New",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<AdminsBloc, AdminsState>(builder: (context, state) {
        if (state is GetAllAgentsState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is AllAgentsFechedState) {
          return Column(
            children: [
              Expanded(
                child: agentRow(state.agentsList),
              ),
            ],
          );
        }
        if (state is NoAgentsFoundState) {
          return Center(child: Text("You have no agent registered Yet!"));
        }
        if (state is FailedToFechAgentsState) {
          return Column(
            children: [
              Center(child: Text("Sorry Some thing went wrong!")),
            ],
          );
        }
        return Center(child: CircularProgressIndicator());
      }),
    );
  }

  Widget agentRow(List<Agent> agents) {
    return Flexible(
      child: ListView.builder(
          itemCount: agents.length,
          itemBuilder: (context, counter) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
              child: Material(
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserProfileScreen(
                                    requestedUser: agents[counter],
                                  ),
                                ),
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                child: ClipOval(
                                  child: (agents[counter].imgurl != '')
                                      ? Image.asset(
                                          agents[counter].imgurl,
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                        )
                                      : Icon(
                                          Icons.person,
                                        ),
                                ),
                              ),
                              SizedBox(
                                width: 7.5,
                              ),
                              Text(agents[counter].firstname),
                              SizedBox(
                                width: 7.5,
                              ),
                              Text(agents[counter].firstname)
                            ],
                          ),
                        ),
                        IconButton(onPressed: () {}, icon: Icon(Icons.delete))
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
