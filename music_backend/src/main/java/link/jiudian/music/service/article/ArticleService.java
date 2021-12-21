package link.jiudian.music.service.article;

import link.jiudian.music.model.Article;
import link.jiudian.music.repository.ArticleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class ArticleService {

    @Autowired
    private ArticleRepository articleRepository;

    public Page<Article> getArticle(Pageable pageable) {
        Page<Article> articles = articleRepository.findAll(pageable);
        return articles;
    }
}
