import 'package:flutter/material.dart';

void main() {
  runApp(const NetplakApp());
}

class NetplakApp extends StatelessWidget {
  const NetplakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Netplak',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0B0B),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE50914),
          brightness: Brightness.dark,
        ),
        fontFamily: 'Arial',
      ),
      home: const HomePage(),
    );
  }
}

class Movie {
  const Movie({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.description,
  });

  final String title;
  final String subtitle;
  final String imageUrl;
  final String description;
}

const featuredMovies = [
  Movie(
    title: 'STRANGER THINGS',
    subtitle: 'Season 4 • 2022 • 16+',
    imageUrl:
        'https://image.tmdb.org/t/p/original/x2LSRK2Cm7MZhjluni1msVJ3wDF.jpg',
    description:
        'Sebuah kota kecil menyimpan rahasia besar. Temukan kisah mereka yang berani melawan dunia lain.',
  ),
  Movie(
    title: 'THE WITCHER',
    subtitle: 'Season 3 • 2023 • 18+',
    imageUrl:
        'https://image.tmdb.org/t/p/original/cZ0d3rtvXPVvuiOzr9JFA8dM3e8.jpg',
    description:
        'Geralt menjalani perjalanan penuh monster, sihir, dan pilihan sulit demi melindungi orang yang dicintainya.',
  ),
  Movie(
    title: 'ARCANE',
    subtitle: 'Season 1 • 2021 • 13+',
    imageUrl:
        'https://image.tmdb.org/t/p/original/fqldf2t8ztc9aiwn3k6mlX3tvRT.jpg',
    description:
        'Dua saudari dari kota yang berlawanan terjebak dalam konflik yang mengubah masa depan mereka.',
  ),
];

const popularMovies = [
  'https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg',
  'https://image.tmdb.org/t/p/w500/1X4h40fcB4L2BsY7j0EmTPQYj1E.jpg',
  'https://image.tmdb.org/t/p/w500/2zmTngn1tYC1AvfnrFLhxeD82hz.jpg',
  'https://image.tmdb.org/t/p/w500/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg',
  'https://image.tmdb.org/t/p/w500/5ik4ATKmNtmJU6AYD0bLm56BCVM.jpg',
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(viewportFraction: 0.88);
  int _selectedMovie = 0;
  int _selectedTab = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildFeaturedSlider()),
            SliverToBoxAdapter(child: _buildSectionTitle('Popular di Netplak')),
            SliverToBoxAdapter(child: _buildMovieRow()),
            SliverToBoxAdapter(child: _buildSectionTitle('Lanjutkan Menonton')),
            SliverToBoxAdapter(child: _buildContinueWatching()),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
      child: Row(
        children: [
          const Text(
            'NETPLAK',
            style: TextStyle(
              color: Color(0xFFE50914),
              fontSize: 24,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded),
            tooltip: 'Cari',
          ),
          const CircleAvatar(
            radius: 17,
            backgroundColor: Color(0xFF303030),
            child: Icon(Icons.person, size: 20, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedSlider() {
    return Column(
      children: [
        SizedBox(
          height: 430,
          child: PageView.builder(
            controller: _pageController,
            itemCount: featuredMovies.length,
            onPageChanged: (index) {
              setState(() => _selectedMovie = index);
            },
            itemBuilder: (context, index) {
              final movie = featuredMovies[index];
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: _MovieHeroCard(movie: movie),
              );
            },
          ),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            featuredMovies.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 4,
              width: index == _selectedMovie ? 22 : 6,
              decoration: BoxDecoration(
                color: index == _selectedMovie
                    ? const Color(0xFFE50914)
                    : Colors.white38,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMovieRow() {
    return SizedBox(
      height: 205,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: popularMovies.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) => _PosterImage(
          imageUrl: popularMovies[index],
          width: 124,
          height: 185,
        ),
      ),
    );
  }

  Widget _buildContinueWatching() {
    return SizedBox(
      height: 120,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        children: const [
          _ContinueCard(
            title: 'Wednesday',
            imageUrl:
                'https://image.tmdb.org/t/p/w500/9PFonBhy4cQy7Jz20NpMygczOkv.jpg',
            progress: 0.62,
          ),
          _ContinueCard(
            title: 'Breaking Bad',
            imageUrl:
                'https://image.tmdb.org/t/p/w500/ztkUQFLlC19CCMYHW9o1zWhJRNq.jpg',
            progress: 0.35,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return NavigationBar(
      backgroundColor: const Color(0xFF111111),
      indicatorColor: const Color(0x33E50914),
      selectedIndex: _selectedTab,
      onDestinationSelected: (index) => setState(() => _selectedTab = index),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Beranda',
        ),
        NavigationDestination(
          icon: Icon(Icons.download_outlined),
          selectedIcon: Icon(Icons.download),
          label: 'Download',
        ),
        NavigationDestination(
          icon: Icon(Icons.menu_outlined),
          selectedIcon: Icon(Icons.menu),
          label: 'Lainnya',
        ),
      ],
    );
  }
}

class _MovieHeroCard extends StatelessWidget {
  const _MovieHeroCard({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            movie.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: Colors.grey[900]),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xEE080808)],
                stops: [0.35, 1],
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  movie.subtitle,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70, height: 1.25),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.play_arrow, size: 20),
                      label: const Text('Putar'),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add, size: 20),
                      label: const Text('Daftar'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white54),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PosterImage extends StatelessWidget {
  const _PosterImage({
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  final String imageUrl;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: width,
          height: height,
          color: Colors.grey[900],
          child: const Icon(Icons.movie_outlined, color: Colors.white38),
        ),
      ),
    );
  }
}

class _ContinueCard extends StatelessWidget {
  const _ContinueCard({
    required this.title,
    required this.imageUrl,
    required this.progress,
  });

  final String title;
  final String imageUrl;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 245,
      margin: const EdgeInsets.only(right: 12),
      child: Row(
        children: [
          _PosterImage(imageUrl: imageUrl, width: 78, height: 110),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 4,
                  backgroundColor: Colors.white24,
                  color: const Color(0xFFE50914),
                ),
                const SizedBox(height: 6),
                Text(
                  '${(progress * 100).round()}% selesai',
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
