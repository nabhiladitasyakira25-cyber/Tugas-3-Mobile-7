import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final _bbController = TextEditingController();
  final _tbController = TextEditingController();

  double? _hasilBMI;
  String _keterangan = 'Masukkan data untuk menghitung BMI';
  String _jenisKelamin = 'Laki-laki';

  void _logikaBMI() {
    final double bb =
        double.tryParse(_bbController.text.replaceAll(',', '.')) ?? 0;
    final double tbInCm =
        double.tryParse(_tbController.text.replaceAll(',', '.')) ?? 0;

    if (bb <= 0 || tbInCm <= 0) {
      setState(() {
        _hasilBMI = null;
        _keterangan = 'Masukkan berat dan tinggi badan yang valid';
      });
      return;
    }

    final double tbInM = tbInCm / 100;
    final double bmi = bb / (tbInM * tbInM);

    setState(() {
      _hasilBMI = bmi;

      if (bmi < 18.5) {
        _keterangan = 'Berat badan kurang';
      } else if (bmi < 25) {
        _keterangan = 'Berat badan normal';
      } else if (bmi < 30) {
        _keterangan = 'Berat badan berlebih';
      } else {
        _keterangan = 'Obesitas';
      }
    });
  }

  void _resetBMI() {
    _bbController.clear();
    _tbController.clear();

    setState(() {
      _hasilBMI = null;
      _keterangan = 'Masukkan data untuk menghitung BMI';
      _jenisKelamin = 'Laki-laki';
    });
  }

  @override
  void dispose() {
    _bbController.dispose();
    _tbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool perempuan = _jenisKelamin == 'Perempuan';

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text(
          'Kalkulator BMI',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.monitor_weight_outlined,
                size: 65,
                color: Colors.blue,
              ),
              const SizedBox(height: 8),
              const Text(
                'Hitung Indeks Massa Tubuh',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Masukkan data diri untuk mengetahui kategori BMI kamu.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.10),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'HASIL BMI',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _hasilBMI?.toStringAsFixed(1) ?? '--',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _keterangan,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _hasilBMI == null
                            ? Colors.grey
                            : _hasilBMI! < 18.5
                                ? Colors.orange
                                : _hasilBMI! < 25
                                    ? Colors.green
                                    : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Kategori untuk ${_jenisKelamin.toLowerCase()}',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Data Diri',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Jenis Kelamin',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      avatar: const Icon(Icons.male),
                      label: const Text('Laki-laki'),
                      selected: !perempuan,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _jenisKelamin = 'Laki-laki';
                          });
                        }
                      },
                      selectedColor: Colors.blue.shade100,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ChoiceChip(
                      avatar: const Icon(Icons.female),
                      label: const Text('Perempuan'),
                      selected: perempuan,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _jenisKelamin = 'Perempuan';
                          });
                        }
                      },
                      selectedColor: Colors.pink.shade100,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              TextField(
                controller: _bbController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Berat Badan (kg)',
                  prefixIcon: const Icon(Icons.monitor_weight_outlined),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _tbController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Tinggi Badan (cm)',
                  prefixIcon: const Icon(Icons.height),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _logikaBMI,
                  icon: const Icon(
                    Icons.calculate,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Hitung BMI',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: _resetBMI,
                  icon: const Icon(Icons.refresh),
                  label: const Text(
                    'Reset',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    side: const BorderSide(
                      color: Colors.blue,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Kategori BMI Dewasa',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              const Text('• Di bawah 18,5 : Berat badan kurang'),
              const Text('• 18,5 sampai kurang dari 25 : Normal'),
              const Text('• 25 sampai kurang dari 30 : Berat berlebih'),
              const Text('• 30 atau lebih : Obesitas'),
              const SizedBox(height: 12),
              const Text(
                'Catatan: Kategori BMI dewasa ini menggunakan batas yang sama '
                'untuk laki-laki dan perempuan. BMI merupakan alat skrining, '
                'bukan diagnosis kesehatan.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
