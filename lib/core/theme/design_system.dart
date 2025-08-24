import 'package:flutter/material.dart';
import 'app_theme.dart';

/// Design System - A collection of reusable design components and tokens
class DesignSystem {
  // Private constructor to prevent instantiation
  DesignSystem._();

  // ===== SPACING SYSTEM =====
  static const EdgeInsets padding4 = EdgeInsets.all(AppTheme.spacing4);
  static const EdgeInsets padding8 = EdgeInsets.all(AppTheme.spacing8);
  static const EdgeInsets padding12 = EdgeInsets.all(AppTheme.spacing12);
  static const EdgeInsets padding16 = EdgeInsets.all(AppTheme.spacing16);
  static const EdgeInsets padding20 = EdgeInsets.all(AppTheme.spacing20);
  static const EdgeInsets padding24 = EdgeInsets.all(AppTheme.spacing24);
  static const EdgeInsets padding32 = EdgeInsets.all(AppTheme.spacing32);
  static const EdgeInsets padding40 = EdgeInsets.all(AppTheme.spacing40);
  static const EdgeInsets padding48 = EdgeInsets.all(AppTheme.spacing48);

  static const EdgeInsets paddingH16 = EdgeInsets.symmetric(horizontal: AppTheme.spacing16);
  static const EdgeInsets paddingH24 = EdgeInsets.symmetric(horizontal: AppTheme.spacing24);
  static const EdgeInsets paddingV16 = EdgeInsets.symmetric(vertical: AppTheme.spacing16);
  static const EdgeInsets paddingV24 = EdgeInsets.symmetric(vertical: AppTheme.spacing24);

  // ===== BORDER RADIUS SYSTEM =====
  static const BorderRadius radius4 = BorderRadius.all(Radius.circular(AppTheme.radius4));
  static const BorderRadius radius8 = BorderRadius.all(Radius.circular(AppTheme.radius8));
  static const BorderRadius radius12 = BorderRadius.all(Radius.circular(AppTheme.radius12));
  static const BorderRadius radius16 = BorderRadius.all(Radius.circular(AppTheme.radius16));
  static const BorderRadius radius20 = BorderRadius.all(Radius.circular(AppTheme.radius20));
  static const BorderRadius radius24 = BorderRadius.all(Radius.circular(AppTheme.radius24));

