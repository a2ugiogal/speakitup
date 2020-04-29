package com.web.speakitup.validate;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.web.speakitup.model.MemberBean;
import com.web.speakitup.service.MemberService;

public class RegisterValidator implements Validator {

	MemberService service;

	public RegisterValidator() {
		super();
	}

	public RegisterValidator(MemberService service) {
		super();
		this.service = service;
	}

	@Override
	public boolean supports(Class<?> clazz) {
		return MemberBean.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		MemberBean mb = (MemberBean) target;
		if (service.idExists(mb.getMemberId())) {
			errors.rejectValue("memberId", "memberBean.memberId.exist");
		}

		if (service.emailExists(mb.getEmail())) {
			errors.rejectValue("email", "memberBean.email.exist");
		}

	}

}
