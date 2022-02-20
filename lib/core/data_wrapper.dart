class DataWrapper<T> {
  T? data;
  Status? status;
  String? error;

  DataWrapper.init() : status = Status.init;

  DataWrapper.loading() : status = Status.loading;

  DataWrapper.success(this.data) : status = Status.success;

  DataWrapper.error(this.error) : status = Status.error;
}

enum Status { loading, success, error, init }
