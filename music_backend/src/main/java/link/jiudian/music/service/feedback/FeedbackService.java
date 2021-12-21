package link.jiudian.music.service.feedback;

import link.jiudian.music.model.Feedback;
import link.jiudian.music.repository.FeedbackRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FeedbackService {

    @Autowired
    private FeedbackRepository feedbackRepository;

    public Feedback insertFeedback(Feedback feedback) {
        return feedbackRepository.save(feedback);
    }

}
