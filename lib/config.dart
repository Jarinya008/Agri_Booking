class ApiConfig {
  // URL ของ API ที่ใช้ใน development
  // static const String baseUrl =
  //     "http://192.168.215.78:3001"; // เปลี่ยนที่นี่เมื่อเซิร์ฟเวอร์อยู่ในเครื่อง

  // static const String baseUrl = "http://192.168.187.78:3001";
  static const String baseUrl = "https://agri-api-glxi.onrender.com";
//  static const String baseUrl = "http://localhost:3000";

  // ตัวอย่าง Endpoint
  static const String registerUser = "$baseUrl/general/register";
  static const String loginUser = "$baseUrl/general/login";

  static const String insertFarm = "$baseUrl/client/insert/farm";
  static const String updateFarm = "$baseUrl/client/update/farm";
  static const String deleteFarm = "$baseUrl/client/delete/farm";
  static const String getFarmList = "$baseUrl/client/farms";

  // เพิ่ม Endpoint อื่น ๆ ที่ต้องการ
}
