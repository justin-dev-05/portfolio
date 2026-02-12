/// Portfolio data constants
class PortfolioData {
  PortfolioData._();
  
  // Personal Info
  static const String name = 'Justin Mahida';
  static const String title = 'App Developer';
  static const String tagline = 'Building digital experiences that matter';
  static const String email = 'justin.qf@gmail.com';
  static const String phone = '+1 (555) 123-4567';
  static const String location = 'Vastral,Ahmedabad';
  
  static const String aboutDescription = '''
I'm a passionate full-stack developer with over 5 years of experience creating 
beautiful, functional, and user-centered digital experiences. I specialize in 
building modern web and mobile applications using cutting-edge technologies.

My journey in software development started when I built my first website at 15. 
Since then, I've worked with startups and established companies, helping them 
bring their ideas to life through code.

When I'm not coding, you'll find me exploring new technologies, contributing to 
open-source projects, or enjoying a good cup of coffee while reading about 
design patterns and architecture.
''';
  
  // Social Links
  static const Map<String, String> socialLinks = {
    'github': 'https://github.com/alexjohnson',
    'linkedin': 'https://linkedin.com/in/alexjohnson',
    'twitter': 'https://twitter.com/alexjohnson',
    'dribbble': 'https://dribbble.com/alexjohnson',
  };
  
  // Skills
  static const List<Map<String, dynamic>> skills = [
    {
      'name': 'Flutter',
      'icon': 'flutter',
      'level': 0.95,
      'category': 'Mobile',
    },
    {
      'name': 'Dart',
      'icon': 'dart',
      'level': 0.90,
      'category': 'Language',
    },
    {
      'name': 'React',
      'icon': 'react',
      'level': 0.85,
      'category': 'Frontend',
    },
    {
      'name': 'TypeScript',
      'icon': 'typescript',
      'level': 0.88,
      'category': 'Language',
    },
    {
      'name': 'Node.js',
      'icon': 'nodejs',
      'level': 0.82,
      'category': 'Backend',
    },
    {
      'name': 'Python',
      'icon': 'python',
      'level': 0.78,
      'category': 'Language',
    },
    {
      'name': 'Firebase',
      'icon': 'firebase',
      'level': 0.85,
      'category': 'Backend',
    },
    {
      'name': 'AWS',
      'icon': 'aws',
      'level': 0.75,
      'category': 'Cloud',
    },
    {
      'name': 'Figma',
      'icon': 'figma',
      'level': 0.80,
      'category': 'Design',
    },
    {
      'name': 'Git',
      'icon': 'git',
      'level': 0.92,
      'category': 'Tools',
    },
  ];
  
  // Projects
  static const List<Map<String, dynamic>> projects = [
    {
      'id': '1',
      'title': 'E-Commerce App',
      'description': 'A full-featured e-commerce mobile application with real-time inventory, payment integration, and admin dashboard.',
      'image': 'assets/images/project_ecommerce.png',
      'technologies': ['Flutter', 'Firebase', 'Stripe', 'Node.js'],
      'githubUrl': 'https://github.com/alexjohnson/ecommerce-app',
      'liveUrl': 'https://ecommerce-demo.com',
      'category': 'Mobile App',
    },
    {
      'id': '2',
      'title': 'Task Management Platform',
      'description': 'Collaborative task management tool with real-time updates, team workspaces, and advanced analytics.',
      'image': 'assets/images/project_taskmanager.png',
      'technologies': ['React', 'TypeScript', 'Node.js', 'MongoDB'],
      'githubUrl': 'https://github.com/alexjohnson/task-manager',
      'liveUrl': 'https://taskmanager-demo.com',
      'category': 'Web App',
    },
    {
      'id': '3',
      'title': 'Health & Fitness Tracker',
      'description': 'Personal health companion app with workout tracking, nutrition logging, and progress visualization.',
      'image': 'assets/images/project_fitness.png',
      'technologies': ['Flutter', 'Health Kit', 'Charts', 'SQLite'],
      'githubUrl': 'https://github.com/alexjohnson/fitness-tracker',
      'liveUrl': 'https://fitness-demo.com',
      'category': 'Mobile App',
    },
    {
      'id': '4',
      'title': 'AI Content Generator',
      'description': 'AI-powered content creation tool that helps writers generate ideas, outlines, and full articles.',
      'image': 'assets/images/project_ai.png',
      'technologies': ['Python', 'OpenAI', 'FastAPI', 'React'],
      'githubUrl': 'https://github.com/alexjohnson/ai-content',
      'liveUrl': 'https://ai-content-demo.com',
      'category': 'Web App',
    },
    {
      'id': '5',
      'title': 'Social Media Dashboard',
      'description': 'Analytics dashboard for social media managers with scheduling, reporting, and engagement tracking.',
      'image': 'assets/images/project_dashboard.png',
      'technologies': ['Vue.js', 'D3.js', 'Express', 'PostgreSQL'],
      'githubUrl': 'https://github.com/alexjohnson/social-dashboard',
      'liveUrl': 'https://dashboard-demo.com',
      'category': 'Web App',
    },
    {
      'id': '6',
      'title': 'Travel Booking App',
      'description': 'End-to-end travel booking experience with flight search, hotel reservations, and itinerary planning.',
      'image': 'assets/images/project_travel.png',
      'technologies': ['Flutter', 'Google Maps', 'REST APIs', 'BLoC'],
      'githubUrl': 'https://github.com/alexjohnson/travel-app',
      'liveUrl': 'https://travel-demo.com',
      'category': 'Mobile App',
    },
  ];
  
