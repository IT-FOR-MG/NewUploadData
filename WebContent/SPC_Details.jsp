<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Collections"%>
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
<html>
<head>
<title>SPC Summary</title>
<link href="js/datepicker/bootstrap-combined.min.css" rel="stylesheet"/> 
	<script type="text/javascript" src="js/datepicker/jquery.min.js"> </script>
	<script type="text/javascript" src="js/datepicker/bootstrap.min.js"> </script>
	<script type="text/javascript" src="js/datepicker/datepicker.js"> </script>
	<link rel="stylesheet" type="text/css" media="screen" href="js/datepicker/bootstrap-datetimepicker.min.css"/> 
	<script type="text/javascript" src="js/datepicker/bootstrap-datetimepicker.pt-BR.js"> </script>
 <link href='dist/rome.css' rel='stylesheet' type='text/css' />
<link href='example/example.css' rel='stylesheet' type='text/css' />
  
<!--  Graph  -->
<script type="text/javascript" src="js/loader.js"></script>

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
			DecimalFormat df = new DecimalFormat("00.000");
			
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
			
			
			ArrayList xLarge = new ArrayList();
			ArrayList xSmall = new ArrayList();
			ArrayList xAvg = new ArrayList();
			ArrayList xRange = new ArrayList();
			ArrayList parameter = new ArrayList(); 
			
			ArrayList row1 = new ArrayList(); 
			ArrayList row2 = new ArrayList(); 
			ArrayList row3 = new ArrayList(); 
			ArrayList row4 = new ArrayList(); 
			ArrayList row5 = new ArrayList(); 
			
			boolean flagView=false;
			
			if (request.getAttribute("xLarge") != null  && request.getAttribute("xSmall") != null && 
					request.getAttribute("xAvg") != null && request.getAttribute("xRange") != null) {
				xLarge = (ArrayList) request.getAttribute("xLarge");
				xSmall = (ArrayList) request.getAttribute("xSmall");
				xAvg = (ArrayList) request.getAttribute("xAvg");
				xRange = (ArrayList) request.getAttribute("xRange");
				parameter = (ArrayList) request.getAttribute("parameter");
				row1 = (ArrayList) request.getAttribute("row1");
				row2 = (ArrayList) request.getAttribute("row2");
				row3 = (ArrayList) request.getAttribute("row3");
				row4 = (ArrayList) request.getAttribute("row4");
				row5 = (ArrayList) request.getAttribute("row5");
				
				
				flagView=true;
				//System.out.println("There are values in the arraylist" + xLarge + " = " + xSmall + " =" + xAvg + " = " + xRange + " = " + parameter);
			} else {
				//System.out.println("There are no values in the arraylist");
			}
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
<form action="SPC_DataControl" method="post" id="SPC_DataControl">
				<table class="tftable" style="width: 60%;">
					<tr
						style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
						<td>Date From</td>
						<td>Date To</td>
						<td>Vendor</td>
						<td>Parameter</td>
						<td>Submit</td>
					</tr>
					<tr>
					<td>
 	<input id='dt' class='input' name="fromDate" id="fromDate" value="<%=timeStampFromDate%>"/>
 					</td>
					<td>
	<input id='dt1' class='input' name="toDate" id="toDate" value="<%=timeStampToDate%>"/>  
					</td>					
					<td>
					<select  class='input' id="datafor" name="datafor" style="font-weight: bold;">
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




<td>
					<select  class='input' id="parameter" name="parameter" style="font-weight: bold;">
								<%
									String query = "SELECT *  FROM Baker_HeaderData where range_from!='' and range_to!=''";
											PreparedStatement ps_header = conMaster.prepareStatement(query);
											ResultSet rs_header = ps_header.executeQuery();
											while (rs_header.next()) {
								%>
								<option value="<%=rs_header.getInt("id")%>"><%=rs_header.getString("parameter")%> <%=rs_header.getString("range_from")%> - <%=rs_header.getString("range_to")%></option>
								<%
									}
								%>
						</select></td>





						<td>
						<input type="submit" value="GO" style="font-weight: bold;"/>
						<!-- <button onclick="GetAllFilterResults()">
								<strong>GO</strong>
							</button> --> 
						</td>
					</tr>
				</table> 
</form>
 
