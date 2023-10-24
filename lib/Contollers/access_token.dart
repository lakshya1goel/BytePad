bool isAccessTokenExpired(int expirationTimeInSeconds) {
  // Convert the expiration time to a DateTime object
  DateTime expirationDateTime = DateTime.fromMillisecondsSinceEpoch(expirationTimeInSeconds * 1000);

  // Get the current time
  DateTime now = DateTime.now();

  // Compare the current time with the expiration time
  return now.isAfter(expirationDateTime);
}
