import 'package:flutter/material.dart';

import '../services/course_portal_navigation.dart';

class CoursePortalButton extends StatelessWidget {
  const CoursePortalButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (!supportsCoursePortalNavigation) return const SizedBox.shrink();

    if (MediaQuery.sizeOf(context).width >= 600) {
      return TextButton.icon(
        onPressed: openCoursePortal,
        icon: const Icon(Icons.arrow_back_rounded),
        label: const Text('Library'),
      );
    }

    return IconButton(
      tooltip: 'Back to Course Portal',
      icon: const Icon(Icons.arrow_back_rounded),
      onPressed: openCoursePortal,
    );
  }
}
