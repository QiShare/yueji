package link.jiudian.music.framework.utils;

public class AppVersionUtils {


    public static final int VERSION_HAS_NEW = 1;

    /**
     * @param newVer
     * @param oldVer
     * @return 0 旧版本与新版本相同
     * -1 旧版本比新版本大
     * 1  旧版本比新版本小，即有新版本
     */
    public static int versionNameCompare(String oldVer, String newVer) {

        String[] oldArr = newVer.split("\\.");
        String[] newArr = oldVer.split("\\.");

        int i = 0;
        int diff = oldArr.length - newArr.length;

        while (diff == 0
                && i < oldArr.length
                && (diff = oldArr[i].length() - newArr[i].length()) == 0
                && (diff = oldArr[i].compareToIgnoreCase(newArr[i])) == 0) {
            ++i;
        }
        if (diff > 0) {
            return 1;
        } else if (diff < 0) {
            return -1;
        }
        return 0;
    }

    /**
     * @param newVer
     * @param oldVer
     * @return 0 旧版本与新版本相同
     * -1 旧版本比新版本大
     * 1  旧版本比新版本小，即有新版本
     */
    public static int versionCodeCompare(int oldVer, int newVer) {
        int diff = newVer - oldVer;

        if (diff > 0) {
            return 1;
        } else if (diff < 0) {
            return -1;
        }
        return 0;
    }

    public static void main(String[] args) {
        String oldVer = "0.4.11";
        String newVer = "0.4.11";

        int result = versionNameCompare(oldVer, newVer);
        System.out.println("版本比较结果" + result);
    }
}
