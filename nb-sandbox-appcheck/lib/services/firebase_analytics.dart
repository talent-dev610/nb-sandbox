import 'package:firebase_analytics/firebase_analytics.dart';

// Initialize Firebase analytics
final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;

// Tracking class
class CustomAnalytics {
  // *** Dialogs ***
  dialDashGuide() =>
      firebaseAnalytics.logEvent(name: 'view_dialog', parameters: {
        'type': 'guide',
        'content': 'dashboard_instructions',
        'location': 'dashboard_screen'
      });
  dialHipaaGuide() =>
      firebaseAnalytics.logEvent(name: 'view_dialog', parameters: {
        'type': 'guide',
        'content': 'hipaa_info',
        'location': 'settings_screen'
      });
  dialTodoGuide() =>
      firebaseAnalytics.logEvent(name: 'view_dialog', parameters: {
        'type': 'guide',
        'content': 'todo_instructions',
        'location': 'todo_screen'
      });
  dialDashPremGuide() =>
      firebaseAnalytics.logEvent(name: 'view_dialog', parameters: {
        'type': 'info',
        'content': 'premium_version_soon',
        'location': 'dashboard_screen'
      });

  // *** Screens ***

  // Screens - Clipboard
  screenClipboard() =>
      firebaseAnalytics.setCurrentScreen(screenName: 'clipboard_screen');
  // Screens - Tasks
  screenAddTask() =>
      firebaseAnalytics.setCurrentScreen(screenName: 'add_task_screen');
  screenTodo() =>
      firebaseAnalytics.setCurrentScreen(screenName: 'todo_list_screen');
  screenUpdateTask() =>
      firebaseAnalytics.setCurrentScreen(screenName: 'update_task_screen');
  // Screens - Auth
  screenLogin() =>
      firebaseAnalytics.setCurrentScreen(screenName: 'login_screen');
  // Screens - Misc
  screenDashboard() =>
      firebaseAnalytics.setCurrentScreen(screenName: 'dashboard_screen');
  // Screens - Patient
  screenAddPt(String specialty) => firebaseAnalytics.setCurrentScreen(
      screenName: 'add_patient_${specialty}_screen');
  screenUpdatePt(String specialty) => firebaseAnalytics.setCurrentScreen(
      screenName: 'update_patient_${specialty}_screen');
  // Screens - Notes
  screenNotesList() =>
      firebaseAnalytics.setCurrentScreen(screenName: 'notes_list_screen');
  screenAddNote() =>
      firebaseAnalytics.setCurrentScreen(screenName: 'add_note_screen');
  screenUpdateNote() =>
      firebaseAnalytics.setCurrentScreen(screenName: 'update_note_screen');

  // *** Events ***

  // Events - Patients
  eventAddDbPt(String specialty, String medicalDx) =>
      firebaseAnalytics.logEvent(name: 'manage_patient', parameters: {
        'specialty': specialty,
        'save_location': 'database',
        'diagnosis': medicalDx,
        'action': 'add',
        'result': 'success',
      });
  eventAddLocalPt(String specialty, String medicalDx) =>
      firebaseAnalytics.logEvent(name: 'manage_patient', parameters: {
        'specialty': specialty,
        'save_location': 'local',
        'diagnosis': medicalDx,
        'action': 'add',
        'result': 'success',
      });
  eventAttemptAddPt(String specialty, String medicalDx, bool guest) =>
      firebaseAnalytics.logEvent(name: 'manage_patient', parameters: {
        'specialty': specialty,
        'save_location': guest ? 'local' : 'database',
        'diagnosis': medicalDx,
        'action': 'add',
        'result': 'fail',
      });
  eventAttemptUpdatePt(String specialty, String medicalDx, bool guest) =>
      firebaseAnalytics.logEvent(name: 'manage_patient', parameters: {
        'specialty': specialty,
        'save_location': guest ? 'local' : 'database',
        'diagnosis': medicalDx,
        'action': 'update',
        'result': 'fail',
      });
  eventDeletePatient(String specialty, String medicalDx, bool guest) =>
      firebaseAnalytics.logEvent(name: 'manage_patient', parameters: {
        'specialty': specialty,
        'save_location': guest ? 'local' : 'database',
        'diagnosis': medicalDx,
        'action': 'delete',
        'result': 'success',
      });
  eventDeleteAllPatients() =>
      firebaseAnalytics.logEvent(name: 'manage_patient', parameters: {
        'action': 'delete_all_patients',
        'result': 'success',
      });
  eventSharePatient(String specialty, String medicalDx) =>
      firebaseAnalytics.logEvent(name: 'manage_patient', parameters: {
        'specialty': specialty,
        'save_location': 'database',
        'diagnosis': medicalDx,
        'action': 'share',
        'result': 'success',
      });
  eventSwitchSpecialty(selectedSpecialty) =>
      firebaseAnalytics.logEvent(name: 'specialty_to_$selectedSpecialty');
  eventUpdateDbPt(String specialty, String medicalDx) =>
      firebaseAnalytics.logEvent(name: 'manage_patient', parameters: {
        'specialty': specialty,
        'save_location': 'database',
        'diagnosis': medicalDx,
        'action': 'update',
        'result': 'success',
      });
  eventUpdateLocalPt(String specialty, String medicalDx) =>
      firebaseAnalytics.logEvent(name: 'manage_patient', parameters: {
        'specialty': specialty,
        'save_location': 'local',
        'diagnosis': medicalDx,
        'action': 'update',
        'result': 'success',
      });
  eventViewPatient(String specialty, String medicalDx, bool guest) =>
      firebaseAnalytics.logEvent(name: 'manage_patient', parameters: {
        'specialty': specialty,
        'save_location': guest ? 'local' : 'database',
        'diagnosis': medicalDx,
        'action': 'view',
        'result': 'success',
      });

