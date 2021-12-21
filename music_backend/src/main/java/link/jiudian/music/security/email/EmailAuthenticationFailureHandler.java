package link.jiudian.music.security.email;

import com.alibaba.fastjson.JSON;
import link.jiudian.music.framework.ServiceResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 处理登录失败的类
 */
@Component
public class EmailAuthenticationFailureHandler implements AuthenticationFailureHandler {

    private static final Logger logger = LoggerFactory.getLogger(EmailAuthenticationFailureHandler.class);

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException e) throws IOException {
        ServiceResponse serviceResponse = new ServiceResponse();
        serviceResponse.setCode(HttpStatus.UNAUTHORIZED.value());
        serviceResponse.setMsg("登录无效");
        response.getOutputStream().write(JSON.toJSONBytes(serviceResponse));
    }
}
