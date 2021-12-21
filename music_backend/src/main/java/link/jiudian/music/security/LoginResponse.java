package link.jiudian.music.security;

import link.jiudian.music.framework.ServiceResponse;
import lombok.Data;

@Data
public class LoginResponse extends ServiceResponse {
    private static final long serialVersionUID = 1L;

    private String email;
    private String token;

}
