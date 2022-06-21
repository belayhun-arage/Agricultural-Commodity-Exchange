import '../../libs.dart';

class AgentsState {}

class AgentsInItState extends AgentsState {}

class AgentsLoadedState extends AgentsState {
  List<Agent> agentsList;
  AgentsLoadedState({required this.agentsList});
}

class AgentsLoadingState extends AgentsState {}

class AgentsLoadingFailedState extends AgentsState {
  int statusCode;
  String msg;
  AgentsLoadingFailedState({required this.statusCode, required this.msg});
}
