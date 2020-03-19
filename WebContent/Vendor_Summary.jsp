<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.Timestamp"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Summary</title>

<!-- <link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script> -->

<link href="js/datepicker/bootstrap-combined.min.css" rel="stylesheet"/> 
	<script type="text/javascript" src="js/datepicker/jquery.min.js"> </script>
	<script type="text/javascript" src="js/datepicker/bootstrap.min.js"> </script>
	<script type="text/javascript" src="js/datepicker/datepicker.js"> </script>
	<link rel="stylesheet" type="text/css" media="screen" href="js/datepicker/bootstrap-datetimepicker.min.css"/> 
	<script type="text/javascript" src="js/datepicker/bootstrap-datetimepicker.pt-BR.js"> </script>

<script type="text/javascript">
	/* $(document).ready(function() {
		$("#fromDate").datepicker({
			changeMonth : true,
			changeYear : true
		});
		$("#toDate").datepicker({
			changeMonth : true,
			changeYear : true
		});
	}); */
	function GetFilterResults() { 
		var fromDate = document.getElementById("fromDate").value; 
		var toDate = document.getElementById("toDate").value; 
		var datafor = document.getElementById("datafor").value; 
		
		var xmlhttp;
			if (window.XMLHttpRequest) {
				// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {
				// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); 
			}
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					document.getElementById("ajaxData").innerHTML = xmlhttp.responseText; 
				}
			};
			xmlhttp.open("POST", "Get_VendorDataAJAX.jsp?fromDate=" + fromDate +"&toDate=" + toDate +"&datafor=" + datafor, true);
			xmlhttp.send();
	};
</script>
<link rel="stylesheet" type="text/css" href="css/style1.css" />
<link rel="stylesheet" type="text/css" href="css/style2.css" />
<style>
.button {
	background-color: #f48342;
	border: none;
	color: white;
	padding: 13px 28px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 15px;
	font-weight: bold;
	margin: 3px 1px;
	cursor: pointer;
	margin: 3px 1px;
}

.dropbtn {
	background-color: black;
	color: white;
	padding: 16px;
	font-size: 16px;
	border: none;
	cursor: pointer;
	font-family: Arial;
}

.dropdown {
	position: relative;
	display: inline-block;
}

.dropdown-content {
	display: none;
	font-family: Arial;
	position: absolute;
	background-color: #3b7687;
	min-width: 160px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
}

.dropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.dropdown-content a:hover {
	background-color: black;
}

.dropdown:hover .dropdown-content {
	display: block;
}

.dropdown:hover .dropbtn {
	background-color: black;
}

.tftable {
	font-size: 12px;
	color: #333333;
	width: 100%;
	border-width: 1px;
	border-color: #729ea5;
	border-collapse: collapse;
}

.tftable tr {
	background-color: white;
}

.tftable td {
	font-size: 12px;
	border-width: 1px;
	padding: 3px;
	border-style: solid;
	border-color: #729ea5;
}
</style>
<script type="text/javascript">
function ChangeColor(tableRow, highLight) {
	if (highLight) {
		tableRow.style.backgroundColor = '#CFCFCF';
	} else {
		tableRow.style.backgroundColor = '#FFFFFF';
	}
} 
function validatenumerics(key) {
	//getting key code of pressed key
	var keycode = (key.which) ? key.which : key.keyCode;
	//comparing pressed keycodes	 
	if (keycode > 31 && (keycode < 48 || keycode > 57) && keycode != 46 && keycode != 37 && keycode != 38 && keycode != 39 && keycode != 40) {
	    alert("Only allow numeric Data entry");
	    return false;
	}else 
	{
		return true;
	};
	}	
$(function() {
    $( "#revision_date").datepicker({
      changeMonth: true,
      changeYear: true
    });
    $( "#vat_tindate").datepicker({
	      changeMonth: true,
	      changeYear: true
	    });
    $( "#ssi_date").datepicker({
	      changeMonth: true,
	      changeYear: true
	    }); 
  }); 
</script>
<script language="javascript"> 
	function ValidationEvent() {				
	 	/* var fileType = document.getElementById("fileType");		 */        
	 	var masterFile = document.getElementById("masterFile");		 
		if (masterFile.value == "") {
			alert("Please Provide Import Master File !!!");
			document.getElementById("importData").disabled = false; 
			return false;
		}
		document.getElementById("Submit").disabled = true; 
	}
