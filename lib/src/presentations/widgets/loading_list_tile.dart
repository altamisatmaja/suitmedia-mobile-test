part of 'widget.dart';

class LoadingListTile extends StatelessWidget {
  const LoadingListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[300],
        ),
        title: Container(
          width: double.infinity,
          height: 10.0,
          color: Colors.grey[300],
        ),
        subtitle: Container(
          width: double.infinity,
          height: 10.0,
          color: Colors.grey[300],
        ),
      ),
    );
  }
}
