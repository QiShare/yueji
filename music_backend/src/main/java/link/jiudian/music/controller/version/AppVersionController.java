package link.jiudian.music.controller.version;

import link.jiudian.music.model.AppVersion;
import link.jiudian.music.service.version.AppVersionService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@RestController
public class AppVersionController {

    Logger logger = LoggerFactory.getLogger(AppVersionController.class);

    @Autowired
    AppVersionService appVersionService;

    @RequestMapping(value = "/check/update", method = RequestMethod.POST)
    public AppVersionResponse checkUpdate(@RequestHeader(name = "os") String os) {

        AppVersionResponse response = new AppVersionResponse();

        AppVersion appVersion = appVersionService.getLatestAppVersion(os);

        if (appVersion == null) {
            throw new RuntimeException("版本信息不存在");
        } else {
            response.setOs(appVersion.getOs());
            response.setTitle(appVersion.getVersionName() + " 震撼来袭！");
            response.setVersionName(appVersion.getVersionName());
            response.setVersionCode(appVersion.getVersionCode());
            response.setForceUpdate(appVersion.getForceUpdate());
            response.setUpdateDesc(appVersion.getUpdateDesc());
            response.setDownloadUrl(appVersion.getDownloadUrl());
        }

        return response;
    }

    @GetMapping("/download/android")
    public void downloadPDFResource(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String path = System.getProperty("user.dir") + "/yueji.apk";
        logger.info("download path {}", path);
        File file = new File(path);
        if (file.exists()) {
            String mimeType = URLConnection.guessContentTypeFromName(file.getName());
            if (mimeType == null) {
                mimeType = "application/octet-stream";
            }
            response.setContentType(mimeType);
            String fileName = URLEncoder.encode(file.getName(), StandardCharsets.UTF_8.toString());
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"; filename*=utf-8''" + fileName);
            response.setContentLength((int) file.length());
            InputStream inputStream = new BufferedInputStream(new FileInputStream(file));
            FileCopyUtils.copy(inputStream, response.getOutputStream());
        }
    }
}