  // Events - Tasks
  eventAddTask(String category, String priority, String patient,
          String specialty, bool onTime) =>
      firebaseAnalytics.logEvent(name: 'manage_task', parameters: {
        'category': category,
        'priority': priority,
        'patient': patient,
        'specialty': specialty,
        'on_time': onTime,
        'action': 'add',
        'result': 'success',
      });
  eventAttemptAddTask(
          String category, String priority, String patient, String specialty) =>
      firebaseAnalytics.logEvent(name: 'manage_task', parameters: {
        'category': category,
        'priority': priority,
        'patient': patient,
        'specialty': specialty,
        // 'on_time': onTime, can't determine if fields missing...
        'action': 'add',
        'result': 'fail'
      });
  eventAttemptUpdateTask(
          String category, String priority, String patient, String specialty) =>
      firebaseAnalytics.logEvent(name: 'manage_task', parameters: {
        'category': category,
        'priority': priority,
        'patient': patient,
        'specialty': specialty,
        // 'on_time': onTime, can't determine if fields missing...
        'action': 'update',
        'result': 'fail'
      });
  eventDeleteAllTasks() =>
      firebaseAnalytics.logEvent(name: 'manage_task', parameters: {
        'action': 'delete_all_tasks',
        'result': 'success',
      });
  eventDeleteTask(String category, String priority, String patient,
          String specialty, bool onTime) =>
      firebaseAnalytics.logEvent(name: 'manage_task', parameters: {
        'category': category,
        'priority': priority,
        'patient': patient,
        'specialty': specialty,
        'on_time': onTime,
        'action': 'delete',
        'result': 'success',
      });
  eventTodoNotification() =>
      firebaseAnalytics.logEvent(name: 'manage_task', parameters: {
        'action': 'view_notification',
        'result': 'success',
      });
  eventUpdateTask(String category, String priority, String patient,
          String specialty, bool onTime) =>
      firebaseAnalytics.logEvent(name: 'manage_task', parameters: {
        'category': category,
        'priority': priority,
        'patient': patient,
        'specialty': specialty,
        'on_time': onTime,
        'action': 'update',
        'result': 'success',
      });
  eventViewTask(String todoCat, String todoRank, String patient,
          String specialty, bool onTime) =>
      firebaseAnalytics.logEvent(name: 'manage_task', parameters: {
        'category': todoCat,
        'priority': todoRank,
        'patient': patient,
        'specialty': specialty,
        'on_time': onTime,
        'action': 'view',
        'result': 'success',
      });

  // Events - Notes
  eventDeleteNote() => firebaseAnalytics.logEvent(name: 'delete_note');

  // Events - Misc
  eventDeleteShiftData(int patsNum, int tasksNum) =>
      firebaseAnalytics.logEvent(name: 'manage_shift', parameters: {
        'action': 'delete_all_data',
        'patients': patsNum,
        'tasks': tasksNum,
      });
  eventEndShift(int patsNum, int tasksNum) =>
      firebaseAnalytics.logEvent(name: 'manage_shift', parameters: {
        'action': 'end_shift',
        'patients': patsNum,
        'tasks': tasksNum,
      });
  eventFeedbackForm() =>
      firebaseAnalytics.logEvent(name: 'app_feedback', parameters: {
        'action': 'survey',
        'location': 'dashboard_screen',
      });
  eventContactForm() =>
      firebaseAnalytics.logEvent(name: 'app_feedback', parameters: {
        'action': 'contact_form',
        'location': 'briefcase_screen',
      });
  eventAppReview() =>
      firebaseAnalytics.logEvent(name: 'app_feedback', parameters: {
        'action': 'review',
        'location': 'dashboard_screen',
      });
  eventAppReviewBrief() =>
      firebaseAnalytics.logEvent(name: 'app_feedback', parameters: {
        'action': 'review',
        'location': 'briefcase_screen',
      });
  eventLink(link) => firebaseAnalytics.logEvent(name: 'open_link', parameters: {
        'link': link,
        'type': 'website',
        'location': 'briefcase_screen',
      });
  eventLinkSocial(link) =>
      firebaseAnalytics.logEvent(name: 'open_link', parameters: {
        'link': link,
        'type': 'social_media',
        'location': 'briefcase_screen',
      });
  eventSettingsLogout() => firebaseAnalytics.logEvent(name: 'settings_logout');
  eventTellFriend() => firebaseAnalytics.logShare(
      contentType: 'app_link',
      itemId: 'tell_friend',
      method: 'dashboard_screen');
  eventTellFriendBrief() => firebaseAnalytics.logShare(
      contentType: 'app_link',
      itemId: 'tell_friend',
      method: 'briefcase_screen');
  eventViewTerms() => firebaseAnalytics.logEvent(name: 'view_terms_conditions');
  eventViewBlog() => firebaseAnalytics.logSelectContent(
      contentType: 'blog_post', itemId: 'blog_home');
  eventViewBlogPost(String wpPost) => firebaseAnalytics.logSelectContent(
      contentType: 'blog_post', itemId: wpPost);

  // *** User Properties ***
  propUserGuest() =>
      firebaseAnalytics.setUserProperty(name: 'user_type', value: 'guest');
  propUserID(kUserID) => firebaseAnalytics.setUserId(id: kUserID);
  propUserNurse() =>
      firebaseAnalytics.setUserProperty(name: 'user_type', value: 'nurse');
  // type of nurse
  propNurseType(String specialty) => firebaseAnalytics.setUserProperty(
      name: 'nurse_type', value: 'nurse_$specialty');
}
