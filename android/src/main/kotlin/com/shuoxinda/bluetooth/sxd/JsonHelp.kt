package com.shuoxinda.bluetooth.sxd

import com.alibaba.fastjson.JSON

/**
* 规定了一个泛型T，例如传入了Record::class.java，
* 则T==Record，此时传入的Class<T> = Class<Record>
* nayClass为实际类对象
* anyClass: Class<T>表示anyClass必须为T类，也就是Record类
* 这些操作在Java称之为反射机制
*/
class JsonHelp<T : Any>(anyClass: Class<T>) {
	// 加载类到成员变量
    private val anyClass: Class<T> = anyClass
    
    /**
     * 字符转对象
     * 传入一个json字符,返回该类的实例
     */
    open fun parseToObject(string:String): Any {
       return try{
       		// 解析成功则返回结果
        	JSON.parseObject(string, anyClass) as T
        }catch(e: java.lang.Exception){
        	// 解析失败返回该类的实例Record()，也就是Java的new Record()
        	// newInstance通过内存实例化了一个对象
        	anyClass.newInstance()
        }
    }

    /**
     * 根据传入类转为json
     */
    open fun toJson(any: Any): String{
        return try{
        	JSON.toJSONString(any)
        }catch(e: java.lang.Exception){
        	""
        }
    }
}
