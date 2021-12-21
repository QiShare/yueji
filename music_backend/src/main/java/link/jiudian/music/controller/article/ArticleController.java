package link.jiudian.music.controller.article;

import link.jiudian.music.controller.article.request.ArticleRequest;
import link.jiudian.music.model.Article;
import link.jiudian.music.service.article.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
public class ArticleController {

    @Autowired
    ArticleService articleService;

    /**
     * 首页接口
     *
     * @return
     */
    @RequestMapping(value = "home", method = RequestMethod.GET)
    @ResponseBody
    public HomeResponse home() {
        HomeResponse response = new HomeResponse();

        List<HomeBannerVO> banners = new ArrayList<>();
        HomeBannerVO vo = new HomeBannerVO();
//        vo.setTitle("致《乐记》用户");
        vo.setImgUrl("https://jiudian-1300505017.cos.ap-beijing.myqcloud.com/banner.png");
        vo.setType(1);

        HomeBannerVO vo2 = new HomeBannerVO();
//        vo2.setTitle("致《乐记》用户");
        vo2.setImgUrl("");
        vo2.setType(1);

        HomeBannerVO vo3 = new HomeBannerVO();
//        vo3.setTitle("致《乐记》用户");
        vo3.setImgUrl("");
        vo3.setType(1);

        banners.add(vo);
//        banners.add(vo2);
//        banners.add(vo3);
        response.setBanners(banners);

        return response;
    }

    /**
     * 乐理文章列表
     *
     * @return
     */
    @RequestMapping(value = "article", method = RequestMethod.POST)
    @ResponseBody
    public ArticleResponse article(@RequestBody ArticleRequest request) {
        ArticleResponse response = new ArticleResponse();
        request.setPageSize(100);
        Pageable pageable = PageRequest.of(request.getPage(), request.getPageSize(), Sort.Direction.ASC, "id");

        List<Article> articles = articleService.getArticle(pageable).getContent();

        response.setArticles(articles);
        return response;
    }

}
