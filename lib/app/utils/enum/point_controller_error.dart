enum PointControllerError {
  unknownError,
  collaboratorNotFound,
  invalidClockInTime,
  invalidClockOutTime,
  clockInAlreadyExists,
  clockInNotFound,
  clockOutAlreadyExists,
  notBusinessDay,
  outsideBusinessHours;

  static PointControllerError fromErrorMessage(String errorMessage) {
    switch (errorMessage) {
      case "ClockIn time is required.":
      case "Enrollment is required.":
      case "Invalid ClockIn time format.":
      case "Invalid clockOut format.":
        return PointControllerError.invalidClockInTime; 
      case "Collaborator not found.":
        return PointControllerError.collaboratorNotFound;
      case "Clock-in already recorded for today.":
        return PointControllerError.clockInAlreadyExists;
      case "No clock-in found for the specified collaborator and day.":
        return PointControllerError.clockInNotFound;
      case "Clock-out already recorded for this clock-in.":
        return PointControllerError.clockOutAlreadyExists;
      case "Clock-in is only allowed on business days (Monday to Friday).":
      case "Clock-out is only allowed on business days (Monday to Friday).":
        return PointControllerError.notBusinessDay;
      case "Clock-in is only allowed between 08:00 and 18:00.":
      case "Clock-out is only allowed between 08:00 and 18:00 (with some tolerance after 18:00).":
        return PointControllerError.outsideBusinessHours;
      case "An internal server error occurred.":
        return PointControllerError.unknownError;
      default:
        return PointControllerError.unknownError; 
    }
  }
}