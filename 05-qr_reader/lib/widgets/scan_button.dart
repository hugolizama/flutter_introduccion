import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/utils/utils.dart';
import '../providers/scan_list_provider.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon( Icons.filter_center_focus ),
      elevation: 0,
      onPressed: () async {
        
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#3D8BEF', 'Cancelar', false, ScanMode.QR);

        // final barcodeScanRes = 'geo:13.702890,-89.193707';
        // final barcodeScanRes = 'https://www.google.com.sv';

        // el usuario cancelo la lectura del QR, no hacer nada
        if( barcodeScanRes == '-1'){
          return;
        }

        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);

        launchURL(context, nuevoScan);
      },
    );
  }
}