class CreativeModel {
  final String imageUrl;
  final String type;

  CreativeModel({required this.imageUrl, required this.type});

  factory CreativeModel.fromJson(Map<String, dynamic> json) {
    String raw = json['image'] ?? "";

    /// 🔥 STEP 1: REMOVE EXTRA TEXT
    String clean = raw.replaceAll("Image preview", "").trim();

    /// 🔥 STEP 2: ENCODE URL (VERY IMPORTANT)
    String encodedUrl = Uri.encodeFull(clean);

    /// 🔥 DETECT TYPE
    String type = "image";

    if (encodedUrl.toLowerCase().endsWith(".pdf")) {
      type = "pdf";
    } else if (encodedUrl.toLowerCase().endsWith(".mp4")) {
      type = "video";
    }

    return CreativeModel(imageUrl: encodedUrl, type: type);
  }
}
