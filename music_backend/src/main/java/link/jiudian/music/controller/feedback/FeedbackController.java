package link.jiudian.music.controller.feedback;

import link.jiudian.music.controller.feedback.request.FeedbackRequest;
import link.jiudian.music.framework.ServiceResponse;
import link.jiudian.music.model.Feedback;
import link.jiudian.music.service.account.AccountService;
import link.jiudian.music.service.feedback.FeedbackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

@RestController
public class FeedbackController {

    @Autowired
    FeedbackService feedbackService;

    @Autowired
    AccountService accountService;

    /**
     * 用户反馈
     *
     * @return
     */
    @RequestMapping(value = "feedback", method = RequestMethod.POST)
    @ResponseBody
    public ServiceResponse feedback(@RequestBody FeedbackRequest request) {
        ServiceResponse response = new ServiceResponse();

        Feedback feedback = new Feedback();
        feedback.setCreateTime(new Date());
        feedback.setContent(request.getContent());

        feedbackService.insertFeedback(feedback);

        return response;
    }

}
