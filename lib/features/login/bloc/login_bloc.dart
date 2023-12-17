import 'package:bloc/bloc.dart';
import '../../../models/student.dart';
import '../../../models/teacher.dart';
import '../../../services/database.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<StudentLoginButtonClickedEvent>(studentLoginButtonClicked);
    on<TeacherLoginButtonClickedEvent>(teacherLoginButtonClicked);
    // on<StudentLoginSuccessEvent>(studentLoginSuccess);
    // on<TeacherLoginSuccessEvent>(teacherLoginSuccess);
  }

  void studentLoginButtonClicked(StudentLoginButtonClickedEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    var result = await Database.verifyStudent(event.email, event.password);
    if (result != null) {
      emit(LoginSuccess(student: result));
    } else {
      emit(LoginFailure(message: 'Invalid Credentials'));
    }
  }

  void teacherLoginButtonClicked(TeacherLoginButtonClickedEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    var result = await Database.verifyTeacher(event.email, event.password);
    if (result != null) {
      emit(LoginSuccess(teacher: result));
    } else {
      emit(LoginFailure(message: 'Invalid Credentials'));
    }
  }
}
