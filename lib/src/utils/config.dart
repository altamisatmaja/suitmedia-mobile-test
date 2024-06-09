part of 'util.dart';

class Config {
  static MediaQueryData? mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData!.size.width;
    screenHeight = mediaQueryData!.size.height;
  }

  static get widthSize => screenWidth;

  static get heightSize => screenHeight;

  static const spaceSmall = SizedBox(
    height: 25,
  );
  static final spaceMedium = SizedBox(
    height: screenHeight! * 0.05,
  );
  static final spaceBig = SizedBox(
    height: screenHeight! * 0.08,
  );

  static const greyColor = Color(0xFF686777);

  static const dividerColor = Color(0xFFE2E3E4);

  static const fontColor = Color(0xFF04021D);

  static const backColor = Color(0xFF554AF0);

  static const buttonColor = Color(0xFF2B637B);

  static TextStyle defaultStyle = GoogleFonts.poppins();

  static TextStyle textStyleButton = defaultStyle.copyWith(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle textStyleHeadlineLarge = defaultStyle.copyWith(
    fontSize: 30.0,
    fontWeight: FontWeight.w800,
    color: fontColor,
  );

  static TextStyle textStyleHeadlineMedium = defaultStyle.copyWith(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    color: fontColor,
  );

  static TextStyle textStyleHeadlineSmall = defaultStyle.copyWith(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: fontColor,
  );

  static TextStyle textStyleTitleLarge = defaultStyle.copyWith(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: fontColor,
  );

  static TextStyle textStyleTitleMedium = defaultStyle.copyWith(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: fontColor,
  );

  static TextStyle textStyleTitleSmall = defaultStyle.copyWith(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: fontColor,
  );

  static TextStyle textStyleBodyLarge = defaultStyle.copyWith(
    fontSize: 14.0,
    color: fontColor,
  );
  static TextStyle textStyleBodyMedium = defaultStyle.copyWith(
    fontSize: 10.0,
    color: fontColor,
    fontWeight: FontWeight.w500,
  );
}