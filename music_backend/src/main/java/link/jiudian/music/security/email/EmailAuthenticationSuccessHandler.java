package link.jiudian.music.security.email;

import com.alibaba.fastjson.JSON;
import link.jiudian.music.model.Account;
import link.jiudian.music.security.LoginResponse;
import link.jiudian.music.security.jwt.JwtTokenUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 处理登录成功的类
 */
@Component
public class EmailAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        Account user = (Account) authentication.getPrincipal();
        String token = jwtTokenUtil.generateJwtToken(user.getEmail());

        LoginResponse loginResponse = new LoginResponse();
        loginResponse.setCode(0);
        loginResponse.setMsg("登录成功");
        loginResponse.setEmail(user.getEmail());
        loginResponse.setToken(token);

        response.getOutputStream().write(JSON.toJSONBytes(loginResponse));
        clearAuthenticationAttributes(request);
    }

    /**
     * Removes temporary authentication-related data which may have been stored
     * in the session during the authentication process..
     */
    protected final void clearAuthenticationAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return;
        }
        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
    }
}
