import 'package:agri_net_frontend/profile/widgets/address.dart';

import '../../libs.dart';

class StoreView extends StatefulWidget {
  final Store store;
  StoreView(this.store);

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Text("Store : ",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(
                  widget.store.storeName,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text("Owner : ",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              children: [
                Text("Active Products : ",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(
                  widget.store.activeProducts.toString(),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text("Active Contracts : ",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(
                  widget.store.activeContracts.toString(),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
            AddressView(widget.store.address)
          ],
        ),
      ),
    );
  }
}
