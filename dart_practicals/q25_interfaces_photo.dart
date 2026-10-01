// Practical 25: Multiple Interface Implementation
// Write two classes, Drawable and Resizable, used as interfaces,
// and a class Photo that implements both; populate with a file name of choice.

// Interface 1: Drawable
abstract class Drawable {
  void draw();
}

// Interface 2: Resizable
abstract class Resizable {
  void resize(int newWidth, int newHeight);
}

// Class implementing both interfaces
class Photo implements Drawable, Resizable {
  final String fileName;
  int width;
  int height;
  final String fileFormat;

  Photo({
    required this.fileName,
    required this.width,
    required this.height,
    required this.fileFormat,
  });

  @override
  void draw() {
    print('🎨 Rendering Photo "$fileName" on canvas (${width}x${height}px, Format: $fileFormat)...');
  }

  @override
  void resize(int newWidth, int newHeight) {
    print('🔄 Resizing "$fileName" from ${width}x${height}px to ${newWidth}x${newHeight}px...');
    width = newWidth;
    height = newHeight;
  }

  void printDetails() {
    print('--- Photo Details ---');
    print('  File Name   : $fileName');
    print('  Resolution  : ${width}x${height} pixels');
    print('  Format      : $fileFormat');
    print('  Aspect Ratio: ${(width / height).toStringAsFixed(2)}:1');
  }
}

void main() {
  print('========================================');
  print('Practical 25: Interfaces (Drawable, Resizable)');
  print('========================================');

  final photo = Photo(
    fileName: 'priya_campus_portrait.png',
    width: 1920,
    height: 1080,
    fileFormat: 'PNG',
  );

  photo.printDetails();
  print('----------------------------------------');
  photo.draw();
  photo.resize(1280, 720);
  photo.printDetails();
}
