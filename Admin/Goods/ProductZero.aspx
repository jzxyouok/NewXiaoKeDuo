<%@ Page Language="C#" MasterPageFile="~/Admin/AdminNew.Master" AutoEventWireup="true"
    CodeBehind="ProductZero.aspx.cs" Inherits="Hidistro.UI.Web.Admin.Goods.ProductZero" %>

<%@ Register TagPrefix="Hi" Namespace="Hidistro.UI.Common.Controls" Assembly="Hidistro.UI.Common.Controls" %>
<%@ Register TagPrefix="Hi" Namespace="Hidistro.UI.ControlPanel.Utility" Assembly="Hidistro.UI.ControlPanel.Utility" %>
<%@ Register TagPrefix="UI" Namespace="ASPNET.WebControls" Assembly="ASPNET.WebControls" %>
<%@ Register src="../Ascx/ucDateTimePicker.ascx" tagname="DateTimePicker" tagprefix="Hi" %>
<%@ Import Namespace="Hidistro.Core" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="producttag.helper.js"></script>
    <script src="../js/ZeroClipboard.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#dropBatchOperation").bind("change", function () { SelectOperation(''); });
        });

        function SelectOperation(obj) {
            var Operation = $("#dropBatchOperation").val();
            if (obj != "")
                Operation = obj;
            var productIds = GetProductId();
            if (productIds.length > 0) {

                switch (Operation) {
                    case "1":
                        formtype = "onsale";

                        $("#divOnSaleProduct").modal({ show: true });

                        break;
                    case "2":
                        formtype = "unsale";

                        $("#divUnSaleProduct").modal({ show: true });

                        break;
                    case "3":
                        formtype = "instock";
                        arrytext = null;
                        DialogShow("��Ʒ���", "productinstock", "divInStockProduct", "ctl00_contentHolder_btnInStock");
                        break;
                    case "5":
                        formtype = "setFreeShip";
                        arrytext = null;
                        $("#divSetFreeShip").modal({ show: true });
                        break;
                    case "6":
                        formtype = "cancelFreeShip";
                        arrytext = null;
                        DialogShow("ȡ������", "cancelFreeShip", "divCancelFreeShip", "ctl00_contentHolder_btnCancelFreeShip");
                        break;
                    case "4":
                    case "10":
                        $("#modaltitle").text("����������Ϣ");
                        $("#MyEidtBaseInfoIframe").attr("src", "EditBaseInfo.aspx?ProductIds=" + productIds);
                        $('#divEditBaseInfo').modal('toggle').children().css({
                            width: '820px',
                            height: '550px'
                        })
                        $("#divEditBaseInfo").modal({ show: true });
                        break;
                    case "11":
                        $("#modaltitle").text("������ʾ��������");
                        $("#MyEidtBaseInfoIframe").attr("src", "EditSaleCounts.aspx?ProductIds=" + productIds);
                        $('#divEditBaseInfo').modal('toggle').children().css({
                            width: '820px',
                            height: '550px'
                        })
                        $("#divEditBaseInfo").modal({ show: true });
                        break;
                    case "12":
                        $("#modaltitle").text("�������");
                        $("#MyEidtBaseInfoIframe").attr("src", "EditStocks.aspx?ProductIds=" + productIds);
                        $('#divEditBaseInfo').modal('toggle').children().css({
                            width: '820px',
                            height: '550px'
                        })
                        $("#divEditBaseInfo").modal({ show: true });
                        break;
                    case "13":
                        $("#modaltitle").text("������Ա���ۼ�");
                        $("#MyEidtBaseInfoIframe").attr("src", "EditMemberPrices.aspx?ProductIds=" + productIds);
                        $('#divEditBaseInfo').modal('toggle').children().css({
                            width: '820px',
                            height: '550px'
                        })

                        break;
                    case "15":
                        formtype = "tag";
                        setArryText('ctl00_contentHolder_txtProductTag', "");
                        DialogShow("������Ʒ��ǩ", "producttag", "divTagsProduct", "ctl00_contentHolder_btnUpdateProductTags");
                        break;
                    case "16":
                        formtype = "SetFreightTemplate";
                        $("#divSetFreightTemplate").modal({ show: true });

                        break;

                }
            }
            $("#dropBatchOperation").val("");
        }
        function winqrcode(url) {
            $("#imagecode").attr('src', "http://s.jiathis.com/qrcode.php?url=" + url);
            $('#divqrcode').modal('toggle').children().css({
                width: '300px',
                height: '300px'
            });
            $("#divqrcode").modal({ show: true });
        }
        function closeModal(obj) {
            $("#" + obj).modal('hide');
            location.reload();

        }
        function GetProductId() {
            var v_str = "";

            $("input[type='checkbox'][name='CheckBoxGroup']:checked").each(function (rowIndex, rowItem) {
                v_str += $(rowItem).attr("value") + ",";
            });

            if (v_str.length == 0) {
                HiTipsShow("��ѡ����Ʒ", "warning")
                return "";
            }
            return v_str.substring(0, v_str.length - 1);
        }

        function CollectionProduct(url) {
            DialogFrame("product/" + url, "�����Ʒ");
        }

        function validatorForm() {
            switch (formtype) {
                case "tag":
                    if ($("#ctl00_contentHolder_txtProductTag").val().replace(/\s/g, "") == "") {
                        alert("��ѡ����Ʒ��ǩ");
                        return false;
                    }
                    break;
                case "onsale":
                    setArryText('ctl00_contentHolder_hdPenetrationStatus', $("#ctl00_contentHolder_hdPenetrationStatus").val());
                    break;
                case "unsale":
                    setArryText('ctl00_contentHolder_hdPenetrationStatus', $("#ctl00_contentHolder_hdPenetrationStatus").val());
                    break;
                case "instock":
                case "setFreeShip":
                case "cancelFreeShip":
                    setArryText('ctl00_contentHolder_hdPenetrationStatus', $("#ctl00_contentHolder_hdPenetrationStatus").val());
                    break;
            };
            return true;
        }
        $(function () {
            $('.allselect').change(function () {
                if ($(this)[0].checked) {
                    $('.content-table input[type="checkbox"]').prop('checked', true);
                } else {
                    $('.content-table input[type="checkbox"]').prop('checked', false);
                }
            });
            var tableTitle = $('.title-table').offset().top - 58;
            $(window).scroll(function () {
                if ($('body').scrollTop() >= tableTitle) {
                    $('.title-table').css({
                        position: 'fixed',
                        top: '58px'
                    })
                } else {
                    $('.title-table').removeAttr('style');
                }
            });
            $('.content-table table tbody tr').each(function () {
                var id = $(this).eq(0).find(".fz").attr("id");
                var copy = new ZeroClipboard(document.getElementById(id), {
                    moviePath: "../js/ZeroClipboard.swf"
                });
                copy.on('complete', function (client, args) {
                    HiTipsShow("���Ƴɹ�����������Ϊ��" + args.text, 'success');
                });
            })
        })
        function resetform() {
            document.getElementById("aspnetForm").reset();
        }
        function copyurl(obj) {

            var copy = new ZeroClipboard(document.getElementById(obj), {
                moviePath: "../js/ZeroClipboard.swf"
            });
           
        }
        function StockZore() {
            var b = true;
            $('.content-table input:checked').each(function () {
                var num = $(this).parent().next().next().text();
                if ($.trim(num) == "" || parseInt(num) == 0) {
                    HiTipsShow("��ѡ����Ʒ�п��Ϊ0��Ϊ��,�����ϼܣ�", 'fail');
                    b = false;
                }
            })
            return b;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
        <div class="page-header">
            <h2>����������Ʒ</h2>
        </div>
        <div id="mytabl">
            <!-- Nav tabs -->
            <div class="table-page">
                <ul class="nav nav-tabs">
                    <li><a href="ProductOnSales.aspx">
                        <asp:Literal ID="LitOnSale" runat="server"></asp:Literal></a></li>
                    <li ><a href="ProductOnStock.aspx">
                        <asp:Literal ID="LitOnStock" runat="server"></asp:Literal></a></li>
                    <li class="active"><a href="#messages">
                        <asp:Literal ID="LitZero" runat="server"></asp:Literal></a></li>
                </ul>
                <div class="page-box">
                    <div class="page fr">
                        <div class="form-group">
                            <label for="exampleInputName2">ÿҳ��ʾ������</label>
                            <UI:PageSize runat="server" ID="hrefPageSize" />
                        </div>
                    </div>
                </div>
            </div>
            <!-- Tab panes -->
            <div class="tab-content">
                <div class="tab-pane active">

                    <div class="set-switch">
                        <div class="form-inline mb10">
                            <div class="form-group mr20">
                                <label for="sellshop1">��Ʒ���ƣ�</label>
                                <asp:TextBox ID="txtSearchText" runat="server" CssClass="form-control resetSize inputw150" placeholder="" />
                            </div>
                            <div class="form-group mr20">
                                <label for="sellshop2">��Ʒ���ࣺ</label>
                                <Hi:ProductCategoriesDropDownList ID="dropCategories" CssClass="form-control resetSize inputw100" runat="server" NullToDisplay="��ѡ����Ʒ����"
                                    Width="150" />
                            </div>
                            <div class="form-group">
                                <label for="sellshop3">Ʒ�ƣ�</label>
                                <Hi:BrandCategoriesDropDownList runat="server" ID="dropBrandList" CssClass="form-control resetSize inputw150" NullToDisplay="��ѡ��Ʒ��"
                                    Width="150" />
                            </div>
                        </div>
                        <div class="form-inline">
                            <div class="form-group mr20">
                                <label for="sellshop4">�̼ұ��룺</label>
                                <asp:TextBox ID="txtSKU" runat="server" CssClass="form-control resetSize inputw150" placeholder="" />
                            </div>
                            <div class="form-group mr20">
                                <label for="sellshop5">����ʱ�䣺</label>
                                  <Hi:DateTimePicker CalendarType="StartDate" ID="calendarStartDate" runat="server" CssClass="form-control resetSize inputw150" />
                            </div>
                            <div class="form-group">
                                <label for="sellshop6">&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                <Hi:DateTimePicker CalendarType="StartDate" ID="calendarEndDate" runat="server" CssClass="form-control resetSize inputw150" />
                            </div>
                        </div>
                        <div class="reset-search">
                            <a class="bl mb5" onclick="resetform();" style="cursor: pointer">�������</a>
                            <asp:Button ID="btnSearch" runat="server" Text="��ѯ" CssClass="btn resetSize btn-primary" />
                        </div>
                    </div>


                    <div class="select-page clearfix" style="margin-top: 20px;">
                    </div>
                    <div class="sell-table">
                        <div class="title-table">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th width="30%">�̼�����</th>
                                        <th width="10%">�۸�</th>
                                        <th width="10%">�ܿ��</th>
                                        <th width="10%">������</th>
                                        <th width="10%">�̼ұ���</th>
                                        <th width="8%">����</th>
                                        <th width="15%">����ʱ��</th>
                                        <th width="7%"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td colspan="8">
                                            <div class="mb10 table-operation">
                                                <input type="checkbox" id="sells1" class="allselect">
                                                <label for="sells1">ȫѡ</label>
                                                <Hi:ImageLinkButton ID="btnDelete" class="btn resetSize btn-danger" runat="server" Text="ɾ��" IsShow="true" DeleteMsg="ȷ��Ҫ����Ʒ�������վ�𣿷����̵������ƷҲ����ɾ����" />
                                                &nbsp;��
                                                            <button type="button" class="btn resetSize btn-primary" onclick="SelectOperation('5');">���ð���</button>
                                                <button type="button" class="btn resetSize btn-primary" onclick="SelectOperation('16');">�����˷�ģ��</button>
                                                &nbsp;��&nbsp;
                                                         <select id="dropBatchOperation" class="form-control resetSize autow inl inputw150">
                                                             <option value="">�������..</option>
                                                             <%--    <option value="1">��Ʒ�ϼ�</option>--%>
                                                             <%-- <option value="2">��Ʒ�¼�</option>--%>
                                                             <%--  <option value="3">��Ʒ���</option>--%>
                                                             <%--  <option value="5">���ð���</option>--%>
                                                             <%--  <option value="6">ȡ������</option>--%>
                                                             <option value="10">����������Ϣ</option>
                                                             <option value="11">������ʾ��������</option>
                                                             <option value="12">�������</option>
                                                             <option value="13">������Ա��</option>
                                                             <%-- <option value="15">������Ʒ������ǩ</option>--%>
                                                         </select>

                                                <asp:HyperLink Target="_blank" Visible="false" runat="server" ID="btnDownTaobao" Text="�����Ա���Ʒ" />
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="content-table">
                            <table class="table">
                                <tbody>
                                    <asp:Repeater ID="grdProducts" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td width="30%">
                                                    <input name="CheckBoxGroup" class="fl" type="checkbox" value='<%#Eval("ProductId") %>' />

                                                    <div class="img fl mr10">
                                                        <Hi:ListImage ID="ListImage1" runat="server" DataField="ThumbnailUrl60"  Width="60" Height="60"/>
                                                    </div>
                                                    <div class="shop-info">
                                                        <p class="mb5"><%# Eval("ProductName") %></p>
                                                        <a class="er" href="javascript:void(0)" onclick="winqrcode('<%#"http://"+Globals.DomainName+"/ProductDetails.aspx?productId="+Eval("ProductId")%>');"></a>
                                                        <input type="text" id='urldata<%# Eval("ProductId") %>' placeholder="" name='urldata<%# Eval("ProductId") %>' value='<%#"http://"+Globals.DomainName+"/ProductDetails.aspx?productId="+Eval("ProductId")%>' disabled="" style="display: none">
                                                        <a class="fz" href="javascript:void(0)" data-clipboard-target='urldata<%# Eval("ProductId") %>' id='url<%# Eval("ProductId") %>' onclick="copyurl(this.id);"></a>
                                                    </div>
                                                </td>
                                                <td width="10%">
                                                    <p>ԭ�ۣ�<span><%#Eval("MarketPrice", "{0:f2}")%></span></p>
                                                    <p>�ּۣ�<span><%# Eval("SalePrice", "{0:f2}")%></span></p>
                                                </td>
                                                <td width="10%"><%# Eval("Stock") %></td>
                                                <td width="10%"><%# Eval("SaleCounts") %></td>
                                                <td width="10%"><%#Eval("ProductCode") %></td>
                                                <td width="8%"><%#Eval("DisplaySequence") %></td>
                                                <td width="15%"><%#Eval("AddedDate") %></td>
                                                <td width="7%">
                                                      <p>
                                                        <a href="<%#"ProductEdit.aspx?productId="+Eval("ProductId")%>&reurl=<%=LocalUrl %>">�༭</a>
                                                             &nbsp;| &nbsp;  <a href="<%#"ProductEdit.aspx?productId="+Eval("ProductId")%>&isnext=1&reurl=<%=LocalUrl %>">����</a>
                                                    </p>
                                                    <p>
                                                        <Hi:ImageLinkButton ID="btnDel" CommandName="Delete" CommandArgument='<%# Eval("ProductId") %>'
                                                            runat="server" Text="ɾ��" IsShow="true"
                                                            DeleteMsg="ȷ��Ҫ����Ʒ�������վ�𣿷����̵������ƷҲ����ɾ����" />
                                                       
                                                    </p>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>

                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="page">
                        <div class="bottomPageNumber clearfix">
                            <div class="pageNumber">
                                <div class="pagination">
                                    <UI:Pager runat="server" ShowTotalPages="true" ID="pager" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <%-- �ϼ���Ʒ--%>
                    <div class="modal fade" id="divOnSaleProduct">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title">�¼���Ʒ</h4>
                                </div>
                                <div class="modal-body">
                                    <p>
                                        ȷ��Ҫ�ϼ���Ʒ���ϼܺ���Ʒ��ǰ̨����
                                    </p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">�ر�</button>
                                    <asp:Button ID="btnUpSale" runat="server" OnClientClick="return StockZore();" Text="�ϼ���Ʒ" CssClass="btn btn-primary" />
                                </div>
                            </div>
                            <!-- /.modal-content -->
                        </div>
                        <!-- /.modal-dialog -->
                    </div>
                    <%-- ��Ʒ��ά��--%>
                    <div class="modal fade" id="divqrcode">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title">��Ʒ��ά��</h4>
                                </div>
                                <div class="modal-body" style="text-align: center">
                                    <image id="imagecode" src=""></image>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">�ر�</button>
                                </div>
                            </div>
                            <!-- /.modal-content -->
                        </div>
                        <!-- /.modal-dialog -->
                    </div>
                    <%-- �¼���Ʒ--%>
                    <div class="modal fade" id="divUnSaleProduct">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title">�¼���Ʒ</h4>
                                </div>
                                <div class="modal-body">
                                    <p>
                                        ȷ��Ҫ�����Ʒ��������Ʒ������ǰ̨��ʾ 
                                    </p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">�ر�</button>
                                    <asp:Button ID="btnUnSale" runat="server" Text="�¼���Ʒ" CssClass="btn btn-primary" />
                                </div>
                            </div>
                            <!-- /.modal-content -->
                        </div>
                        <!-- /.modal-dialog -->
                    </div>

                    <%-- �����Ʒ--%>
                    <div id="divInStockProduct" style="display: none;">
                        <div class="frame-content">
                        </div>
                    </div>
                    <%-- ���ð���--%>

                    <div class="modal fade" id="divSetFreeShip">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title">���ð���</h4>
                                </div>
                                <div class="modal-body">
                                    <p>
                                        ȷ��Ҫ������Щ��Ʒ���ʣ� 
                                    </p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">�ر�</button>
                                    <asp:Button ID="btnSetFreeShip" runat="server" Text="���ð���" CssClass="btn btn-primary" />
                                </div>
                            </div>
                            <!-- /.modal-content -->
                        </div>
                        <!-- /.modal-dialog -->
                    </div>
                    <%-- �����˷�ģ��--%>

                    <div class="modal fade" id="divSetFreightTemplate">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title">�����˷�ģ��</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-inline">
                                        <div class="form-group mr20">
                                            <label for="sellshop4">ѡ���˷�ģ�壺</label>
                                            <Hi:FreightTemplateDownList ID="FreightTemplateDownList1" CssClass="form-control inputw100" runat="server" NullToDisplay="--��ѡ���˷�ģ��--"
                                                Width="180" />
                                        </div>

                                    </div>

                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">�ر�</button>
                                    <asp:Button ID="BtnTemplate" runat="server" Text="ȷ��" CssClass="btn btn-primary" />
                                </div>
                            </div>
                            <!-- /.modal-content -->
                        </div>
                        <!-- /.modal-dialog -->
                    </div>
                    <%-- ȡ������--%>
                    <div id="divCancelFreeShip" style="display: none;">
                        <div class="frame-content">
                            <p>
                                <em>ȷ��Ҫȡ����Щ��Ʒ�İ��ʣ�</em>
                            </p>
                        </div>
                    </div>
                    <%-- ��Ʒ��ǩ--%>
                    <div id="divTagsProduct" style="display: none;">
                        <div class="frame-content">
                            <Hi:ProductTagsLiteral ID="litralProductTag" runat="server"></Hi:ProductTagsLiteral>
                        </div>
                    </div>
                    <%--������Ϣ--%>
                    <div class="modal fade" id="divEditBaseInfo">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="modaltitle">������Ϣ</h4>
                                </div>
                                <div class="modal-body">
                                    <iframe id="MyEidtBaseInfoIframe" width="780" height="400"></iframe>
                                </div>
                                <div class="modal-footer">
                                </div>
                            </div>
                            <!-- /.modal-content -->
                        </div>
                        <!-- /.modal-dialog -->
                    </div>
                </div>
                <div class="tab-pane"></div>
                <div class="tab-pane"></div>

            </div>
        </div>

        <div style="display: none">
            <asp:Button ID="btnUpdateProductTags" runat="server" Text="������Ʒ��ǩ" CssClass="submit_DAqueding" />
            <Hi:TrimTextBox runat="server" ID="txtProductTag" TextMode="MultiLine"></Hi:TrimTextBox>
            <asp:Button ID="btnInStock" runat="server" Text="�����Ʒ" CssClass="submit_DAqueding" />



            <asp:Button ID="btnCancelFreeShip" runat="server" Text="ȡ������" CssClass="submit_DAqueding" />
        </div>
    </form>
</asp:Content>

