package _01_register.validate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import _01_register.model.MemberBean;
import _01_register.service.MemberService;

public class RegisterValidator implements Validator {

	@Autowired
	MemberService service;

	@Override
	public boolean supports(Class<?> clazz) {
		return MemberBean.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		MemberBean member = (MemberBean) target;

		if (service.idExists(member.getMemberId())) {
			errors.rejectValue("memberId", "此帳號已存在");
		}

		if (service.emailExists(member.getEmail())) {
			errors.rejectValue("email", "此信箱已被註冊");
		}

	}

}
