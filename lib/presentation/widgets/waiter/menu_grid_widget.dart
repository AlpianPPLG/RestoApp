import 'package:flutter/material.dart';
import 'package:restoapp/core/theme/app_spacing.dart';
import 'package:restoapp/domain/entities/menu.dart';
import 'package:restoapp/presentation/widgets/waiter/menu_card_widget.dart';

class MenuGridWidget extends StatelessWidget {
  final List<Menu> menus;
  final Function(Menu) onMenuTap;

  const MenuGridWidget({
    super.key,
    required this.menus,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
      ),
      itemCount: menus.length,
      itemBuilder: (context, index) {
        final menu = menus[index];
        return MenuCardWidget(menu: menu, onTap: () => onMenuTap(menu));
      },
    );
  }
}
