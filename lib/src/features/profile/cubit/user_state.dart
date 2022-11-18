// part of 'user_cubit.dart';

// abstract class UserState extends Equatable {
//   const UserState({
//     required this.profileUser,
//   });

//   final ProfileUser? profileUser;

//   @override
//   List<Object?> get props => [
//         profileUser,
//       ];
// }

// class UserInitial extends UserState {
//   const UserInitial({
//     required super.profileUser,
//   });
// }

// class NewUserState extends UserState {
//   NewUserState.fromOldSettingState(
//     UserState oldState, {
//     ProfileUser? profileUser,
//   }) : super(
//           profileUser: profileUser ?? oldState.profileUser,
//         );
// }
