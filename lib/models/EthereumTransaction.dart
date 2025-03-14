class EthereumTransaction {
  const EthereumTransaction({
    required this.from,
    required this.to,
    required this.value,
    this.nonce,
    this.gasPrice,
    this.maxFeePerGas,
    this.maxPriorityFeePerGas,
    this.gas,
    this.gasLimit,
    this.data,
  });

  final String from;
  final String to;
  final String value;
  final String? nonce;
  final String? gasPrice;
  final String? maxFeePerGas;
  final String? maxPriorityFeePerGas;
  final String? gas;
  final String? gasLimit;
  final String? data;

  Map<String, dynamic> toJson() => {
    'from': from,
    'to': to,
    'value': value,
    'data': data,
    'nonce': nonce,
    'gasPrice': gasPrice,
    'maxFeePerGas': maxFeePerGas,
    'maxPriorityFeePerGas': maxPriorityFeePerGas,
    'gas': gas,
    'gasLimit': gasLimit,
  };
}