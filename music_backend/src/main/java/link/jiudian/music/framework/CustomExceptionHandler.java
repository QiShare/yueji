package link.jiudian.music.framework;

import link.jiudian.music.exception.AccountExistException;
import link.jiudian.music.exception.AccountNotExistException;
import link.jiudian.music.exception.AccountUsernamePasswordException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.CollectionUtils;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.List;


@RestControllerAdvice
@ControllerAdvice
public class CustomExceptionHandler {

    private Logger logger = LoggerFactory.getLogger(CustomExceptionHandler.class);

    @ExceptionHandler(Exception.class)
    @ResponseBody
    public Object handlerException(Exception e) {

        logger.error("exception ", e);
        ServiceResponse serviceResponse = new ServiceResponse();
        serviceResponse.setCode(500);
        if (e.getMessage() == null) {
            serviceResponse.setMsg("服务器异常");
        } else {
            serviceResponse.setMsg(e.getMessage());
        }

        return serviceResponse;
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseBody
    public Object handlerMethodArgumentNotValidException(MethodArgumentNotValidException e) {

        ServiceResponse serviceResponse = new ServiceResponse();
        serviceResponse.setCode(500);
        if (e.getMessage() == null) {
            serviceResponse.setMsg("服务器异常");
        } else {
            List<ObjectError> objectErrors = e.getBindingResult().getAllErrors();
            if (!CollectionUtils.isEmpty(objectErrors)) {
                StringBuilder msgBuilder = new StringBuilder();
                for (ObjectError objectError : objectErrors) {
                    msgBuilder.append(objectError.getDefaultMessage()).append(",");
                }
                String errorMessage = msgBuilder.toString();
                if (errorMessage.length() > 1) {
                    errorMessage = errorMessage.substring(0, errorMessage.length() - 1);
                }
                serviceResponse.setMsg(errorMessage);
            } else {
                serviceResponse.setMsg("服务器异常");
            }
        }

        return serviceResponse;
    }

    @ExceptionHandler(AccountExistException.class)
    @ResponseBody
    public Object handlerAccountExistException(AccountExistException e) {

        logger.error("account exception ", e);
        ServiceResponse serviceResponse = new ServiceResponse();
        serviceResponse.setCode(10001);
        serviceResponse.setMsg(e.getMessage());

        return serviceResponse;
    }

    @ExceptionHandler(AccountNotExistException.class)
    @ResponseBody
    public Object handlerAccountNotExistException(AccountNotExistException e) {

        logger.error("account not exception ", e);
        ServiceResponse serviceResponse = new ServiceResponse();
        serviceResponse.setCode(10002);
        serviceResponse.setMsg(e.getMessage());

        return serviceResponse;
    }

    @ExceptionHandler(AccountUsernamePasswordException.class)
    @ResponseBody
    public Object handlerAccountUsernamePasswordException(AccountUsernamePasswordException e) {

        logger.error("account username or password error exception ", e);
        ServiceResponse serviceResponse = new ServiceResponse();
        serviceResponse.setCode(10003);
        serviceResponse.setMsg(e.getMessage());

        return serviceResponse;
    }
}
