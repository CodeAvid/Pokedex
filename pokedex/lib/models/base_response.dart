class BaseResponse {
  String message;
  bool status;

  BaseResponse({this.message = 'Error processing...', this.status = true});

  void errorFromJson(Map<String, dynamic> json) {
    message = json['errorStatus'] ?? 'No descriptive error from server';
    status = json['errorMessage'] ?? false;
  }
}
