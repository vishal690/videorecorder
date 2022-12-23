import 'package:gallery_saver/gallery_saver.dart';

class GallarySaveFile {
  static void save(String filePath) {
    print('Started save in Gallary');
    GallerySaver.saveVideo(filePath);
    print('Saved in Gallary');
  }
}