<%
if(flagView==true){
	int snNo=1;
%>
<div style="width: 70.9%;float: left;font-size: 12px;">
<table class="tftable" style="width: 60%;margin-left: 5px;">
<tr style="background-color: green;color:white; font-weight: bold;">
						<td colspan="7"><strong style="font-size: 20px;"><%=parameter.get(0).toString() %></strong> <strong style="font-size: 20px;">[ <%=parameter.get(1).toString() %> - <%=parameter.get(2).toString() %> ]</strong></td>
						<td colspan="4" align="left"></td> 
					</tr>
					<tr style="font-size: 12px; background-color: #acc8cc; font-weight: bold;">
						<td>S.No</td>
						<td>1</td>
						<td>2</td>
						<td>3</td>
						<td>4</td>
						<td>5</td>
						<td>6</td>
						<td>7</td>
						<td>8</td>
						<td>9</td>
						<td>10</td>
					</tr>
					<tr>
					<td><b><%=snNo %></b></td>
					<%
					for(int i=0;i<row1.size();i++){
					%>					
					<td><%=row1.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr> 
					<tr>
					<td><b><%=snNo %></b></td>
					<%
					for(int i=0;i<row2.size();i++){
					%>					
					<td><%=row2.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr>
					<tr>
					<td><b><%=snNo %></b></td>
					<%
					for(int i=0;i<row3.size();i++){
					%>					
					<td><%=row3.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr>
					<tr>
					<td><b><%=snNo %></b></td>
					<%
					for(int i=0;i<row4.size();i++){
					%>					
					<td><%=row4.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr>
					<tr>
					<td><b><%=snNo %></b></td>
					<%
					for(int i=0;i<row5.size();i++){
					%>					
					<td><%=row5.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr>
					
					<tr>
					<td align="left">X Large</td>
					<%
					for(int i=0;i<xLarge.size();i++){
					%>					
					<td><%=xLarge.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr>
					
					<tr>
					<td align="left">X Small</td>
					<%
					for(int i=0;i<xSmall.size();i++){
					%>					
					<td><%=xSmall.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr>
					
					<tr>
					<td align="left">Range</td>
					<%
					for(int i=0;i<xRange.size();i++){
					%>					
					<td><%=xRange.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr>
					
					<tr>
					<td align="left">AVG</td>
					<%
					for(int i=0;i<xAvg.size();i++){
					%>					
					<td><%=xAvg.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr> 		
</table>					
</div>
<div style="width: 29%;float: left;font-size: 12px;">
<%
ArrayList xMax = new ArrayList();
ArrayList xMmin = new ArrayList();
ArrayList xBar = new ArrayList(); 
ArrayList rBar = new ArrayList(); 
Double utl_xBar=0.0;

xMax.add(Collections.max(xLarge));
xMmin.add(Collections.max(xSmall));

Double xbalValue = 0.0, rRangeval=0.0;

for(int i=0;i<10;i++){
	xbalValue = xbalValue + (Double.parseDouble(row1.get(i).toString()) + Double.parseDouble(row2.get(i).toString()) 
			+ Double.parseDouble(row3.get(i).toString()) + Double.parseDouble(row4.get(i).toString())
			+ Double.parseDouble(row5.get(i).toString()));
}
xBar.add(df.format(xbalValue/50));
for(int i=0;i<10;i++){
	rRangeval = rRangeval + Double.parseDouble(xRange.get(i).toString());
}
rBar.add(df.format(rRangeval/10));

%>
</div> 
<br /> 


<script type="text/javascript">
      google.charts.load('current', {'packages':['line']});
      google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
      var data = new google.visualization.DataTable();
      data.addColumn('number', 'X- CHART');
      data.addColumn('number', 'AVG.');
      data.addColumn('number', 'U.C.L.');
      data.addColumn('number', 'L.C.L.');
      data.addColumn('number', 'X-BAR');

      data.addRows([
        [1,  37.8, 80.8, 41.8, 41.8],
        [2,  30.9, 69.5, 32.4, 41.8],
        [3,  25.4,   57, 25.7, 41.8],
        [4,  11.7, 18.8, 10.5, 41.8],
        [5,  11.9, 17.6, 10.4, 41.8],
        [6,   8.8, 13.6,  7.7, 41.8],
        [7,   7.6, 12.3,  9.6, 41.8],
        [8,  12.3, 29.2, 10.6, 41.8],
        [9,  16.9, 42.9, 14.8, 41.8],
        [10, 12.8, 30.9, 11.6, 41.8]
      ]);

      var options = {
       /*  chart: {
          title: 'Box Office Earnings in First Two Weeks of Opening',
          subtitle: 'in millions of dollars (USD)'
        }, */
        width: 600,
        height: 300,
        axes: {
          x: {
            0: {side: 'top'}
          }
        }
      };

      var chart = new google.charts.Line(document.getElementById('line_top_x'));
      chart.draw(data, google.charts.Line.convertOptions(options));
    }
    
    
    
     
    google.charts.setOnLoadCallback(drawChart1);

  function drawChart1() {

    var data = new google.visualization.DataTable();
    data.addColumn('number', 'Day');
    data.addColumn('number', 'AVG.');
    data.addColumn('number', 'U.C.L.');
    data.addColumn('number', 'L.C.L.');
    data.addColumn('number', 'X-BAR');

    data.addRows([
                  [1,  37.8, 80.8, 41.8, 41.8],
                  [2,  30.9, 69.5, 32.4, 41.8],
                  [3,  25.4,   57, 25.7, 41.8],
                  [4,  11.7, 18.8, 10.5, 41.8],
                  [5,  11.9, 17.6, 10.4, 41.8],
                  [6,   8.8, 13.6,  7.7, 41.8],
                  [7,   7.6, 12.3,  9.6, 41.8],
                  [8,  12.3, 29.2, 10.6, 41.8],
                  [9,  16.9, 42.9, 14.8, 41.8],
                  [10, 12.8, 30.9, 11.6, 41.8]
    ]);

    var options = {
     /*  chart: {
        title: 'Box Office Earnings in First Two Weeks of Opening',
        subtitle: 'in millions of dollars (USD)'
      }, */
      width: 600,
      height: 300,
      axes: {
        x: {
          0: {side: 'top'}
        }
      }
    };

    var chart1 = new google.charts.Line(document.getElementById('line_top_R'));
    chart1.draw(data, google.charts.Line.convertOptions(options));
  }
  </script>
  <div id="line_top_x" style="width: 48%;float: left;font-size: 12px;margin-top: 10px;"></div>
  <div id="line_top_R" style="width: 48%;float: right;font-size: 12px;margin-top: 10px;"></div>
<%
}
%>

















			</div>
			
			 
			
			
			<!-- <div id="main" style="height: 500px;">
				<div style="width: 100%; float: left; height: 500px;">
					<span id="ajaxData">
					 
					</span>
				</div>
			</div> -->
		</div>
	</div>
	<%
		} catch (Exception e) {
			e.printStackTrace();
		}
	%> 
	<script src='dist/rome.js'></script>
<script src='example/example.js'></script>
</body>
</html>