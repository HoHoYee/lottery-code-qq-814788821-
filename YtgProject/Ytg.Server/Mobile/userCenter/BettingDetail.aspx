﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BettingDetail.aspx.cs" Inherits="Ytg.ServerWeb.Mobile.userCenter.BettingDetail" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=Ytg.ServerWeb.BootStrapper.SiteHelper.GetSiteName() %></title>
   <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <meta name="format-detection" content="email=no">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link href="/Content/Css/feile/comn.css" rel="stylesheet" />
    <link href="/Content/Css/feile/keyframes.css" rel="stylesheet" />
    <link href="/Content/Css/feile/main.css" rel="stylesheet" />
    <link href="/Content/Css/feile/homepg.css" rel="stylesheet" />
    <link href="/Content/Css/base.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/Content/Css/layout.css" rel="stylesheet" type="text/css" media="all" />
    <link href="/Content/Css/home.css" rel="stylesheet" type="text/css" media="all" />
    <script src="/Content/Scripts/jquery-1.7.min.js" type="text/javascript"></script>
    <!--[if lte IE 6]><script src="/Content/Scripts/json2.js"></script><![endif]-->
    <!--[if lte IE 7]><script src="/Content/Scripts/json2.js"></script><![endif]-->
    <!--[if IE 8]><script src="/Content/Scripts/json2.js"></script><![endif]-->
    <script src="/Content/Scripts/jquery.sortable.js"></script>
    <script src="/Content/Scripts/config.js" type="text/javascript"></script>
    <script src="/Content/Scripts/basic.js" type="text/javascript"></script>
    <script src="/Content/Scripts/common.js" type="text/javascript"></script>
    <script src="/Content/Scripts/comm.js" type="text/javascript"></script>
    <!--消息框代码开始-->
    <script src="/Content/Scripts/dialog-min.js" type="text/javascript"></script>
    <link href="/Content/Css/ui-dialog.css" rel="stylesheet" />
    <script src="/Content/Scripts/dialog-plus-min.js" type="text/javascript"></script>
    <!--头部结束-->
    <link href="/Content/Scripts/Dialog/dialogUI.css" rel="stylesheet" type="text/css" />
    <script src="/Content/Scripts/Dialog/jquery.dialogUI.js" type="text/javascript"></script>
    <script src="/Content/Scripts/Dialog/jquery.dragdrop.js" type="text/javascript"></script>
    <link href="/Mobile/css/subpage1.css" rel="stylesheet" />
     <script src="/Content/Scripts/layout.js" type="text/javascript"></script>
    <link href="/Mobile/css/style1.css" rel="stylesheet" />
      <link href="/Mobile/css/bootstrap1.css" rel="stylesheet" />
    <link href="/Mobile/css/list.css" rel="stylesheet" />
    <link href="/Content/Scripts/Pager/kkpager_orange.css" rel="stylesheet" />
    <script src="/Content/Scripts/Pager/kkpager.min.js"></script>
     <script src="/Content/Scripts/datepicker/WdatePicker.js"></script>
     <script src="/Content/Scripts/playname.js"></script>
        <style type="text/css">
            body {
            background:#fff;}
        .ltable1{ width:100%; border:1px solid #e1e1e1; font-family:"Microsoft YaHei"; font-size:12px; }
        .ltable1 th{ padding:3px 0;  font-size:12px; font-weight:500; background:#fff; border-bottom:0px solid #E1E1E1; line-height:1.5em;padding-left:1px;padding-right:1px;}
        .ltable1 td{ padding:3px 0; border:1px solid #fff; line-height:1.5em; padding-left:1px;padding-right:1px; color:#000;font-weight:bold; padding-left:0px;padding-right:0px;}
        .ltable1 tr:hover{ background:#fff; }
        .ltable1 .odd_bg{ background:#fff; }
        .ltable1 td span {font-weight:normal;color:#0066c8;}

        .ltable td {text-align:center;}
    </style>
     <script type="text/javascript">
        $(function () {
            $("#lbMonerty").html(decimalCt(Ytg.tools.moneyFormat($("#lbMonerty").html())));
            $("#lbSumMonery").html(decimalCt(Ytg.tools.moneyFormat($("#lbSumMonery").html())));
            $("#lbBackNum").html(decimalCt(Ytg.tools.moneyFormat($("#lbBackNum").html())));
            var dwdname = $("#lbPlayType").html();
            $("#lbPlayType").html($("#hidPostionName").val()+changePalyName($("#lbPlayType").html(), ''));
            $("#txtContent").val(Ytg.common.LottTool.ShowBetContent($("#txtContent").val(), 1));
            //当为定位胆时候
            //if (dwdname == '定位胆定位胆') {
            //    $("#txtContent").val(parseDingWeiDanShow($("#txtContent").val()));
            //}
           

            $("#cannel").click(function () {
                var catchCode="<%=Request.QueryString["catchCode"]%>";
                var issCode="<%=Request.QueryString["issueCode"]%>";
                var url = "action=cannelbethnum&bettCode=<%=Request.Params["betcode"]%>&lotteryid=<%=LotteryCode%>";
                if (catchCode != "") {
                    url = "action=cannelcatchNum&catchCode=" + catchCode + "&lotteryid=<%=LotteryCode%>&data=" + issCode;
                }
                if (confirm("确定要撤单吗？")) {
                    Ytg.common.loading();
                    $.ajax({
                        url: "/Page/Lott/LotteryBetDetail.aspx",
                        type: 'post',
                        data: url,
                        success: function (data) {
                            Ytg.common.cloading();
                            var jsonData = JSON.parse(data);
                            //清除
                            if (jsonData.Code == 0) {
                                alert("撤单成功！");
                                $("#exitTd").remove();
                                $("#lbState").html("已撤单");
                            } else if (jsonData.Code == 1002) {
                                alert("对不起，当期投注时间已截止，撤单失败！");
                            } else if (jsonData.Code == 1009) {
                                alert("由于您长时间未操作,为确保安全,请重新登录！");
                                parent.window.location = "/login.html";
                            }
                            else {
                                alert("撤单失败，请刷新后重试！");
                            }
                        }
                    });
                }
            });
        });
        
    </script>
</head>
<body>
     <nav class="col-xs-12 title" style="position:fixed;z-index:999;left:0px;top:0px;">
         <a id="J-goback" href="javascript:window.history.go(-1)" class="go-back">返回</a>注单详情</nav>
        <div  class="ctParent">
    <form id="form1" runat="server">
        <asp:HiddenField  ID="hidPostionName" runat="server"/>
        <div style="padding:5px;padding-bottom:10px;">
        <table class="ltable1" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td style="width:22%">游戏用户：<asp:Label ID="lbCode" runat="server" Text=""></asp:Label></td>
                <td style="width:22%">游戏：<asp:Label ID="lbGame" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr>
                <td>注单编号：<asp:Label ID="lbbettCode" runat="server" Text=""></asp:Label></td>
                <td colspan="2" style="width:46%">总金额：<asp:Label ID="lbSumMonery" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr>
                <td>玩法：<asp:Label ID="lbPlayType" runat="server" Text=""></asp:Label>
                   <a  style="color:red;font-weight:normal;text-decoration:underline;color:#f74848;margin-left:10px" runat="server" id="palCatch" >追号详情</a>
                </td>
                <td>注单状态：<asp:Label ID="lbState" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr><td>倍数模式：<asp:Label ID="lbModel" runat="server" Text=""></asp:Label></td>
                <td>奖期：<asp:Label ID="lbIssue" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr>
                <td>注单奖金：<asp:Label ID="lbMonerty" runat="server" Text=""></asp:Label></td>
                <td id="dongtaiMonery" runat="server">动态奖金返点：<asp:Label ID="lbBackNum" runat="server" Text=""></asp:Label><asp:Label ID="lbBackNumlst" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>投注时间：<asp:Label ID="lbbetTime" runat="server" Text=""></asp:Label></td>
                <td colspan="4">开奖号码：<asp:Label ID="lbOpenTime" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr>
                <td colspan="4">投注内容：</td>
            </tr>
            <tr>
                <td colspan="4">
                    <asp:TextBox ID="txtContent" runat="server" TextMode="MultiLine" Height="80" style="width:100%;" ReadOnly="true" CssClass="input"></asp:TextBox>
                </td>
            </tr>
            <tr id="exitTd" runat="server" visible="false">
                <td colspan="4"><input type="button" value="撤单" id="cannel"/></td>
            </tr>
            <tr>
                <td colspan="4">
                    可能中奖情况：
                </td>
            </tr>
        </table>
        <table class="ltable" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <th>奖级名称</th>
                            <th>号码</th>
                            <th>倍数</th>
                            <th>奖金</th>
                        </tr>
            <asp:Repeater ID="rptWins" runat="server">
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("PlayTypeRadioName") %></td>
                        <td><script type="text/javascript">
                                document.write(Ytg.common.LottTool.ShowBetContent('<%# Eval("itemContent") %>'))
                            </script> </td>
                        <td><%# Eval("Multiple") %></td>
                        <td><%# String.Format("{0:N4}",Convert.ToDecimal(Eval("meWinMoney")))  %></td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
                    </table>
            </div>
    </form>
</body>
</html>
