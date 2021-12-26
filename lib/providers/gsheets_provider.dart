import 'package:gsheets/gsheets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GsheetsProvider {
  static const credentials = r'''
  {
    "type": "service_account",
    "project_id": "collabflutter",
    "private_key_id": "908099bce2d9baa380154ab79bd0094532f71439",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDrDLOx2dRwfQzO\nxp+5+SkfIhOY3CF3apL2p3uk0wGvv6eagBdFI0dKWWU9M9/yAsl4WMEO22krY5N7\neDi4t2Lb3I5YiFLBFJ2/nBByjQ9Zt1hqKndME0qKLKIxnP0mA3KkvLecL/yLdA4B\n7sRz+mC8vyaVZj0eV8CdH2vsE+DAw5W27DGeRYDQJgZ5EmvHwaHswDFdZlZjaQKM\nt89vetWNo6FB/XZv6W7YWOvShyS7OHkPF+bmEYeKeqCRkdzRSnbXzO8tSg0A3lPd\n2KTtuIxBUU0VV7PpBnMRpvVU8CF/r7jdIqiA3NIVkc3kKBe47tMWG3dOL62Xm9dG\nHMZaLUPhAgMBAAECggEALMFYpuT1/yxEZ8vopnnjo1ay+hByO+F6VcZas+3snIkG\n8hNxOtwmiyjd7sslmViAAa8OpZRQIG+fqasgy8U5aOlEXmWosjSJe+5MsG8dDOVt\nC5wF5qGmuAwbHwzII/iUl/sKEA6QDQKeVy5eUEIMsOvJvjk/KnulhJVy0HsReMp3\nkfZGRSJtu3Wr8cvc+Q+tqcKZ9HTlyjA7pnP1HTAwqyf3NeTGQWSnndYYNQoXs/L5\nRRXtaF4PuBZB95TGLFBq97tKmWYy+ZTO8JnjTQ6970Q9d+F+c5rImz7Zml72auv4\n6/mXOtdZHVoD06Tugde1AaQQkqRpL5/irDl+fn6XhQKBgQD7ZNitTlp/GL8KoQZL\nsb0ifGyloSyoW0mw7ZZe3e+QHb16xiPZAByI6DboDmf2DP3eXHSqadyK2/A9tqV0\nVXwHjTEUfCrXcEYjQ+CVJlBIDDGvUic4wkDBxkNgiG0vN7GPBanm0I44VKM8txLE\n2Ou5wNp2xTWyPFvbADciKc05tQKBgQDvWzFyy1oXpNvalbi6Enxkc+VIw2Sl9mWj\nCpSILEwATMzqJbVaFTvzPKoWx9gfxUIk5nGkRi6DSC/suTusIn417cS/vy8R35oK\nd1VJ0l8h4X2z8mJ2v73gj2bd4jr0K8RAzyXFDKXkbcb+0IkPd8GZGlAvEE2ekSLM\nA8DvjkPM/QKBgEwuX0sFd38UbLA348SEdCBDPFlk4jeSkl4/YVYWQ0aU/Jp7+NkF\no6AJXrorw21YuoXr1p7dvauGwuKwuqrqTM+tBbaDeigXKen948zO830h1NygNKqK\nkz0la72RGiU452HEAZykjrSbUWxQvitQ4P5FZu6fDIqap+tRwWNk74ARAoGAOwnO\nT5dS+IQEao0FjHfk0M45XtI7MChvd2CztEbg1C4dWR/F9JtKNzveZFIUv/li0EE7\nBJ7++AjFMWmbC2FSqjCkl/srPAhgMXavxc6rAmthGxKNMOcoiYw1fkM/8VweQzIV\nCd6NyKM/MzjypasPSJlR79ngm10HLTU70JrRpG0CgYEAlU+ZRSOhIOBEbtE5A+or\nwR0bO4fHD7EksEZnipxrg+BHpOTQcFf9YHFCQK2/1YBzdqdlfOiB2LTbmqalz3on\n1wSzGZtIpE2LopAa7WZnt0n7Po0PdNEZOw2VCKSchqArlgpOgH68NrVWqEvmAdJh\nud3QL1LMsHPfqRkDlQUN5Os=\n-----END PRIVATE KEY-----\n",
    "client_email": "collabflutter@appspot.gserviceaccount.com",
    "client_id": "103526504264684274079",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/collabflutter%40appspot.gserviceaccount.com"
  }
  ''';  

  static final gsheetsProvider = Provider((ref) {
    final gsheets = GSheets(GsheetsProvider.credentials);
    return gsheets;
  });  
}