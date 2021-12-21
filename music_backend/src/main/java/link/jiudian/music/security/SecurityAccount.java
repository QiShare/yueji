package link.jiudian.music.security;

import link.jiudian.music.model.Account;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

public class SecurityAccount {

    public static Account getCurrentAccount() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication.getPrincipal() instanceof Account) {
            return (Account) authentication.getPrincipal();
        }
        return null;
    }
}
