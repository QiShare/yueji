package link.jiudian.music.controller.article;

import link.jiudian.music.framework.ServiceResponse;
import link.jiudian.music.model.Article;
import lombok.Data;

import java.util.List;

@Data
public class ArticleResponse extends ServiceResponse {

    private List<Article> articles;

}
