// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import 'application/auth/auth_bloc.dart';
import 'application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'application/notes/note_actor/note_actor_bloc.dart';
import 'application/notes/note_form/note_form_bloc.dart';
import 'application/notes/note_watcher/note_watcher_bloc.dart';
import 'domain/auth/i_auth_facade.dart';
import 'domain/notes/i_note_repository.dart';
import 'infrastructure/auth/firebase_auth_facade.dart';
import 'infrastructure/core/firebase_injectable_module.dart';
import 'infrastructure/notes/note_repository.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

void $initGetIt(GetIt g, {String environment}) {
  final gh = GetItHelper(g, environment);
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.lazySingleton<FirebaseAuth>(() => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<Firestore>(() => firebaseInjectableModule.firestore);
  gh.lazySingleton<GoogleSignIn>(() => firebaseInjectableModule.googleSignIn);
  gh.lazySingleton<IAuthFacade>(
      () => FirebaseAuthFacade(g<FirebaseAuth>(), g<GoogleSignIn>()));
  gh.lazySingleton<INoteRepository>(() => NoteRepository(g<Firestore>()));
  gh.factory<NoteActorBloc>(() => NoteActorBloc(g<INoteRepository>()));
  gh.factory<NoteFormBloc>(() => NoteFormBloc(g<INoteRepository>()));
  gh.factory<NoteWatcherBloc>(() => NoteWatcherBloc(g<INoteRepository>()));
  gh.factory<SignInFormBloc>(() => SignInFormBloc(g<IAuthFacade>()));
  gh.factory<AuthBloc>(() => AuthBloc(g<IAuthFacade>()));
}

class _$FirebaseInjectableModule extends FirebaseInjectableModule {}
