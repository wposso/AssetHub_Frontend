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
      builder: (context, child) {
        return Scaffold(
          body: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(1.0),
            ),
            child: child!,
          ),
        );
      },
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
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    final bool isTablet = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: lightGreyColor,
      appBar: AppBar(
        title: Row(
          children: [
            Image.network(
              'https://logyser.com/wp-content/uploads/2024/09/Logo-Logser.png',
              height: 32,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 12),
            Text(
              'Gestión de Inventario',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: isMobile ? 16 : 18,
              ),
            ),
          ],
        ),
        actions: isMobile
            ? [
                IconButton(
                  icon: const Icon(Iconsax.menu, size: 24),
                  onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
                ),
              ]
            : [
                IconButton(
                  icon: const Icon(Iconsax.notification, size: 22),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Iconsax.search_normal, size: 22),
                  onPressed: () {},
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
      endDrawer: isMobile ? _buildMobileDrawer() : null,
      body: Row(
        children: [
          if (!isMobile) _buildDesktopSidebar(),
          Expanded(
            child: _buildCurrentScreen(isMobile: isMobile),
          ),
        ],
      ),
      bottomNavigationBar: isMobile ? _buildBottomNavigation() : null,
    );
  }

  Widget _buildDesktopSidebar() {
    return Container(
      width: 280,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(1, 0),
          )
        ],
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: primaryColor,
                  child: Text(
                    'AU',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Admin User',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Administrador del Sistema',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildDrawerItem(Iconsax.chart_2, 'Dashboard', 0),
                _buildDrawerItem(Iconsax.box, 'Activos', 1),
                _buildDrawerItem(Iconsax.briefcase, 'Proyectos', 2),
                _buildDrawerItem(Iconsax.chart_square, 'Reportes', 3),
                _buildDrawerItem(Iconsax.people, 'Empleados', 4),
                const SizedBox(height: 24),
                _buildDrawerItem(Iconsax.setting_2, 'Configuración', 5),
                _buildDrawerItem(Iconsax.logout, 'Cerrar Sesión', 6),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://logyser.com/wp-content/uploads/2024/09/Logo-Logser.png',
                  height: 40,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 8),
                const Text(
                  'LOGYSER',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(Iconsax.chart_2, 'Dashboard', 0),
          _buildDrawerItem(Iconsax.box, 'Activos', 1),
          _buildDrawerItem(Iconsax.briefcase, 'Proyectos', 2),
          _buildDrawerItem(Iconsax.chart_square, 'Reportes', 3),
          _buildDrawerItem(Iconsax.people, 'Empleados', 4),
          const Divider(),
          _buildDrawerItem(Iconsax.setting_2, 'Configuración', 5),
          _buildDrawerItem(Iconsax.logout, 'Cerrar Sesión', 6),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Iconsax.chart_2),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.box),
          label: 'Activos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.briefcase),
          label: 'Proyectos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.chart_square),
          label: 'Reportes',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      onTap: (index) => setState(() => _selectedIndex = index),
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon,
          color: _selectedIndex == index ? primaryColor : darkTextColor),
      title: Text(
        title,
        style: TextStyle(
          color: _selectedIndex == index ? primaryColor : darkTextColor,
          fontWeight:
              _selectedIndex == index ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      selected: _selectedIndex == index,
      onTap: () {
        setState(() => _selectedIndex = index);
        Navigator.pop(context);
      },
    );
  }

  Widget _buildCurrentScreen({required bool isMobile}) {
    switch (_selectedIndex) {
      case 0:
        return DashboardScreen(isMobile: isMobile);
      case 1:
        return const AssetsScreen();
      case 2:
        return const ProjectsScreen();
      case 3:
        return const ReportsScreen();
      case 4:
        return const EmployeesScreen();
      case 5:
        return const SettingsScreen();
      default:
        return DashboardScreen(isMobile: isMobile);
    }
  }
}

class DashboardScreen extends StatelessWidget {
  final bool isMobile;
  const DashboardScreen({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: isMobile ? const EdgeInsets.all(16) : const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard',
            style: TextStyle(
              fontSize: isMobile ? 20 : 24,
              fontWeight: FontWeight.bold,
              color: darkTextColor,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: isMobile ? 2 : 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: isMobile ? 0.9 : 1.2,
            children: [
              _buildStatCard(
                  'Total Activos', '245', Iconsax.box, primaryColor, '+1.8%'),
              _buildStatCard('Asignados', '189', Iconsax.profile_2user,
                  Colors.green, '+3.4%'),
              _buildStatCard('En Reparación', '12', Iconsax.setting_2,
                  Colors.orange, '-2.1%'),
              _buildStatCard(
                  'Inactivos', '8', Iconsax.close_circle, accentColor, '+0.5%'),
            ],
          ),
          const SizedBox(height: 24),
          isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildChartCard(
          'Distribución de Activos',
          _buildCategoryChart(),
        ),
        const SizedBox(height: 16),
        _buildInfoCard(
          'Activos por Proyecto',
          _buildProjectList(),
        ),
        const SizedBox(height: 16),
        _buildInfoCard(
          'Activos Recientes',
          _buildRecentAssets(),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              _buildChartCard(
                'Distribución de Activos',
                _buildCategoryChart(),
              ),
              const SizedBox(height: 16),
              _buildChartCard(
                'Tendencia Mensual',
                _buildTrendChart(),
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              _buildInfoCard(
                'Activos por Proyecto',
                _buildProjectList(),
              ),
              const SizedBox(height: 16),
              _buildInfoCard(
                'Activos Recientes',
                _buildRecentAssets(),
              ),
              const SizedBox(height: 16),
              _buildStatsCard(
                'Resumen Financiero',
                _buildFinancialSummary(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color, String percent) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard(String title, Widget chart) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
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
    );
  }

  Widget _buildChartItem(
      String label, int value, Color color, String percentage) {
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
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          percentage,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildTrendChart() {
    return SizedBox(
      height: 200,
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
    );
  }

  Widget _buildInfoCard(String title, Widget content) {
    return Container(
      padding: const EdgeInsets.all(16),
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
            'Laptop Dell XPS', 'Pepsico Innova', Iconsax.d_cube_scan),
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
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
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
      padding: const EdgeInsets.all(16),
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
      leading: Text(
        month,
        style: const TextStyle(fontSize: 12),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
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
              Text(
                name,
                style: const TextStyle(fontSize: 12),
              ),
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
      title: Text(
        name,
        style: const TextStyle(fontSize: 12),
      ),
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
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: isMobile ? const EdgeInsets.all(16) : const EdgeInsets.all(24),
      child: const Center(
        child: Text(
          'Gestión de Activos',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: darkTextColor),
        ),
      ),
    );
  }
}

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: isMobile ? const EdgeInsets.all(16) : const EdgeInsets.all(24),
      child: const Center(
        child: Text(
          'Gestión de Proyectos',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: darkTextColor),
        ),
      ),
    );
  }
}

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: isMobile ? const EdgeInsets.all(16) : const EdgeInsets.all(24),
      child: const Center(
        child: Text(
          'Reportes y Analytics',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: darkTextColor),
        ),
      ),
    );
  }
}

class EmployeesScreen extends StatelessWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: isMobile ? const EdgeInsets.all(16) : const EdgeInsets.all(24),
      child: const Center(
        child: Text(
          'Gestión de Empleados',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: darkTextColor),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: isMobile ? const EdgeInsets.all(16) : const EdgeInsets.all(24),
      child: const Center(
        child: Text(
          'Configuración',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: darkTextColor),
        ),
      ),
    );
  }
}
