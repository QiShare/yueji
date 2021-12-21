package link.jiudian.music.security.email;

import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;

public class EmailToken extends AbstractAuthenticationToken {

    private String email;
    private String verifyCode;

    public EmailToken(String email, String verifyCode, Collection<? extends GrantedAuthority> authorities) {
        super(authorities);
        this.email = email;
        this.verifyCode = verifyCode;
    }

    @Override
    public Object getCredentials() {
        return verifyCode;
    }

    @Override
    public Object getPrincipal() {
        return email;
    }
}
