package link.jiudian.music.security.jwt;

import com.alibaba.fastjson.JSON;
import link.jiudian.music.framework.ServiceResponse;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serializable;

@Component
public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint, Serializable {
    @Override
    public void commence(HttpServletRequest request,
                         HttpServletResponse response,
                         AuthenticationException e) throws IOException {

        ServiceResponse serviceResponse = new ServiceResponse();
        serviceResponse.setCode(HttpStatus.UNAUTHORIZED.value());
        serviceResponse.setMsg("登录无效");
        response.getOutputStream().write(JSON.toJSONBytes(serviceResponse));
    }
}
