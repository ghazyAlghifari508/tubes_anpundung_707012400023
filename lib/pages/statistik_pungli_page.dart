import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../model/laporan_model.dart';

class StatistikPungliPage extends StatelessWidget {
  const StatistikPungliPage({super.key});

  @override
  Widget build(BuildContext context) {
    final laporanModel = context.watch<LaporanModel>();

    final int jumlahParkir = laporanModel.hitungKategori('Parkir Liar');
    final int jumlahPerizinan = laporanModel.hitungKategori('Perizinan');
    final int jumlahPasar = laporanModel.hitungKategori('Pasar & PKL');
    final int maxVal = [jumlahParkir, jumlahPerizinan, jumlahPasar]
        .reduce((a, b) => a > b ? a : b);

    final double maxY = (maxVal < 4 ? 5.0 : (maxVal + 2).toDouble());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Info Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF163172), Color(0xFF1E56A0)],
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF163172).withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sebaran Tindak Pungli Bandung',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Sistem Informasi Eksekutif Saber Pungli',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 11.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${laporanModel.totalLaporan} Aduan',
                      style: const TextStyle(
                        color: Color(0xFF163172),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Judul Grafik
            const Center(
              child: Text(
                'Grafik Aduan Pungli per Sektor Rawan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.5,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                'Data sinkron real-time dengan LaporanModel (Provider)',
                style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
              ),
            ),
            const SizedBox(height: 24),

            // BarChart fl_chart
            AspectRatio(
              aspectRatio: 1.45,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: maxY,
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            String sektor = '';
                            switch (group.x) {
                              case 0:
                                sektor = 'Parkir Liar';
                                break;
                              case 1:
                                sektor = 'Perizinan';
                                break;
                              case 2:
                                sektor = 'Pasar & PKL';
                                break;
                            }
                            return BarTooltipItem(
                              '$sektor\n${rod.toY.toInt()} Laporan',
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              String label = '';
                              switch (value.toInt()) {
                                case 0:
                                  label = 'Parkir Liar';
                                  break;
                                case 1:
                                  label = 'Perizinan';
                                  break;
                                case 2:
                                  label = 'Pasar & PKL';
                                  break;
                              }
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  label,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: Colors.black87,
                                  ),
                                ),
                              );
                            },
                            reservedSize: 28,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 28,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              if (value % 1 == 0) {
                                return Text(
                                  value.toInt().toString(),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.black54,
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 1,
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: Colors.grey.shade200,
                          strokeWidth: 1,
                          dashArray: [4, 4],
                        ),
                      ),
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              toY: jumlahParkir.toDouble(),
                              color: const Color(0xFF163172),
                              width: 26,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6),
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(
                              toY: jumlahPerizinan.toDouble(),
                              color: const Color(0xFF00897B),
                              width: 26,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6),
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(
                              toY: jumlahPasar.toDouble(),
                              color: const Color(0xFFF57C00),
                              width: 26,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Ringkasan Kategori
            Row(
              children: [
                _buildSummaryBox(
                  'Parkir Liar',
                  '$jumlahParkir',
                  const Color(0xFF163172),
                  Icons.local_parking,
                ),
                const SizedBox(width: 10),
                _buildSummaryBox(
                  'Perizinan',
                  '$jumlahPerizinan',
                  const Color(0xFF00897B),
                  Icons.business_center,
                ),
                const SizedBox(width: 10),
                _buildSummaryBox(
                  'Pasar & PKL',
                  '$jumlahPasar',
                  const Color(0xFFF57C00),
                  Icons.storefront,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryBox(
    String label,
    String count,
    Color color,
    IconData icon,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 6),
            Text(
              count,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 10.5, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
