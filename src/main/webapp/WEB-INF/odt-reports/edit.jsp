<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="taskType" scope="session" value="${f:endsWith(requestScope['javax.servlet.forward.request_uri'], '/edit') ? 'edit' : 'add'}"/>

<h1>
	<spring:message code="pages.${taskType}.title"/>
</h1>

<form class="form-horizontal" enctype="multipart/form-data" action="" method="post" role="form">
    <div class="form-group ${errors.onKey != null ? 'has-error' : ''}">
    	<label for="ReportKey" class="col-sm-2 control-label"><spring:message code="pages.edit.label.key"/>:</label>
    	<div class="col-sm-6">
      		<input class="form-control" required type="text" name="key" id="ReportKey" placeholder="<spring:message code="pages.edit.label.key"/>..." value="${reportKey}">
      		<c:if test="${errors.onKey != null}"><p class="text-danger"><spring:message code="${errors.onKey}"/></p></c:if>
    	</div>
  	</div>
  	
  	<div class="form-group ${errors.onName != null ? 'has-error' : ''}">
    	<label for="ReportName" class="col-sm-2 control-label"><spring:message code="pages.edit.label.name"/>:</label>
    	<div class="col-sm-6">
      		<input bennu-localized-string required-any name="name" id="ReportName" placeholder="<spring:message code="pages.edit.label.name"/>..." value='${reportName}' />
      		<c:if test="${errors.onName != null}"><p class="text-danger"><spring:message code="${errors.onName}"/></p></c:if>
    	</div>
  	</div>

    <div class="form-group ${errors.onDescription != null ? 'has-error' : ''}">
    	<label for="ReportDescription" class="col-sm-2 control-label"><spring:message code="pages.edit.label.description"/>:</label>
    	<div class="col-sm-6">
      		<textarea bennu-localized-string required-any name="description" id="ReportDescription" placeholder="<spring:message code="pages.edit.label.description"/>...">${reportDescription}</textarea>
      		<c:if test="${errors.onDescription != null}"><p class="text-danger"><spring:message code="${errors.onDescription}"/></p></c:if>
    	</div>
  	</div>
  	<c:forEach var="locale" items="${locales}" varstatus="status">
	    <div class="form-group ${errors.onFile != null ? 'has-error' : ''}">
	        <label for="ReportTemplateFile" class="col-sm-2 control-label">locale.toString() <spring:message code="pages.edit.label.file"/>:</label>
	        <div class="col-sm-6">
	            <input class="form-control" type="file" name="files[status.index]" class="form-control" id="ReportTemplateFile" placeholder="<spring:message code="pages.edit.label.file"/>...">
	            <c:if test="${errors.onFile != null}"><p class="text-danger"><spring:message code="${errors.onFile}"/></p></c:if>
	        </div>
	    </div>
    </c:forEach>

    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-3">
            <button type="submit" class="btn btn-default btn-primary">
				<spring:message code="action.${taskType}"/>
			</button>
        </div>
    </div>
    
</form>

<c:if test="${not empty reportPreviousFiles}">
    <h3><spring:message code="pages.edit.label.template.previous"/></h3>
    <table class="table table-striped">
      	<thead>
        	<tr>
         		<th class="col-md-5"><spring:message code="pages.edit.label.name"/></th>
         		<th class="col-md-2 text-center"><spring:message code="pages.edit.label.date"/></th>
         		<th class="col-md-2 text-center"><spring:message code="pages.edit.label.size"/></th>
         		<th class="col-md-3 text-center"><spring:message code="pages.edit.label.link"/></th>
        	</tr>
      	</thead>
     	<tbody>
			<c:forEach var="locale" items="${locales}">
				<tr><td>${locale.toString()}</td></tr>
				<c:if test="${not empty reportPreviousFiles.get(locale)}">
					<c:forEach var="file" items="${reportPreviousFiles.get(locale)}">
						<tr>
							<td class="col-md-5">${file.name}</td>
							<td class="col-md-2 text-center">${file.date}</td>
							<td class="col-md-2 text-center">${file.size}</td>
							<td class="col-md-3 text-center">
								<div class="btn-group">
									<a href="${file.link}" class="btn btn-sm btn-default">
										<spring:message code="action.download"/>
									</a>
		           				</div>
		           			</td>
						</tr>
					</c:forEach>
				</c:if>
			</c:forEach>
    		</tbody>
   	</table>
</c:if>

<c:if test="${taskType eq 'edit'}">
	<div class="btn-group">
		<a href="${pageContext.request.contextPath}/reports/templates/${report.key}/delete" class="btn btn-sm btn-danger">
			<spring:message code="action.delete"/>
		</a>
	</div>
</c:if>

${portal.toolkit()}