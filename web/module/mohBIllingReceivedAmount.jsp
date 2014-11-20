<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>
<openmrs:require privilege="Manage Billing Reports" otherwise="/login.htm" redirect="/mohbilling/cohort.form" />
<openmrs:htmlInclude file="/moduleResources/@MODULE_ID@/scripts/jquery-1.3.2.js" />
<openmrs:htmlInclude file="/moduleResources/@MODULE_ID@/scripts/jquery.PrintArea.js" />	
<openmrs:htmlInclude file="/scripts/calendar/calendar.js" />
<%@ taglib prefix="billingtag" uri="/WEB-INF/view/module/@MODULE_ID@/taglibs/billingtag.tld" %>

<%@ include file="templates/mohBillingLocalHeader.jsp"%>
<script type="text/javascript" language="JavaScript">
	var $bill = jQuery.noConflict();

	$bill(document).ready(function() {
		$bill('.meta').hide();
		
		$bill("input#print_button").click(function() {
			$bill('.meta').show();
			$bill("div.printarea").printArea();
			$bill('.meta').hide();
		});
	});
	
</script>

<h2><spring:message code="@MODULE_ID@.billing.report"/></h2>

<ul id="menu">
		<li class="<c:if test='<%= request.getRequestURI().contains("Cohort")%>'> active</c:if>">
			<a href="cohort.form"><spring:message code="@MODULE_ID@.billing.cohort"/></a>
		</li>
		<openmrs:hasPrivilege privilege="Manage Billing Reports">
			<li>
				<a href="hmisReport.form">HMIS Reports</a>
			</li>
		</openmrs:hasPrivilege>
		      <li class="<c:if test='<%= request.getRequestURI().contains("received")%>'> active</c:if>">
				<a href="received.form"><spring:message code="@MODULE_ID@.billing.Received"/></a>
			</li>
</ul>

<b class="boxHeader">Search Form(Advanced)</b>
<div class="box">


<form action="received.form" method="post" name="">
<input type="hidden" name="patientIdnew" value="${patientId}"/>	
<table>
	<tr>
		<td width="10%"><b>When?</b></td>
		<td>
		<table>
			<tr>
				<td>On Or After : <input type="text" size="11" value="${startDate}"
					name="startDate" onclick="showCalendar(this)" /></td>
				 <td>On Or Before<input type="text" size="11" value="${endDate}"
					name="endDate" onclick="showCalendar(this)" /></td>
			</tr>
			
		</table>
		</td>
		<td>Collector :</td>
		<td><openmrs_tag:userField formFieldName="billCollector" initialValue="${billCollector}"/></td>
	</tr>


</table>
<input type="submit" value="Search" />
</form>

</div>
<br/>



<br/>
<c:if test="${fn:length(billPaymentsByDateAndCollector)!=0}">
<b class="boxHeader"> RECEIVED AMOUNT REPORT</b>
<div class="box">
<table width="40%">

	<tr>
			<th class="columnHeader"></th>
			<th class="columnHeader">No</td>
			<th class="columnHeader">Date</td>
			<th class="columnHeader">Collector</td>
			<th class="columnHeader">Received Amount</td>
	</tr>

   <c:forEach items="${billPaymentsByDateAndCollector}" var="payment" varStatus="status">
   <tr>
			<td class="rowValue ${(status.count%2!=0)?'even':''}">${status.count}. bla</td>
			<td class="rowValue ${(status.count%2!=0)?'even':''}">${payment.dateReceived}</td>
			<td class="rowValue ${(status.count%2!=0)?'even':''}">${payment.collector}</td>
			<td class="rowValue ${(status.count%2!=0)?'even':''}">${payment.amountPaid}</td>

	</tr>
</c:forEach>
<tr>
		<td></td>
		<td></td>
		<td></h2></td>
		<td><b><h3>${TotalReceivedAmount}</h3></b></td>
	</tr>
</table>
</div>
</c:if>



<%@ include file="/WEB-INF/template/footer.jsp"%>