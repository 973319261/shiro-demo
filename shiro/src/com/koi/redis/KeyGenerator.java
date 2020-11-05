package com.koi.redis;
import java.lang.reflect.Method;
public class KeyGenerator implements org.springframework.cache.interceptor.KeyGenerator {
    @Override
    public Object generate(Object o, Method method, Object... params) {
        //规定  本类名+方法名+参数名 为key
        StringBuilder sb = new StringBuilder();
        sb.append(o.getClass().getName());
        sb.append("-");
        sb.append(method.getName());
        sb.append("-");
        for (Object param : params) {
            sb.append(param.toString());
        }
        return sb.toString();
    }
}
