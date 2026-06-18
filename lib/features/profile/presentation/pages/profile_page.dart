import 'package:cinema_app/core/auth/bloc/auth_bloc.dart';
import 'package:cinema_app/core/auth/bloc/auth_event.dart';
import 'package:cinema_app/core/auth/bloc/auth_state.dart';
import 'package:cinema_app/core/di/service_locator.dart';
import 'package:cinema_app/core/navigation/app_router.dart';
import 'package:cinema_app/core/theme/app_color.dart';
import 'package:cinema_app/features/profile/domain/entity/profile_entity.dart';
import 'package:cinema_app/features/profile/presentation/providers/profile_provider.dart';
import 'package:cinema_app/features/profile/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            final uid = state.userAuthModel.uid;

            return Consumer(
              builder: (context, ref, child) {
                final profileAsync = ref.watch(
                  userProfileProvider(userId: uid),
                );

                return profileAsync.when(
                  loading: () => Center(
                    child: CircularProgressIndicator(
                      color: AppColors.electricBlue,
                    ),
                  ),
                  error: (e, _) => Center(
                    child: Text(
                      'Error: $e',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  data: (profile) {
                    final firstLetter = profile.name.isNotEmpty
                        ? profile.name[0].toUpperCase()
                        : '?';

                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 120,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Profile',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: cs.onSurface,
                              ),
                            ),
                          ),

                          Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: AppColors.electricBlue,
                                child: Text(
                                  firstLetter,
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: cs.onSurface,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      profile.name,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: cs.onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      profile.email,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: cs.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),

                          _buildActionRow(
                            icon: Icons.person_outline,
                            title: 'Profile Update',
                            subtitle: 'Edit your personal information',
                            iconColor: AppColors.electricBlue,
                            cs: cs,
                            onTap: () {
                                _navigateToEditProfile(profile);
                            },
                          ),
                          Divider(
                            color: cs.onSurfaceVariant.withOpacity(0.4),
                            height: 1,
                          ),
                          _buildActionRow(
                            icon: Icons.confirmation_num,
                            title: 'My Tickets',
                            subtitle: 'Your tickets',
                            iconColor: AppColors.electricBlue,
                            cs: cs,
                            onTap: () {
                              
                            },
                          ),
                          Divider(
                            color: cs.onSurfaceVariant.withOpacity(0.4),
                            height: 1,
                          ),
                          _buildActionRow(
                            icon: Icons.help_outline,
                            title: 'About',
                            subtitle: 'Meet our professionals',
                            iconColor: AppColors.electricBlue,
                            cs: cs,
                            onTap: () {
                              _navigateToAbout();
                            },
                          ),
                          Divider(
                            color: cs.onSurfaceVariant.withOpacity(0.4),
                            height: 1,
                          ),
                          _buildActionRow(
                            icon: Icons.lock_person_outlined,
                            title: 'Privacy Policy',
                            subtitle: 'Privacy Policy',
                            iconColor: AppColors.electricBlue,
                            cs: cs,
                            onTap: () {
                              // Navigate to Edit Profile
                            },
                          ),
                          Divider(
                            color: cs.onSurfaceVariant.withOpacity(0.4),
                            height: 1,
                          ),
                          _buildActionRow(
                            icon: Icons.rate_review_outlined,
                            title: 'Suggestion',
                            subtitle: 'Give your suggestion',
                            iconColor: AppColors.electricBlue,
                            cs: cs,
                            onTap: () {
                              // Navigate to Edit Profile
                            },
                          ),

                          Divider(
                            color: cs.onSurfaceVariant.withOpacity(0.4),
                            height: 1,
                          ),
                          _buildActionRow(
                            icon: Icons.logout_rounded,
                            title: 'Logout',
                            subtitle: 'Sign out of your account',
                            iconColor: AppColors.electricBlue,
                            cs: cs,
                            onTap: () {
                              _showLogoutDialog(context);
                            },
                          ),
                          Divider(
                            color: cs.onSurfaceVariant.withOpacity(0.4),
                            height: 1,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }

          return const Center(
            child: Text('Please log in', style: TextStyle(color: Colors.white)),
          );
        },
      ),
    );
  }

  Widget _buildActionRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required ColorScheme cs,
    required VoidCallback onTap,
    required Color iconColor,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: cs.onSurfaceVariant,
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: cs.onSurface.withOpacity(0.5), fontSize: 12),
      ),
      trailing: Icon(Icons.chevron_right, color: cs.onSurface),
    );
  }
}

void _showLogoutDialog(BuildContext context) {
  final cs = Theme.of(context).colorScheme;

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Logout',
    barrierColor: Colors.black87,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
    transitionBuilder: (context, anim1, anim2, child) {
      return Transform.scale(
        scale: anim1.value,
        child: Opacity(
          opacity: anim1.value,
          child: AlertDialog(
            backgroundColor: cs.surface.withOpacity(0.95),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
              side: BorderSide(color: cs.error.withOpacity(0.2)),
            ),
            title: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cs.error.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.logout_rounded, color: cs.error, size: 32),
                ),
                const SizedBox(height: 16),
                Text(
                  "Sign Out",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                    color: cs.onSurface,
                  ),
                ),
              ],
            ),
            content: Text(
              "Are you sure you want to log out of your account?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: cs.onSurfaceVariant),
            ),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actionsPadding: const EdgeInsets.only(
              bottom: 24,
              left: 16,
              right: 16,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  foregroundColor: cs.onSurfaceVariant,
                ),
                child: const Text('Stay'),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: cs.error,
                  foregroundColor: cs.onError,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  context.read<AuthBloc>().add(LogoutRequested());
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}


void _navigateToEditProfile(ProfileEntity profile){
  serviceLocator.get<AppRouter>().navigateToEditProfile(profile);
}

void _navigateToAbout() {
  serviceLocator.get<AppRouter>().navigateToAbout();
}