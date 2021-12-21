package link.jiudian.music.controller.feedback.request;

import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
public class FeedbackRequest {

    @NotBlank(message = "内容不能为空")
    private String content;

}
