class UserMailer < ApplicationMailer
	default from: "info@theblackandwhites.com.au"
	default name: "Black and Whites"


def answer_to_question(user, question, answer)
	@user = user
	@question = question
	@answer = answer
	
	mail(to: @user.email, subject: 'You have a new response to your question')
end

def reply_to_answer_question(question, answerer, replyer, answer, reply_answer)
	@question = question
	@answerer = answerer
	@replyer = replyer
	@answer = answer
	@reply_answer = reply_answer
	

	mail(to: @answerer.email, subject: 'A reply has been made to your response')
end

def reply_to_comment_hack(hack, commentor, replyer, comment, reply)
	@hack = hack
	@commentor = commentor
	@replyer = replyer
	@comment = comment
	@reply = reply

	mail(to: @commentor.email, subject: 'A reply has been made to your comment')
end

def admin_question_asked(user, question, admin)
	@user = user
	@question = question
	@admin = admin

	mail(to: @admin.email, subject: 'A question has been asked')
end

def admin_hack_question(user, hack, admin, comment)
	@user = user
	@hack = hack
	@comment = comment
	@admin = admin

	mail(to: @admin.email, subject: 'A comment has been added to a hack video')
end

end