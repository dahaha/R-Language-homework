/*=============================================================================
* HttpRPCRequestException.java
* Exception class for http request failure.
*==============================================================================
*
* Tested with JDK 1.6
*
* Copyright (c) 2011, Exosite LLC
* All rights reserved.
*/

package onepv1;

@SuppressWarnings("serial")
public class HttpRPCRequestException extends OneException {

	public HttpRPCRequestException(final String message) {
		super(message);
	}
}
