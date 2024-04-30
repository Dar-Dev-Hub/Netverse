class WithdrawalRequest {
  final String amount;
  final String status;

  WithdrawalRequest({required this.amount, required this.status});

  factory WithdrawalRequest.fromJson(Map<String, dynamic> json) {
    return WithdrawalRequest(
      amount: json['amount'],
      status: json['status'],
    );
  }
}