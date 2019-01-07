package first.common.logger;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

@Aspect
public class LoggerAspect {
	
	protected Log log=LogFactory.getLog(LoggerAspect.class);
	static String name="";
	static String type="";
	
	//어떤 계층의 어떤 메서드가 실행되었는지를 보여주는 역할을 한다.
	//first.common(or)sample.controller.blahblahController or first.common(or)sample.service.blahblahImpl or first.(anyname).dao.blahblahDAO 
	@Around("execution(* first..controller.*Controller.*(..)) or execution(* first..service.*Impl.*(..)) or execution(* first..dao.*DAO.*(..))")
	public Object logPrint(ProceedingJoinPoint joinPoint) throws Throwable{
		type=joinPoint.getSignature().getDeclaringTypeName();
		
		if(type.indexOf("Controller") > -1) { //Controller 라는 이름이 있을 때
			name="Controller \t  :  ";
		}
		else if(type.indexOf("Service") > -1) { //Service 라는 이름이 있을 때
			name ="ServiceImple  \t:  ";
		}
		else if(type.indexOf("DAO") > -1) { //DAO라는 이름이 있을 때
			name="DAO  \t\t:  ";
		}
		log.debug(name + type + "." + joinPoint.getSignature().getName() + "()");
		return joinPoint.proceed();
	}
}
