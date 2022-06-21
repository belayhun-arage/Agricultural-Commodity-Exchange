import '../../libs.dart';

class AgentsBloc extends Bloc<AgentsEvent, AgentsState>
    implements Cubit<AgentsState> {
  AgentRepo agentRepo;
  AgentsBloc({required this.agentRepo}) : super(AgentsInItState()) {
    on<LoadMyAgentsEvent>((event, emit) async {
      if (!(this.state is AgentsLoadedState)) {
        emit(AgentsLoadingState());
      }
      final response = await agentRepo.getAgents(event.adminID);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (this.state is AgentsLoadedState) {
          (this.state as AgentsLoadedState).agentsList.addAll(response.agents);
          emit(this.state);
        } else {
          emit(AgentsLoadedState(agentsList: response.agents));
        }
      } else {
        emit(AgentsLoadingFailedState(
            statusCode: response.statusCode, msg: response.msg));
      }
    });
  }

  Future<UserRegisterResponse> registerAgent(
      NewAgentEvent creatNewAgentEvent) async {
    final newAgentResponse = await agentRepo.creatNewAgent(
        creatNewAgentEvent.firstname,
        creatNewAgentEvent.lastname,
        creatNewAgentEvent.email,
        creatNewAgentEvent.phone,
        creatNewAgentEvent.city,
        creatNewAgentEvent.kebele,
        creatNewAgentEvent.woreda,
        creatNewAgentEvent.zone,
        creatNewAgentEvent.region,
        creatNewAgentEvent.unique_address,
        creatNewAgentEvent.latitude,
        creatNewAgentEvent.longitude);
    return newAgentResponse;
  }
}
