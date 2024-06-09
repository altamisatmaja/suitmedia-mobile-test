part of 'widget.dart';

class CustomerDivider extends StatelessWidget {
  const CustomerDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Config.dividerColor,
      thickness: 0.5,
    );
  }
}
