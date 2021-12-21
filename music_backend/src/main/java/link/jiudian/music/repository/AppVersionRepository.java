package link.jiudian.music.repository;

import link.jiudian.music.model.AppVersion;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AppVersionRepository extends JpaRepository<AppVersion, Long> {

    AppVersion findFirstAppVersionByOsOrderByVersionCodeDesc(String os);
}