  // ===== SHADOW SYSTEM =====
  static const List<BoxShadow> shadow1 = [
    BoxShadow(
      color: AppTheme.shadowColor,
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> shadow2 = [
    BoxShadow(
      color: AppTheme.shadowColor,
      offset: Offset(0, 2),
      blurRadius: 6,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> shadow4 = [
    BoxShadow(
      color: AppTheme.shadowColor,
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> shadow8 = [
    BoxShadow(
      color: AppTheme.shadowColor,
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> shadow16 = [
    BoxShadow(
      color: AppTheme.shadowColor,
      offset: Offset(0, 16),
      blurRadius: 48,
      spreadRadius: 0,
    ),
  ];

  // ===== GRADIENT SYSTEM =====
  static const LinearGradient primaryGradient = AppTheme.primaryGradient;
  static const LinearGradient accentGradient = AppTheme.accentGradient;
  static const LinearGradient highlightGradient = AppTheme.highlightGradient;

  // ===== ANIMATION DURATIONS =====
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);

  // ===== ANIMATION CURVES =====
  static const Curve curveFast = Curves.easeInOut;
  static const Curve curveNormal = Curves.easeInOutCubic;
  static const Curve curveSlow = Curves.easeInOutQuart;

  // ===== RESPONSIVE BREAKPOINTS =====
  static const double breakpointMobile = 600;
  static const double breakpointTablet = 900;
  static const double breakpointDesktop = 1200;

  // ===== COMMON DECORATIONS =====
  static BoxDecoration get cardDecoration => BoxDecoration(
    color: AppTheme.surfaceColor,
    borderRadius: radius16,
    boxShadow: shadow2,
  );

  static BoxDecoration get elevatedCardDecoration => BoxDecoration(
    color: AppTheme.surfaceColor,
    borderRadius: radius16,
    boxShadow: shadow4,
  );

  static BoxDecoration get primaryCardDecoration => BoxDecoration(
    gradient: primaryGradient,
    borderRadius: radius16,
    boxShadow: shadow4,
  );

  static BoxDecoration get accentCardDecoration => BoxDecoration(
    gradient: accentGradient,
    borderRadius: radius16,
    boxShadow: shadow4,
  );

  static BoxDecoration get highlightCardDecoration => BoxDecoration(
    gradient: highlightGradient,
    borderRadius: radius16,
    boxShadow: shadow2,
  );

  // ===== COMMON SHAPES =====
  static const RoundedRectangleBorder roundedRectangle8 = RoundedRectangleBorder(
    borderRadius: radius8,
  );

  static const RoundedRectangleBorder roundedRectangle12 = RoundedRectangleBorder(
    borderRadius: radius12,
  );

  static const RoundedRectangleBorder roundedRectangle16 = RoundedRectangleBorder(
    borderRadius: radius16,
  );

  static const RoundedRectangleBorder roundedRectangle20 = RoundedRectangleBorder(
    borderRadius: radius20,
  );

  static const RoundedRectangleBorder roundedRectangle24 = RoundedRectangleBorder(
    borderRadius: radius24,
  );

  // ===== COMMON BORDERS =====
  static const BorderSide borderLight = BorderSide(
    color: AppTheme.borderColor,
    width: 1,
  );

  static const BorderSide borderMedium = BorderSide(
    color: AppTheme.borderColor,
    width: 1.5,
  );

  static const BorderSide borderHeavy = BorderSide(
    color: AppTheme.borderColor,
    width: 2,
  );

  static const BorderSide primaryBorder = BorderSide(
    color: AppTheme.primaryColor,
    width: 2,
  );

  // ===== COMMON PADDINGS =====
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: AppTheme.spacing24,
    vertical: AppTheme.spacing12,
  );

  static const EdgeInsets cardPadding = EdgeInsets.all(AppTheme.spacing20);
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: AppTheme.spacing16,
    vertical: AppTheme.spacing12,
  );

  static const EdgeInsets sectionPadding = EdgeInsets.all(AppTheme.spacing24);
  static const EdgeInsets screenPadding = EdgeInsets.all(AppTheme.spacing16);

  // ===== COMMON MARGINS =====
  static const EdgeInsets margin8 = EdgeInsets.all(AppTheme.spacing8);
  static const EdgeInsets margin16 = EdgeInsets.all(AppTheme.spacing16);
  static const EdgeInsets margin24 = EdgeInsets.all(AppTheme.spacing24);
  static const EdgeInsets margin32 = EdgeInsets.all(AppTheme.spacing32);

  static const EdgeInsets marginH16 = EdgeInsets.symmetric(horizontal: AppTheme.spacing16);
  static const EdgeInsets marginH24 = EdgeInsets.symmetric(horizontal: AppTheme.spacing24);
  static const EdgeInsets marginV16 = EdgeInsets.symmetric(vertical: AppTheme.spacing16);
  static const EdgeInsets marginV24 = EdgeInsets.symmetric(vertical: AppTheme.spacing24);

  // ===== COMMON SIZES =====
  static const double iconSizeSmall = 16;
  static const double iconSizeMedium = 24;
  static const double iconSizeLarge = 32;
  static const double iconSizeXLarge = 48;

  static const double buttonHeight = 48;
  static const double buttonHeightSmall = 40;
  static const double buttonHeightLarge = 56;

  static const double cardMinHeight = 120;
  static const double cardMinHeightSmall = 80;
  static const double cardMinHeightLarge = 160;

  // ===== RESPONSIVE HELPERS =====
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < breakpointMobile;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= breakpointMobile && width < breakpointTablet;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= breakpointTablet;
  }

  static double getResponsiveValue(
    BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  static EdgeInsets getResponsivePadding(
    BuildContext context, {
    required EdgeInsets mobile,
    required EdgeInsets tablet,
    required EdgeInsets desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  static int getResponsiveGridCount(BuildContext context) {
    if (isMobile(context)) return 2;
    if (isTablet(context)) return 3;
    return 4;
  }

  // ===== ANIMATION HELPERS =====
  static Animation<double> fadeInAnimation(
    AnimationController controller, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: curve,
      ),
    );
  }

  static Animation<Offset> slideUpAnimation(
    AnimationController controller, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOutCubic,
  }) {
    return Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: curve,
      ),
    );
  }

  static Animation<double> scaleAnimation(
    AnimationController controller, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.elasticOut,
  }) {
    return Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: curve,
      ),
    );
  }

  // ===== COMMON STYLES =====
  static const TextStyle cardTitleStyle = AppTheme.titleStyle;
  static const TextStyle cardSubtitleStyle = AppTheme.bodyMedium;
  static const TextStyle cardBodyStyle = AppTheme.bodyStyle;
  static const TextStyle cardCaptionStyle = AppTheme.captionStyle;

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: 'Cairo',
    color: Colors.white,
  );

  static const TextStyle inputLabelStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: 'Cairo',
    color: AppTheme.textSecondaryColor,
  );

  static const TextStyle inputHintStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: 'Cairo',
    color: AppTheme.textTertiaryColor,
  );
}
