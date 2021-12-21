package link.jiudian.music.service.article;

import link.jiudian.music.model.ArticleDetail;
import link.jiudian.music.repository.ArticleDetailRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ArticleDetailService {

    @Autowired
    private ArticleDetailRepository articleDetailRepository;

    /**
     * 获取乐理详情
     *
     * @param id
                * @return
     */
        public ArticleDetail getArticleDetail(long id) {
        if (articleDetailRepository.findById(id) != null) {
            return articleDetailRepository.findById(id).get();
        }
        return null;
    }
}
