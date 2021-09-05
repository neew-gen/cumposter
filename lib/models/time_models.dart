class StartTime {
  int hour;
  int minute;
  StartTime(this.hour, this.minute);
  Map<String, int> toMap() {
    return {
      'hour': hour,
      'age': minute,
    };
  }
}

class EndTime {
  int hour;
  int minute;
  EndTime(this.hour, this.minute);
  Map<String, int> toMap() {
    return {
      'hour': hour,
      'age': minute,
    };
  }
}

class StepTime {
  int hour;
  int minute;
  StepTime(this.hour, this.minute);
  Map<String, int> toMap() {
    return {
      'hour': hour,
      'age': minute,
    };
  }
}