  // Experience
  static const List<Map<String, dynamic>> experience = [
    {
      'company': 'TechCorp Inc.',
      'position': 'Senior Full Stack Developer',
      'period': '2022 - Present',
      'description': 'Leading development of enterprise web applications, mentoring junior developers, and implementing CI/CD pipelines.',
      'technologies': ['React', 'Node.js', 'AWS', 'Docker'],
    },
    {
      'company': 'StartupXYZ',
      'position': 'Mobile Developer',
      'period': '2020 - 2022',
      'description': 'Built cross-platform mobile apps using Flutter, implemented state management solutions, and integrated REST APIs.',
      'technologies': ['Flutter', 'Firebase', 'Dart', 'BLoC'],
    },
    {
      'company': 'Digital Agency',
      'position': 'Frontend Developer',
      'period': '2018 - 2020',
      'description': 'Developed responsive websites and web applications for various clients using modern JavaScript frameworks.',
      'technologies': ['React', 'Vue.js', 'TypeScript', 'Sass'],
    },
  ];
  
  // Services
  static const List<Map<String, dynamic>> services = [
    {
      'title': 'Mobile Development',
      'description': 'Building beautiful, performant cross-platform mobile applications using Flutter.',
      'icon': 'smartphone',
    },
    {
      'title': 'Web Development',
      'description': 'Creating responsive, modern web applications with React, Vue, or Angular.',
      'icon': 'web',
    },
    {
      'title': 'UI/UX Design',
      'description': 'Designing intuitive user interfaces and seamless user experiences.',
      'icon': 'design',
    },
    {
      'title': 'Backend Development',
      'description': 'Building scalable APIs and server-side solutions with Node.js and Python.',
      'icon': 'server',
    },
  ];
  
  // Testimonials
  static const List<Map<String, dynamic>> testimonials = [
    {
      'name': 'Sarah Williams',
      'position': 'CEO, TechStart',
      'quote': 'Alex delivered exceptional work on our mobile app. The attention to detail and code quality exceeded our expectations.',
      'avatar': 'assets/images/avatar1.png',
    },
    {
      'name': 'Michael Chen',
      'position': 'Product Manager, InnovateCo',
      'quote': 'Working with Alex was a pleasure. They understood our requirements perfectly and delivered on time.',
      'avatar': 'assets/images/avatar2.png',
    },
    {
      'name': 'Emily Rodriguez',
      'position': 'CTO, DataFlow',
      'quote': 'Alex\'s technical expertise and problem-solving skills are outstanding. Highly recommended!',
      'avatar': 'assets/images/avatar3.png',
    },
  ];
  
  // Navigation Items
  static const List<Map<String, dynamic>> navItems = [
    {'label': 'Home', 'icon': 'home', 'index': 0},
    {'label': 'About', 'icon': 'person', 'index': 1},
    {'label': 'Projects', 'icon': 'work', 'index': 2},
    {'label': 'Skills', 'icon': 'code', 'index': 3},
    {'label': 'Contact', 'icon': 'mail', 'index': 4},
  ];
}
