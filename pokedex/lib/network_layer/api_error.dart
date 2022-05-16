import 'package:dio/dio.dart';

class ApiError {
  late String errorDescription;

  ApiError({required this.errorDescription});

  ApiError.fromDio(Object dioError) {
    _handleError(dioError);
  }

  _handleError(Object error) {
    if (error is DioError) {
      var dioError = error;
      switch (dioError.type) {
        case DioErrorType.cancel:
          errorDescription = 'Requested cancelled';
          break;
        case DioErrorType.connectTimeout:
          errorDescription = 'Unable to establish connection to server';
          break;
        case DioErrorType.other:
          errorDescription =
              'Something went wrong, please check your internet connection...';
          break;
        case DioErrorType.receiveTimeout:
          errorDescription =
              'Server took too longer than expected to respond to request';
          break;
        case DioErrorType.response:
          if (dioError.response!.statusCode == 401) {
            errorDescription = 'Session Expired';
          } else if (dioError.response!.statusCode == 400) {
            errorDescription =
                extractDescriptionFromResponse(dioError.response)!;
          } else if (dioError.response!.statusCode == 500) {
            errorDescription = 'Internal Server Error';
          } else {
            errorDescription = extractDescriptionFromResponse(error.response)!;
          }
          break;
        case DioErrorType.sendTimeout:
          errorDescription =
              'Something went wrong, please check your internet connection...';
          break;
      }
    } else {
      errorDescription = 'Something went wrong, please try again...';
    }
  }

  String? extractDescriptionFromResponse(Response? response) {
    String? message;
    try {
      if (response?.data != null && response!.data['message'] != null) {
        message = response.data['message'];

        if (response.data['errors'] != null) {
          message = '${message!}. ${response.data['errors']}';
        }
      } else {
        message = response!.statusMessage;
      }
    } catch (error) {
      message = response?.statusMessage ?? error.toString();
    }

    return message;
  }

  @override
  String toString() => errorDescription;
}
