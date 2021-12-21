package link.jiudian.music.controller.article;

import link.jiudian.music.controller.article.request.ArticleDetailRequest;
import link.jiudian.music.model.ArticleDetail;
import link.jiudian.music.service.article.ArticleDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class ArticleDetailController {

    @Autowired
    ArticleDetailService articleDetailService;

    /**
     * 乐理文章列表
     *
     * @return
     */
    @RequestMapping(value = "article/detail", method = RequestMethod.POST)
    @ResponseBody
    public ArticleDetailResponse article(@RequestBody ArticleDetailRequest request) {
        ArticleDetailResponse response = new ArticleDetailResponse();
        ArticleDetail detail = articleDetailService.getArticleDetail(request.getId());
        response.setArticleDetail(detail.getContent());
        return response;
    }

}
