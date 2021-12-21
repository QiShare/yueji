package link.jiudian.music.controller.version;

import link.jiudian.music.framework.ServiceResponse;
import lombok.Data;

@Data
public class AppVersionResponse extends ServiceResponse {

    private String os;
    private String versionName;
    private int versionCode;
    private int forceUpdate;
    private String title;
    private String updateDesc;
    private String downloadUrl;
}
