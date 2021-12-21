package link.jiudian.music.security.email;

import link.jiudian.music.model.Account;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;

public class LoginSuccessToken extends AbstractAuthenticationToken {

    private Account account;

    public LoginSuccessToken(Account account, Collection<? extends GrantedAuthority> authorities) {
        super(authorities);
        this.account = account;
    }

    @Override
    public Object getCredentials() {
        return null;
    }

    @Override
    public Object getPrincipal() {
        return account;
    }
}
