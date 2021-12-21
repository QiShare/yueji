package link.jiudian.music.security.jwt;

import link.jiudian.music.model.Account;
import link.jiudian.music.repository.AccountRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.ArrayList;

@Component
public class JwtAuthenticationProvider implements AuthenticationProvider {
    private static final Logger LOGGER = LoggerFactory.getLogger(JwtAuthenticationProvider.class);

    @Autowired
    private JwtTokenUtil jwtUtil;

    @Autowired
    private AccountRepository accountRepository;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        try {
            String token = (String) authentication.getCredentials();
            String email = jwtUtil.parseJwtToken(token);

            if (StringUtils.isEmpty(email)) {
                throw new BadCredentialsException("token无效");
            }
            Account account = accountRepository.findByEmail(email);
            CustomAuthenticationToken authToken = new CustomAuthenticationToken(account, null, new ArrayList<>());

            SecurityContextHolder.getContext().setAuthentication(authentication);
            return authToken;

        } catch (BadCredentialsException e) {
            throw new BadCredentialsException("token校验失败");
        } catch (Exception e) {
            LOGGER.error("登录异常", e);
            throw new BadCredentialsException("登录异常");
        }
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return JwtAuthToken.class.equals(authentication);
    }
}
