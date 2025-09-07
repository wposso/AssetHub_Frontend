import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

void main() {
  runApp(const LogyserApp());
}

// Colores corporativos de LOGYSER
const Color primaryColor = Color(0xFF0A2C8C);
const Color secondaryColor = Color(0xFF1E4EC8);
const Color accentColor = Color(0xFFE74C3C);
const Color darkTextColor = Color(0xFF2C3E50);
const Color backgroundColor = Color(0xFFFFFFFF);
const Color lightGreyColor = Color(0xFFF8F9FA);
const Color borderColor = Color(0xFFE9ECEF);

class LogyserApp extends StatelessWidget {
  const LogyserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LOGYSER - Gestión de Inventario',
      theme: ThemeData(
        primaryColor: primaryColor,
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          secondary: accentColor,
          background: backgroundColor,
        ),
        fontFamily: 'Inter',
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          centerTitle: false,
        ),
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: lightGreyColor,
      appBar: AppBar(
        title: Row(
          children: [
            // Image.asset('Logo-Logser.png', height: 50, fit: BoxFit.contain),
            const SizedBox(width: 16),
            const Text(
              'Sistema de Gestión de Inventario',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.notification, size: 22),
            onPressed: () {},
            tooltip: 'Notificaciones',
          ),
          IconButton(
            icon: const Icon(Iconsax.search_normal, size: 22),
            onPressed: () {},
            tooltip: 'Buscar',
          ),
          const SizedBox(width: 8),
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: primaryColor,
              child: Text(
                'AU',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        width: 280,
        child: Column(
          children: [
            // Header del Drawer
            Container(
              height: 180,
              decoration: const BoxDecoration(color: primaryColor),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.network(
                    //   'https://logyser.com/wp-content/uploads/2024/09/Logo-Logser.png',
                    //   height: 50,
                    //   fit: BoxFit.contain,
                    // ),
                    const SizedBox(height: 8),
                    const Text(
                      'Apoyo Logistico y Operativo',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    'MENÚ PRINCIPAL',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDrawerItem(Iconsax.chart_2, 'Dashboard', 0),
                  _buildDrawerItem(Iconsax.box, 'Gestión de Activos', 1),
                  _buildDrawerItem(Iconsax.briefcase, 'Proyectos', 2),
                  _buildDrawerItem(Iconsax.chart_square, 'Reportes', 3),
                  _buildDrawerItem(Iconsax.people, 'Empleados', 4),
                  const SizedBox(height: 24),
                  const Text(
                    'CONFIGURACIÓN',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDrawerItem(Iconsax.setting_2, 'Configuración', 5),
                  _buildDrawerItem(Iconsax.logout, 'Cerrar Sesión', 6),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          // Sidebar Navigation
          Container(
            width: 80,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(1, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 32),
                _buildSidebarIcon(Iconsax.chart_2, 'Dashboard', 0),
                _buildSidebarIcon(Iconsax.box, 'Activos', 1),
                _buildSidebarIcon(Iconsax.briefcase, 'Proyectos', 2),
                _buildSidebarIcon(Iconsax.chart_square, 'Reportes', 3),
                _buildSidebarIcon(Iconsax.people, 'Empleados', 4),
                const Spacer(),
                _buildSidebarIcon(Iconsax.setting_2, 'Configuración', 5),
                _buildSidebarIcon(Iconsax.logout, 'Salir', 6),
                const SizedBox(height: 32),
              ],
            ),
          ),
          // Main Content
          Expanded(child: _buildCurrentScreen()),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(
        icon,
        size: 20,
        color: _selectedIndex == index ? primaryColor : darkTextColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: _selectedIndex == index ? primaryColor : darkTextColor,
          fontWeight: _selectedIndex == index
              ? FontWeight.w600
              : FontWeight.normal,
        ),
      ),
      selected: _selectedIndex == index,
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        Navigator.pop(context);
      },
    );
  }

  Widget _buildSidebarIcon(IconData icon, String tooltip, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: IconButton(
        icon: Icon(icon, size: 24),
        color: _selectedIndex == index ? primaryColor : Colors.grey,
        onPressed: () => setState(() => _selectedIndex = index),
        tooltip: tooltip,
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_selectedIndex) {
      case 0:
        return const DashboardScreen();
      case 1:
        return const AssetsScreen();
      case 2:
        return const ProjectsScreen();
      case 3:
        return const ReportsScreen();
      case 4:
        return const EmployeesScreen();
      default:
        return const DashboardScreen();
    }
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Dashboard General',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: darkTextColor,
                ),
              ),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Iconsax.filter, size: 16),
                    label: const Text('Filtrar'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryColor,
                      side: const BorderSide(color: borderColor),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Iconsax.add, size: 16),
                    label: const Text('Nuevo Activo'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Stats Grid
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
            children: [
              _buildStatCard(
                'Total Activos',
                '245',
                Iconsax.box,
                primaryColor,
                '+1.8%',
              ),
              _buildStatCard(
                'Asignados',
                '189',
                Iconsax.profile_2user,
                Colors.green,
                '+3.4%',
              ),
              _buildStatCard(
                'En Reparación',
                '12',
                Iconsax.setting_2,
                Colors.orange,
                '-2.1%',
              ),
              _buildStatCard(
                'Inactivos',
                '8',
                Iconsax.close_circle,
                accentColor,
                '+0.5%',
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Charts and Data Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Charts
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildChartSection(
                      'Distribución de Activos por Categoría',
                      _buildCategoryChart(),
                    ),
                    const SizedBox(height: 24),
                    _buildChartSection(
                      'Tendencia Mensual de Activos',
                      _buildTrendChart(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),

              // Sidebar Data
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _buildDataCard('Activos por Proyecto', _buildProjectList()),
                    const SizedBox(height: 24),
                    _buildDataCard('Activos Recientes', _buildRecentAssets()),
                    const SizedBox(height: 24),
                    _buildStatsCard(
                      'Resumen Financiero',
                      _buildFinancialSummary(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String percent,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 20, color: color),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: percent.contains('+')
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  percent,
                  style: TextStyle(
                    color: percent.contains('+') ? Colors.green : Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: darkTextColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildChartSection(String title, Widget chart) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: darkTextColor,
            ),
          ),
          const SizedBox(height: 16),
          chart,
        ],
      ),
    );
  }

  Widget _buildCategoryChart() {
    return SizedBox(
      height: 200,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildChartItem('Computadores', 120, primaryColor, '45%'),
                _buildChartItem('Móviles', 60, secondaryColor, '25%'),
                _buildChartItem('Muebles', 35, accentColor, '15%'),
                _buildChartItem('Red', 20, Colors.orange, '8%'),
                _buildChartItem('Periféricos', 10, Colors.green, '4%'),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '245',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    'Total Activos',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartItem(
    String label,
    int value,
    Color color,
    String percentage,
  ) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 12))),
        Text(
          value.toString(),
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 8),
        Text(
          percentage,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildTrendChart() {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                _TrendItem('Enero', 45, true),
                _TrendItem('Febrero', 52, true),
                _TrendItem('Marzo', 48, false),
                _TrendItem('Abril', 67, true),
                _TrendItem('Mayo', 58, false),
                _TrendItem('Junio', 72, true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataCard(String title, Widget content) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: darkTextColor,
            ),
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  Widget _buildProjectList() {
    return Column(
      children: [
        _ProjectItem('Pepsico Innova', 45, 0.75),
        _ProjectItem('Risaralda', 32, 0.64),
        _ProjectItem('Funza', 28, 0.56),
        _ProjectItem('Pepsico Funza', 38, 0.76),
        _ProjectItem('Antioquia', 22, 0.44),
      ],
    );
  }

  Widget _buildRecentAssets() {
    return Column(
      children: [
        _RecentAssetItem(
          'Laptop Dell XPS',
          'Pepsico Innova',
          Iconsax.d_cube_scan,
        ),
        _RecentAssetItem('iPhone 13 Pro', 'Risaralda', Iconsax.mobile),
        _RecentAssetItem('Silla Ejecutiva', 'Funza', Iconsax.gift),
        _RecentAssetItem('Monitor LG 27"', 'Pepsico DC Hub', Iconsax.monitor),
      ],
    );
  }

  Widget _buildFinancialSummary() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$30,256.23',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkTextColor,
                  ),
                ),
                Text(
                  'Valor total activos',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Icon(Iconsax.arrow_up_3, size: 14, color: Colors.green),
                  SizedBox(width: 4),
                  Text(
                    '+15%',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const LinearProgressIndicator(
          value: 0.75,
          backgroundColor: borderColor,
          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ],
    );
  }

  Widget _buildStatsCard(String title, Widget content) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: darkTextColor,
            ),
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }
}

