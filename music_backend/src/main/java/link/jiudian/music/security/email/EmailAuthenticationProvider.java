package link.jiudian.music.security.email;

import link.jiudian.music.framework.utils.IdUtil;
import link.jiudian.music.model.Account;
import link.jiudian.music.repository.AccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.Date;

/**
 * 验证手机号和验证码是否正确
 * 到这里还没有认证，只是返回token
 * 真正认证是通过jwt token来做的
 */
@Component
public class EmailAuthenticationProvider implements AuthenticationProvider {

    @Autowired
    private AccountRepository accountRepository;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {

        EmailToken emailToken = (EmailToken) authentication;
        String email = emailToken.getPrincipal().toString();
        String smsCode = emailToken.getCredentials().toString();

        // 校验邮箱
        if (StringUtils.isEmpty(email)) {
            throw new RuntimeException("邮箱不能为空");
        }

        // 先校验验证码
        if (StringUtils.isEmpty(smsCode)) {
            throw new BadCredentialsException("验证码不能为空");
        }

        // 从redis中读取
        String smsCodeRedis = stringRedisTemplate.opsForValue().get(email);
        if (!smsCode.equals(smsCodeRedis)) {
            throw new BadCredentialsException("验证码错误");
        }

        Account existUser = accountRepository.findByEmail(email);

        if (existUser == null) {
            // 用户不存在，要先注册
            Account newUser = new Account();
            newUser.setId(IdUtil.nextId());
            newUser.setEmail(email);
            newUser.setCreateTime(new Date());
            accountRepository.save(newUser);
            existUser = newUser;
        }
        stringRedisTemplate.delete(email);
        return new LoginSuccessToken(existUser, new ArrayList<>());
    }

    @Override
    public boolean supports(Class<?> aClass) {
        return EmailToken.class.isAssignableFrom(aClass);
    }
}
