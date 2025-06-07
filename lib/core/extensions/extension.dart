extension DateExtension on DateTime {
  String formatTimeAgo() {
    final diff = DateTime.now().difference(this);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}

extension StringExtension on String {
  String capitalize() => this[0].toUpperCase() + substring(1).toLowerCase();
}
