import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:moodle/repositories/auth_repo.dart';
import 'package:moodle/screens/auth/auth_page.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<AuthSignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.signUp(event.email, event.password, event.role);
        emit(Authenticated(event.role));
      } catch (e) {
        emit(Autherror("Sign-up failed: ${e.toString()}"));
        print("Sign-up failed: ${e.toString()}");
      }
    });
    on<AuthLoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.login(event.email, event.password);
        add(AuthCheckRole(FirebaseAuth.instance.currentUser!.uid));
      } catch (e) {
        emit(Autherror("Login failed: ${e.toString()}"));
        print("Login failed because: ${e.toString()}");
      }
    });
    on<AuthCheckRole>((event, emit) async {
      try {
        UserRole? role = await authRepository.getUserRole(event.uid);
        if (role != null) {
          emit(Authenticated(role));
        } else {
          emit(Autherror("User role not found"));
        }
      } catch (e) {
        emit(Autherror("Role check failed; ${e.toString()}"));
      }
    });
  }
}
