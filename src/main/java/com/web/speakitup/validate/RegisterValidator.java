package com.web.speakitup.validate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.web.speakitup.model.MemberBean;
import com.web.speakitup.service.MemberService;

@Component
public class RegisterValidator implements Validator {

	@Autowired
	MemberService service;

	public RegisterValidator() {
		super();
	}
	
//	public RegisterValidator(MemberService service) {
//		super();
//		this.service = service;
//	}

	@Override
	public boolean supports(Class<?> clazz) {
		return MemberBean.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		MemberBean mb = (MemberBean) target;
		String id = mb.getMemberId();
		System.out.println(id);
		System.out.println("+++" + service.idExists(id));
		if (service.idExists(mb.getMemberId())) {
			errors.rejectValue("memberId", "此帳號已存在");
		}

		if (service.emailExists(mb.getEmail())) {
			errors.rejectValue("email", "此信箱已被註冊");
		}

	}

}
