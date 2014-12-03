<%-- 
    Document   : dashboard_sales
    Created on : Nov 23, 2014, 2:41:13 PM
    Author     : Jessica
--%>

<%@page import="DBWorks.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" href="../../favicon.ico">

        <title>ParaLove</title>

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        
        <!-- Custom styles for this template -->
        <link href="css/dashboard.css" rel="stylesheet">
    
        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container-fluid">
                <div class="navbar-header">
                  <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                  </button>
                  <a class="navbar-brand" href="ManagerInformation.jsp">ParaLove</a>
                </div>
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><%out.print(session.getAttribute("login")); %> <span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="helpmenu.jsp">Help</a></li>
                            <li class="divider"></li>
                            <li><a href="logout.jsp">Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </nav>

      <div class="container-fluid">
        <div class="row">
          <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar">
                <li><a href="ManagerInformation.jsp">Dashboard</a></li>
                <li class="active"><a href="dashboard_sales.jsp">Sales Analytics <span class="sr-only">(current)</span></a></li>
                <li><a href="dashboard_customerinfo.jsp">Customer Information</a></li>
            </ul>
          </div>
          <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h1>Sales Analytics</h1><br><br>

            <div>
                <div>
                    <h2 class="page-header">Sales Report for a Particular Month</h2>
                    <div class="form-holder">
                        <form class="form-inline" method="post" action="monthly_sales.jsp">
                            <div class="form-group">
                                <label for="ssn">Enter Month:</label>
                                <input type="text" class="form-control" name="month" placeholder="e.g. 10 for October">
                            </div>
                            <button type="submit" class="btn btn-default">Search</button>
                        </form>
                    </div>
                </div><br/><br/>
                <div>
                    <h2 class="page-header">Revenue</h2>
                    <div>
                        <h3>Revenue Generated by Dates Involving a Particular Customer </h3>
                        <div class="form-holder">
                            <form class="form-inline" method="post" action="customer_revenue.jsp">
                                <div class="form-group">
                                    <label for="snn">Enter Customer SSN:</label>
                                    <input type="text" class="form-control" name="ssn" placeholder="xxx-xx-xxxx">
                                </div>
                                <button type="submit" class="btn btn-default">Search</button>
                            </form>
                        </div>
                    </div>
                    <div>
                        <h3>Revenue Generated by Dates on a Particular Calendar Date</h3>
                        <div class="form-holder">
                            <form class="form-inline" method="post" action="date_revenue.jsp">
                                <div class="form-group">
                                    <label for="date">Enter Date:</label>
                                    <input type="date" class="form-control" name="date">
                                </div>
                                <button type="submit" class="btn btn-default">Search</button>
                            </form>
                        </div>
                    </div>
                </div><br/><br/>
                <div>
                    <h2 class="page-header">Customer Representative Who Generated Most Revenue</h2>
                    <div class="form-holder">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>Customer Representative SSN</th>
                                        <th>Revenue</th>
                                     </tr>
                                </thead>
                                <tbody>
                                <%
                                    java.sql.Connection conn = null;
                                    String Query = "SELECT * FROM RepRevenue R WHERE R.Revenue >= (SELECT MAX(R1.Revenue) FROM RepRevenue R1);";
                                    java.sql.ResultSet rs =DBConnection.ExecQuery(Query);
                                    while(rs.next())
                                    {
                                    %>
                                    <tr>
                                        <td > <% out.print(rs.getString(1)); %> </td>
                                        <td > <% out.print("$" + rs.getString(2)); %> </td>
                                    </tr>
                                    <%      		
                                    }
                                %>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div><br/><br/>
                <div>
                    <h2 class="page-header">Customer Who Generated Most Revenue</h2>
                    <div class="form-holder">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>Customer SSN</th>
                                        <th>Revenue</th>
                                     </tr>
                                </thead>
                                <tbody>
                                <%
                                    conn = null;
                                    Query = "SELECT * FROM CusRevenue C WHERE C.Revenue >= (SELECT MAX(C1.Revenue) FROM CusRevenue C1);";
                                    rs =DBConnection.ExecQuery(Query);
                                    while(rs.next())
                                    {
                                    %>
                                    <tr>
                                        <td > <% out.print(rs.getString(1)); %> </td>
                                        <td > <% out.print("$" + rs.getString(2)); %> </td>
                                    </tr>
                                    <%      		
                                    }
                                %>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Bootstrap core JavaScript
      ================================================== -->
      <!-- Placed at the end of the document so the pages load faster -->
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
      <script src="js/bootstrap.min.js"></script>
    </body>
</html>
