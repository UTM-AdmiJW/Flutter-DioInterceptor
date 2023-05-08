
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../models/user.dart';
import '../states/user_state.dart';
import '../services/auth_service.dart';


class AuthStateCard extends ConsumerWidget {
  const AuthStateCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.read(authServiceProvider);
    final userState = ref.watch(userStateProvider);

    return Card(
      margin: const EdgeInsets.all(16),
      child: userState.when(
        loading: () => const Center(child: CircularProgressIndicator()).padding(all: 16),
        error: (error, stackTrace) => Center(child: Text('Error $error')).padding(all: 16),
        data: (user) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Auth State').fontSize(24).fontWeight(FontWeight.bold),
            const Divider(height: 16),
            _userInfo(user),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (user == null)
                ElevatedButton(
                  onPressed: authService.login,
                  child: const Text('Login'),
                ),
                if (user != null) ...[
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: authService.logout,
                    child: const Text('Logout'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: authService.get,
                    child: const Text('Get'),
                  ),
                ],
              ],
            )
          ],
        ).padding(all: 16)
      ),
    );
  }



  Widget _userInfo(User? user) {
    if (user == null) return const Text("Not logged in").center();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('User Info').fontSize(18),
        const SizedBox(height: 16),
        Text('Full name: ${user.fullName}'),
        const SizedBox(height: 4),
        Text('Nickname: ${user.nickName}'),
        const SizedBox(height: 4),
        Text('Email: ${user.email}'),
        const SizedBox(height: 4),
        Text('Role: ${user.roles}'),
        const SizedBox(height: 4),
        Text("Phone number: ${user.phoneNumber}"),
        const SizedBox(height: 4),
        Text("ID: ${user.idNo}"),
      ],
    );
  }
}