</script>
<style type="text/css">
.tftable {
	font-family: Arial;
	font-size: 12px;
	color: #333333;
}

.tftable tr {
	background-color: white;
	font-size: 13px;
}

.tftable td {
	font-size: 12px;
	font-family: Arial;
	padding: 3px;
}

.style1 {
	font-size: 12px;
	font-weight: bold;
}

.style1 {
	font-size: 12px;
	font-weight: bold;
}

.style1 {
	font-size: 12px;
	font-weight: bold;
}

.style1 {
	font-size: 12px;
	font-weight: bold;
}

.style4 {
	font-size: 12px
}

.style5 {
	font-weight: bold;
	font-size: 12px;
}

.style6 {
	color: #FF0000
}
</style>
</head>
<body>
	<%
		try {
			Connection conMaster = Connection_Utility.getConnectionMaster();
			Date date = new Date();
			String toDate = new SimpleDateFormat("dd/MM/yyyy").format(date);

			Calendar c = Calendar.getInstance();
			c.set(Calendar.DAY_OF_MONTH, 1);
			String fromDate = new SimpleDateFormat("dd/MM/yyyy").format(c.getTime());

			// ------------------Next Date for sql between loop ---------------------------		    
			Calendar c1 = Calendar.getInstance();
			c1.setTime(date);
			c1.add(Calendar.DATE, 1);
			Date currentDatePlusOne = c1.getTime();
			String nextDate = new SimpleDateFormat("dd/MM/yyyy").format(currentDatePlusOne);

			Date datesql_from = new SimpleDateFormat("dd/MM/yyyy").parse(fromDate);
			Timestamp timeStampFromDate = new Timestamp(datesql_from.getTime());
			 
			Date datesql_to = new SimpleDateFormat("dd/MM/yyyy").parse(toDate);
			Timestamp timeStampToDate = new Timestamp(datesql_to.getTime());
			
			Date datesql_Nextto = new SimpleDateFormat("dd/MM/yyyy").parse(nextDate);
			Timestamp timeStampToNextDate = new Timestamp(datesql_Nextto.getTime());
			// ----------------------------------------------------------------------------
			// System.out.println("date from =  " + datesql_from + "to  = = " + datesql_to);
	%>
	<div id="container">
		<div id="content">
			<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
			<!---------------------------------------------------------------  Include Header ---------------------------------------------------------------------------------------->
			<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
			<%@include file="Header.jsp"%>
			<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
			<div style="text-align: center;">
				<%
					if (request.getParameter("success") != null) {
				%>
				<script type="text/javascript">alert("<%=request.getParameter("success")%>"); </script>
				<%
					}
				%>

				<table class="tftable" style="width: 60%;">
					<tr
						style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
						<td>Date From</td>
						<td>Date To</td>
						<td>Vendor</td>
						<td>Submit</td>
					</tr>
					<tr>
						<td>
 <div id="datetimepickerfrom" class="input-append date">
 <input name="fromDate" id="fromDate" readonly="readonly" value="<%=timeStampFromDate%>" style="height: 25px;"/>
 <span class="add-on"> 
 <img alt="js/datepicker/iconDate.png" src="js/datepicker/iconDate.png"/> 
 </span>
 </div> 
 						</td>
						
						<td>
						
<div id="datetimepickerto" class="input-append date">
 <input name="toDate" id="toDate" readonly="readonly" value="<%=timeStampToDate%>" style="height: 25px;"/>
 <span class="add-on"> 
 <img alt="js/datepicker/iconDate.png" src="js/datepicker/iconDate.png"/> 
 </span>
 </div>					 
						
						</td>
						
						<td>
						<select id="datafor" name="datafor" style="font-weight: bold;">
								<%
									if (access.equalsIgnoreCase("FULL")) {
								%>
								<option value="all">- - - - - ALL Vendors - - - - -</option>
								<%
									String query = "SELECT  distinct site_name,sapcode  FROM Baker_site where enable=1";
											PreparedStatement ps_vendor = conMaster.prepareStatement(query);
											ResultSet rs_vendor = ps_vendor.executeQuery();
											while (rs_vendor.next()) {
								%>
								<option value="<%=rs_vendor.getInt("sapcode")%>"><%=rs_vendor.getString("site_name")%></option>
								<%
									}
										} else {
											String query = "SELECT  *  FROM Baker_site where enable=1  and sapcode= '" + vendor_Code + "'";
											PreparedStatement ps_vendor = conMaster.prepareStatement(query);
											ResultSet rs_vendor = ps_vendor.executeQuery();
											while (rs_vendor.next()) {
								%>
								<option value="<%=rs_vendor.getInt("sapcode")%>"><%=rs_vendor.getString("site_name")%></option>
								<%
									}
										}
								%>
						</select></td>
						<td><button onclick="GetFilterResults()">
								<strong>GO</strong>
							</button></td>
					</tr>
				</table> 
			</div>
			<div id="main" style="height: 500px;">
				<div style="width: 100%; float: left; height: 500px;">
					<form action="Import_MasterDataControl" method="post" enctype="multipart/form-data" onsubmit="return ValidationEvent()">
					<span id="ajaxData">
					<%
					String disp_query = "";
					if (access.equalsIgnoreCase("FULL")) {
						disp_query = "SELECT * FROM baker_summary where datetime_sheet between '"
								+ timeStampFromDate
								+ "' and '"
								+ timeStampToNextDate
								+ "' and enable=1";
					} else {
						disp_query = "SELECT * FROM baker_summary where datetime_sheet between '"
								+ timeStampFromDate
								+ "' and '"
								+ timeStampToNextDate
								+ "' and enable=1 and vendor_code= '"
								+ vendor_Code
								+ "'";
					}
					%>
					<table class="tftable" style="width: 100%;">
							<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold; text-align: center;">
								<%
								PreparedStatement ps_head = conMaster.prepareStatement("SELECT * FROM Baker_HeaderData where enable=1");
								ResultSet rs_head = ps_head.executeQuery();
								while(rs_head.next()){
								%>
								<td><%=rs_head.getString("parameter") %> 
								<%if(!rs_head.getString("range_from").equalsIgnoreCase("")){ %><br/>
								[<%=rs_head.getString("range_from") %>/<%=rs_head.getString("range_to") %>]  <%} %></td> 
								<% 
								}
								%> 
								<td>vendor_name</td> 
								<td>userName</td>
							</tr>
							<% 
									PreparedStatement ps_summary = conMaster.prepareStatement(disp_query);
									ResultSet rs_summary = ps_summary.executeQuery();
									while (rs_summary.next()) {
							%>
							<tr>
								<%-- <td><%=rs_summary.getString("sr1")%></td> --%>
								<td><%=rs_summary.getString("serial_no")%></td>
								<td><%=rs_summary.getString("datetime_sheet")%></td>
								<td><%=rs_summary.getString("batch")%></td>
								<td><%=rs_summary.getString("machine")%></td>
								<td><%=rs_summary.getString("operator")%></td>
								<td><%=rs_summary.getString("top_id")%></td>
								<td><%=rs_summary.getString("bot_id")%></td>
								<td><%=rs_summary.getString("top_oval")%></td>
								<td><%=rs_summary.getString("bot_oval")%></td>
								<td><%=rs_summary.getString("taper")%></td>
								<td><%=rs_summary.getString("od")%></td>
								<td><%=rs_summary.getString("mh_ht")%></td>
								<td><%=rs_summary.getString("parality")%></td>
								<td><%=rs_summary.getString("th_ht")%></td>
								<td>
								<%
								if(rs_summary.getString("result").equalsIgnoreCase("ACCEPT")){
								%>
								<strong style="background-color: green;color: white;"><%=rs_summary.getString("result")%></strong>   
								<%
								}else{
								%>
								<strong style="background-color: red;color: white;"><%=rs_summary.getString("result")%></strong>   
								<%	
								}
								%>
								</td>  
								<td><%=rs_summary.getString("vendor_name")%></td> 
								<td><%=rs_summary.getString("userName")%></td> 
							</tr>
							<%
								}
							%>
					</table>
					</span>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
	<script type="text/javascript">
		$('#datetimepickerfrom').datetimepicker({
			format : 'yyyy-MM-dd hh:mm:ss',
			language : 'EN'
		});
		$('#datetimepickerto').datetimepicker({
			format : 'yyyy-MM-dd hh:mm:ss',
			language : 'EN'
		});
	</script>
</body>
</html>