import '../../libs.dart';

class RegisteredAgentsScreen extends StatefulWidget {
  const RegisteredAgentsScreen({Key? key}) : super(key: key);

  @override
  State<RegisteredAgentsScreen> createState() => _RegisteredAgentsScreenState();
}

class _RegisteredAgentsScreenState extends State<RegisteredAgentsScreen> {
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
                  Navigator.of(context).pushNamed(RegisterAdminPage.RouteName);
                },
                icon: Icon(Icons.add),
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(RegisterAdminPage.RouteName);
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
        if (state is NoAdminFoundState) {
          return Column(
            children: [
              Text("No User is registered yet!"),
            ],
          );
        }
        return Column(
          children: [
            Text("Some thing went wrong"),
          ],
        );
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/images/pp.jpg",
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 7.5,
                            ),
                            Text(agents[counter].postCount.toString()),
                            Text(agents[counter].postCount.toString()),
                          ],
                        ),
                        Text(StaticDataStore.ROLE),
                        IconButton(onPressed: () {}, icon: Icon(Icons.edit))
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
