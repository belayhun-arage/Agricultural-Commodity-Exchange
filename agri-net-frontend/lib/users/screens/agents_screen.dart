import '../../libs.dart';

class AgentsScreen extends StatefulWidget {
  static const String RouteName = "/agents/screen";
  const AgentsScreen({Key? key}) : super(key: key);

  @override
  State<AgentsScreen> createState() => _AgentsScreenState();
}

class _AgentsScreenState extends State<AgentsScreen> {
  bool agentsList = true;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        toolbarHeight: MediaQuery.of(context).size.height / 13,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: BackButton(),
        ),
        title: Text(
          agentsList ? " Agents " : " Create Agent ",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Text(
                "New",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {
              // Navigator.of(context).pushNamed(ProductForm.RouteName);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (agentsList) {
            pageController.nextPage(
              duration: Duration(
                milliseconds: 500,
              ),
              curve: Curves.ease,
            );
          } else {
            pageController.previousPage(
              duration: Duration(
                milliseconds: 500,
              ),
              curve: Curves.ease,
            );
          }
        },
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        child: Icon(
          agentsList ? Icons.add : Icons.list,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: Container(
        child: PageView(
          controller: pageController,
          onPageChanged: (val) {
            setState(() {
              if (val == 0) {
                agentsList = true;
              } else {
                agentsList = false;
              }
            });
          },
          children: [AgentsList(), AgentInstanceForm()],
        ),
      ),
    );
  }
}
