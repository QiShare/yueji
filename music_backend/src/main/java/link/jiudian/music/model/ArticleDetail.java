package link.jiudian.music.model;

import javax.persistence.*;

@Entity
@Table(name = "t_article_detail")
public class ArticleDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @OneToOne
    @JoinColumn(name = "title_id", referencedColumnName = "id")
    private Article title;

    private String content;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Article getTitle() {
        return title;
    }

    public void setTitle(Article title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
