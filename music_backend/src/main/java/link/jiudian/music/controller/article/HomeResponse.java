package link.jiudian.music.controller.article;

import link.jiudian.music.framework.ServiceResponse;
import lombok.Data;

import java.util.List;

@Data
public class HomeResponse extends ServiceResponse {

    private List<HomeBannerVO> banners;

}
