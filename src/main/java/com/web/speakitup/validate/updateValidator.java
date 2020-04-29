package com.web.speakitup.validate;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.web.speakitup.model.MemberBean;

public class updateValidator implements Validator{
	
	public updateValidator() {
		super();
	}

	@Override
	public boolean supports(Class<?> clazz) {
		return MemberBean.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		// TODO Auto-generated method stub
		
	}
	
}
