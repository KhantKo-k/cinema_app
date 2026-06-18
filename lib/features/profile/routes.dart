import 'package:cinema_app/core/navigation/app_router.dart';
import 'package:cinema_app/features/profile/domain/entity/profile_entity.dart';
import 'package:cinema_app/features/profile/presentation/pages/about_page.dart';
import 'package:cinema_app/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:cinema_app/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileRoutes {
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String about = '/about';


  static final shellRoutes = [
    GoRoute(
      path: profile,
      builder: (context, state) {
        return ProfilePage();
      }
    )
  ];

  static final routes = [
    GoRoute(
      path: editProfile,
      builder: (context, state) {
        final profile = state.extra as ProfileEntity?;
        if(profile == null) {
          return const Scaffold(
            body: Center(child: Text('Profile data maissing'),),
          );
        }

        return EditProfilePage(profile: profile);
      },
    )
    ,
    GoRoute(
      path: about,
      builder: (context, state) => const AboutPage(),
    ),
  ];
}

extension ProfileRoutesExtension on AppRouter{
  void naviagetToProfiel(){
    router.go(ProfileRoutes.profile);
  }

  void navigateToEditProfile(ProfileEntity profile) {
    router.push(
      ProfileRoutes.editProfile,
      extra: profile,
    );
  }

  void navigateToAbout() {
    router.push(ProfileRoutes.about);
  }
}