package org.zerock.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect
@Log4j
@Component
public class LogAdvice {
	
	// 클래스패턴 -> SampleService* = 클래스이름이 SampleService로 시작 (SampleServiceImple도 포함된다.)
	// 파라미터패턴 -> (..) = 매개변수가 0개 이상..
	// root-context.xml에서 autoProxy설정 필요!
	@Before("execution(* org.zerock.service.SampleService*.*(..))")
	public void logBefore() {
		log.info("==============");
	}
	
	// doAdd매개변수 타입 지정 + args(str1, str2)로 파라미터 변수명 지정해서 로그로 매개변수 기록
	@Before("execution(* org.zerock.service.SampleService*.doAdd(String, String)) && args(str1, str2)")
	public void logBeforeWithParam(String str1, String str2) {
		log.info("str1: " + str1);
		log.info("str2: " + str2);
	}
	
	// 해당 메서드 처리 후에 오류가 발생한다면 이 보조업무 장착
	@AfterThrowing(pointcut = "execution(* org.zerock.service.SampleService*.*(..))", throwing="exception")
	public void  logException (Exception exception) {
		log.info("Exceptioin...!!!!");
		log.info("exception: " + exception);
	}
	
	// @Around : 직접 대상 메서드를 실행 할 수 있는 권한을 가지고 있고, 메서드의 실행 전과 후에 처리가 가능
	// ProceedingJoinPoint는 @Around어노테이션과 함께 결합해서 사용(파라미터나 예외 처리 가능)
	// ProceedingJoinPoint.proceed()로 메서드 실행
	// @Around가 먼저 동작 -> @Before -> 메서드 실행 -> @Around의 실행 후 처리
	@Around("execution(* org.zerock.service.SampleService*.*(..))")
	public Object logTime(ProceedingJoinPoint pjp) {
		
		long start = System.currentTimeMillis();
		
		log.info("Target: " + pjp.getTarget());
		log.info("Param: " + Arrays.toString(pjp.getArgs()));
		
		// invoke method
		Object result = null;
		
		try {
			result = pjp.proceed();
		}catch(Throwable e) {
			e.printStackTrace();
		}
		
		long end = System.currentTimeMillis();
		
		log.info("TIME: " + (end-start));
		
		return result;
	}
}
