import 'dart:html' as html;

bool get supportsCoursePortalNavigation => true;

void openCoursePortal() {
  html.window.location.assign('/');
}
