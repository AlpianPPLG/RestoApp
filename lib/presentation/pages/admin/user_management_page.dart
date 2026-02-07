import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:restoapp/domain/entities/user.dart';
import 'package:restoapp/domain/entities/enums.dart';
import 'package:restoapp/domain/repositories/user_repository.dart';
import 'package:restoapp/presentation/blocs/user/user_bloc.dart';
import 'package:restoapp/presentation/pages/admin/widgets/user_form_dialog.dart';
import 'package:restoapp/presentation/pages/admin/widgets/password_reset_dialog.dart';

/// Page for managing users (CRUD operations).
class UserManagementPage extends StatelessWidget {
  const UserManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserBloc(GetIt.I<UserRepository>())..add(const UserLoadAll()),
      child: const UserManagementView(),
    );
  }
}

class UserManagementView extends StatefulWidget {
  const UserManagementView({super.key});

  @override
  State<UserManagementView> createState() => _UserManagementViewState();
}

class _UserManagementViewState extends State<UserManagementView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        actions: [
          IconButton(
            onPressed: () => context.read<UserBloc>().add(const UserLoadAll()),
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddUserDialog(context),
        icon: const Icon(Icons.person_add),
        label: const Text('Add User'),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserLoaded) {
            return Column(
              children: [
                _buildRoleSummary(context, state),
                Expanded(
                  child: state.users.isEmpty
                      ? _buildEmptyState(context)
                      : _buildUserList(context, state.users),
                ),
              ],
            );
          }

          if (state is UserError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () =>
                        context.read<UserBloc>().add(const UserLoadAll()),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildRoleSummary(BuildContext context, UserLoaded state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildRoleChip(
            context,
            'Total',
            state.totalCount,
            Icons.people,
            Colors.blue,
          ),
          _buildRoleChip(
            context,
            'Admin',
            state.adminCount,
            Icons.admin_panel_settings,
            Colors.purple,
          ),
          _buildRoleChip(
            context,
            'Waiter',
            state.waiterCount,
            Icons.person,
            Colors.green,
          ),
          _buildRoleChip(
            context,
            'Cashier',
            state.cashierCount,
            Icons.point_of_sale,
            Colors.orange,
          ),
          _buildRoleChip(
            context,
            'Kitchen',
            state.kitchenCount,
            Icons.restaurant,
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildRoleChip(
    BuildContext context,
    String label,
    int count,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 4),
        Text(
          count.toString(),
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'No users found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first user to get started',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList(BuildContext context, List<User> users) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return _UserCard(
          user: user,
          onEdit: () => _showEditUserDialog(context, user),
          onResetPassword: () => _showResetPasswordDialog(context, user),
          onDelete: () => _showDeleteConfirmation(context, user),
        );
      },
    );
  }

  void _showAddUserDialog(BuildContext context) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (dialogContext) => const UserFormDialog(),
    );

    if (result != null && context.mounted) {
      context.read<UserBloc>().add(
        UserCreate(
          username: result['username'] as String,
          password: result['password'] as String,
          fullName: result['fullName'] as String,
          role: result['role'] as UserRole,
        ),
      );
    }
  }

  void _showEditUserDialog(BuildContext context, User user) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (dialogContext) => UserFormDialog(
        username: user.username,
        fullName: user.fullName,
        role: user.role,
        isEditing: true,
      ),
    );

    if (result != null && context.mounted) {
      context.read<UserBloc>().add(
        UserUpdate(
          id: user.id,
          fullName: result['fullName'] as String,
          role: result['role'] as UserRole,
        ),
      );
    }
  }

  void _showResetPasswordDialog(BuildContext context, User user) async {
    final newPassword = await showDialog<String>(
      context: context,
      builder: (dialogContext) => PasswordResetDialog(username: user.username),
    );

    if (newPassword != null && context.mounted) {
      context.read<UserBloc>().add(
        UserUpdatePassword(userId: user.id, newPassword: newPassword),
      );
    }
  }

  void _showDeleteConfirmation(BuildContext context, User user) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete User'),
        content: Text(
          'Are you sure you want to delete "${user.fullName ?? user.username}"?\n\nThis action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<UserBloc>().add(UserDelete(user.id));
    }
  }
}

class _UserCard extends StatelessWidget {
  final User user;
  final VoidCallback onEdit;
  final VoidCallback onResetPassword;
  final VoidCallback onDelete;

  const _UserCard({
    required this.user,
    required this.onEdit,
    required this.onResetPassword,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: _getRoleColor(user.role).withValues(alpha: 0.2),
          child: Icon(_getRoleIcon(user.role), color: _getRoleColor(user.role)),
        ),
        title: Text(
          user.fullName ?? user.username,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('@${user.username}'),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: _getRoleColor(user.role).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _getRoleLabel(user.role),
                style: TextStyle(
                  fontSize: 12,
                  color: _getRoleColor(user.role),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'edit':
                onEdit();
                break;
              case 'password':
                onResetPassword();
                break;
              case 'delete':
                onDelete();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit_outlined),
                  SizedBox(width: 12),
                  Text('Edit User'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'password',
              child: Row(
                children: [
                  Icon(Icons.lock_reset),
                  SizedBox(width: 12),
                  Text('Reset Password'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(
                    Icons.delete_outline,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Delete',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRoleColor(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return Colors.purple;
      case UserRole.waiter:
        return Colors.green;
      case UserRole.cashier:
        return Colors.orange;
      case UserRole.kitchen:
        return Colors.red;
    }
  }

  IconData _getRoleIcon(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return Icons.admin_panel_settings;
      case UserRole.waiter:
        return Icons.person;
      case UserRole.cashier:
        return Icons.point_of_sale;
      case UserRole.kitchen:
        return Icons.restaurant;
    }
  }

  String _getRoleLabel(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return 'Administrator';
      case UserRole.waiter:
        return 'Waiter';
      case UserRole.cashier:
        return 'Cashier';
      case UserRole.kitchen:
        return 'Kitchen Staff';
    }
  }
}