class _TrendItem extends StatelessWidget {
  final String month;
  final int value;
  final bool isPositive;

  const _TrendItem(this.month, this.value, this.isPositive);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Text(month, style: const TextStyle(fontSize: 12)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value.toString(),
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 4),
          Icon(
            isPositive ? Iconsax.arrow_up_3 : Iconsax.arrow_down_2,
            size: 14,
            color: isPositive ? Colors.green : Colors.red,
          ),
        ],
      ),
    );
  }
}

class _ProjectItem extends StatelessWidget {
  final String name;
  final int count;
  final double progress;

  const _ProjectItem(this.name, this.count, this.progress);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(fontSize: 12)),
              Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: borderColor,
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _RecentAssetItem extends StatelessWidget {
  final String name;
  final String project;
  final IconData icon;

  const _RecentAssetItem(this.name, this.project, this.icon);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 16, color: primaryColor),
      ),
      title: Text(name, style: const TextStyle(fontSize: 12)),
      subtitle: Text(
        project,
        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
      ),
      trailing: const Icon(Iconsax.arrow_right_3, size: 14),
    );
  }
}

class AssetsScreen extends StatelessWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: const Center(
        child: Text(
          'Gestión de Activos',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: darkTextColor,
          ),
        ),
      ),
    );
  }
}

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: const Center(
        child: Text(
          'Gestión de Proyectos',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: darkTextColor,
          ),
        ),
      ),
    );
  }
}

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: const Center(
        child: Text(
          'Reportes y Analytics',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: darkTextColor,
          ),
        ),
      ),
    );
  }
}

class EmployeesScreen extends StatelessWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: const Center(
        child: Text(
          'Gestión de Empleados',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: darkTextColor,
          ),
        ),
      ),
    );
  }
}
