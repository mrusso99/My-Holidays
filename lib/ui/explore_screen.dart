import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:my_holidays/languages/languageLocalizations.dart';
import 'package:web3dart/web3dart.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late Client httpClient;
  late Web3Client ethClient;

  late String lastTransactionHash = '';

  @override
  void initState() {
    super.initState();
    httpClient = Client();
    ethClient = Web3Client("http://10.0.2.2:7545", httpClient);
  }

  Future<DeployedContract> loadContract() async {
    String abiCode = await rootBundle.loadString("assets/abi.json");
    String contractAddress = "0x8e7104f3c9408E333b9540e53841e78d6859ae40";

    final contract = DeployedContract(
        ContractAbi.fromJson(abiCode, "FelixCoin"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<String> submit(String functionName, List<dynamic> args) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(
        "9deb48890464baeecff1a7011fdb68155759e0dba44a006d3a60c53622417b75");

    DeployedContract contract = await loadContract();

    final ethFunction = contract.function(functionName);

    var result = await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: ethFunction,
        parameters: args,
      ),
    );
    return result;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final data = await ethClient.call(
        contract: contract, function: ethFunction, params: args);
    return data;
  }

  Future<String> sendCoind(String targetAddressHex, int amount) async {
    EthereumAddress address = EthereumAddress.fromHex(targetAddressHex);
    // uint in smart contract means BigInt for us
    var bigAmount = BigInt.from(amount);
    // sendCoin transaction
    var response = await submit("sendCoin", [address, bigAmount]);
    // hash of the transaction
    return response;
  }

  Future<List<dynamic>> getBalance(String targetAddressHex) async {
    EthereumAddress address = EthereumAddress.fromHex(targetAddressHex);
    List<dynamic> result = await query("getBalance", [address]);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LanguageLocalizations.of(context).explore,
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future: getBalance("0x371A7D8eEeCdFB163758CA3a92006154C9424acF"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                      'You have this many FelixCoin ${snapshot.data}');
                } else
                  return Text('Loading...');
              },
            ),
            RaisedButton(
              child: Text("Send some MetaCoins"),
              onPressed: () async {
                var result = await sendCoind(
                    "0x5F2431b3fC405D4BCb3dF4f819a90521ac90120E", 5000);
                setState(() {
                  lastTransactionHash = result;
                });
              },
            ),
            Text("Last transaction hash: $lastTransactionHash")
          ],
        ),
      ),
    );
  }
}