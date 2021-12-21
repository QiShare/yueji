package link.jiudian.music.service.version;

import link.jiudian.music.model.AppVersion;
import link.jiudian.music.repository.AppVersionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AppVersionService {

    @Autowired
    AppVersionRepository appVersionRepository;

    /**
     * 根据操作系统获取最新的 app 版本
     *
     * @param os
     * @return
     */
    public AppVersion getLatestAppVersion(String os) {
        return appVersionRepository.findFirstAppVersionByOsOrderByVersionCodeDesc(os);
    }
}
