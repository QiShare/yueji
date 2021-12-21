package link.jiudian.music.controller.account;

import link.jiudian.music.controller.account.request.SendEmailRequest;
import link.jiudian.music.framework.ServiceResponse;
import link.jiudian.music.service.account.AccountService;
import link.jiudian.music.third.mail.MailUtils;
import link.jiudian.music.utils.Validator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.time.Duration;
import java.util.Random;

@RestController
public class AuthController {

    static Logger logger = LoggerFactory.getLogger(AuthController.class);

    @Autowired
    AccountService accountService;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private MailUtils mailUtils;

    @RequestMapping(value = "/auth/email/send", method = RequestMethod.POST)
    public ServiceResponse register(@Valid @RequestBody SendEmailRequest request) throws Exception {

        if (!Validator.isEmail(request.getEmail())) {
            throw new Exception("邮箱格式不正确");
        }

        String verifyCode = getRandomNumCode(4);
        stringRedisTemplate.opsForValue().set(request.getEmail(), verifyCode, Duration.ofMinutes(5));

        logger.info("验证码【" + verifyCode + "】");

        try {
            mailUtils.sendMessage(request.getEmail(), verifyCode);
        } catch (Exception e) {
        }

        return new ServiceResponse();
    }

    private String getRandomNumCode(int number) {
        String codeNum = "";
        int[] numbers = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
        Random random = new Random();
        for (int i = 0; i < number; i++) {
            int next = random.nextInt(10000);
            codeNum += numbers[next % 10];
        }
        return codeNum;
    }
}
