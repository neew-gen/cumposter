class PostTime {
  int hour;
  int minute;
  PostTime(this.hour, this.minute);
  Map<String, int> toMap() {
    return {
      'hour': hour,
      'minute': minute,
    };
  }
}

// class EndTime {
//   int hour;
//   int minute;
//   EndTime(this.hour, this.minute);
//   Map<String, int> toMap() {
//     return {
//       'hour': hour,
//       'minute': minute,
//     };
//   }
// }
//
// class StepTime {
//   int hour;
//   int minute;
//   StepTime(this.hour, this.minute);
//   Map<String, int> toMap() {
//     return {
//       'hour': hour,
//       'minute': minute,
//     };
//   }
// }
