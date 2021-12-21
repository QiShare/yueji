package link.jiudian.music.controller.account.request;

import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
public class SendEmailRequest {

    @NotBlank(message = "邮箱不能为空")
    private String email;

}
