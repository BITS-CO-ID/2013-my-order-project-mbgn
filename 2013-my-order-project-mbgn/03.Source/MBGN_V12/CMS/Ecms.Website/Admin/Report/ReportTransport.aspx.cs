using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using Ecms.Website.DBServices;
using Ecms.Website.Common;
using Ecms.Biz.Class;
using System.Data;

namespace Ecms.Website.Admin.Report
{
	public partial class ReportTransport : PageBase
    {
        #region //Declares

        private readonly ReportService _reportService = new ReportService();
		protected double rptSumAmout = 0;
		protected double rptPayAmount = 0;
		protected double rptSumWeight = 0;
        #endregion

        #region //Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                InitData();

                //LoadData(1);
            }
        }

        protected void gridMain_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gridMain.PageIndex = e.NewPageIndex;
            LoadData(2);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadData(1);
        }

        #endregion

        #region //Private methods

        private void InitData()
        {
            try
            {
                if (Session["User"] == null)
                {
                    Response.Redirect("~/admin/security/login.aspx");
                }

                //var currentDate = DateTime.Now;
                ////Lấy ngày đầu tháng
                //DateTime fDate = new DateTime(currentDate.Year, currentDate.Month, 1, 0, 0, 0);
                //txtFromDate.Text = fDate.ToString("dd/MM/yyyy");
                //txtToDate.Text = currentDate.ToString("dd/MM/yyyy");
                ////Set data vào calendar conntrol
                //cldFromDate.SelectedDate = fDate;
                //cldToDate.SelectedDate = currentDate;
			
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        private void LoadData(int type)
        {
            try
            {
                if (type == 1)
                {
                    DateTime fDate = new DateTime();
                    DateTime tDate = new DateTime();
                    string  fromDate    = "",
                            toDate      = "",
                            fromDeliveryFromDate    = "",
                            fromDeliveryToDate      = "";
                    if (!ValidData(ref fDate, ref tDate, this.txtFromDate, this.txtToDate))
                    {
                        
                    }
                    else
                    {
                        fromDate = new DateTime(fDate.Year, fDate.Month, fDate.Day, 0, 0, 0).ToString("yyyy-MM-dd HH:mm:ss");
                        toDate = new DateTime(tDate.Year, tDate.Month, tDate.Day, 23, 59, 59).ToString("yyyy-MM-dd HH:mm:ss");
                    }

                    DateTime fdlfromDate = new DateTime();
                    DateTime tdltoDate = new DateTime();
                    if (!ValidData(ref fdlfromDate, ref tdltoDate, this.txtGHFromDate, this.txtGHToDate))
                    {
                        
                    }
                    else
                    {
                        fromDeliveryFromDate = new DateTime(fdlfromDate.Year, fdlfromDate.Month, fdlfromDate.Day, 0, 0, 0).ToString("yyyy-MM-dd HH:mm:ss");
                        fromDeliveryToDate = new DateTime(tdltoDate.Year, tdltoDate.Month, tdltoDate.Day, 23, 59, 59).ToString("yyyy-MM-dd HH:mm:ss");
                    }
					var listResult = _reportService.ReportOrderTranportBuy(
											fromDate,
                                            toDate,
											txtOrderNo.Text,
											txtCustomerCode.Text,
											this.ddlStatus.SelectedValue,
											this);

                    if (!string.IsNullOrEmpty(fromDeliveryFromDate))
                    { 
                        var wDate=Convert.ToDateTime(fromDeliveryFromDate);
                        listResult = listResult.Where(p => p.DeliverlyDate >= wDate).ToList();
                    }

                    if (!string.IsNullOrEmpty(fromDeliveryToDate))
                    {
                        var wDate = Convert.ToDateTime(fromDeliveryToDate);
                        listResult = listResult.Where(p => p.DeliverlyDate <= wDate).ToList();
                    }

                    if (listResult.Count == 0)
                    {
                        gridMain.Visible = false;
                        lblError.Visible = true;
                        lblError.Text = "Không tìm thấy dữ liệu theo điều kiện tìm kiếm!";
                        return;
                    }
					rptSumAmout = listResult.Where(p=>(new int[] { 2, 4, 6, 7 }).Contains(p.OrderStatus??0)).Sum(x => x.SumAmount);
					rptPayAmount = listResult.Sum(x => x.PayAmount);
					rptSumWeight = listResult.Sum(x => x.SumWeight);

                    gridMain.Visible = true;
                    lblError.Visible = false;
                    gridMain.DataSource = listResult;
                    gridMain.DataBind();
					Session["ReportTransport"] = listResult;
                }

                if (type == 2)
                {
					if (Session["ReportTransport"] != null)
                    {
						var listResult = (List<RptOrderTransportModel>)Session["ReportTransport"];
						rptSumAmout = listResult.Where(p => (new int[] { 2, 4, 6, 7 }).Contains(p.OrderStatus ?? 0)).Sum(x => x.SumAmount);
						rptPayAmount = listResult.Sum(x => x.PayAmount);
						rptSumWeight = listResult.Sum(x => x.SumWeight);

                        gridMain.Visible = true;
                        lblError.Visible = false;
                        gridMain.DataSource = listResult;
                        gridMain.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        private bool ValidData(ref DateTime fDate, ref DateTime tDate, TextBox tFromDate, TextBox tToDate)
        {
            if (string.IsNullOrEmpty(tFromDate.Text))
            {
                //lblError.Text = "Từ ngày không được để trống!";
                //lblError.Visible = true;
                return false;
            }

            try
            {
                CultureInfo viVN = new CultureInfo("vi-VN");
                fDate = DateTime.ParseExact(tFromDate.Text, "dd/MM/yyyy", viVN);
            }
            catch
            {
                lblError.Text = "Từ ngày không đúng định dạng!";
                lblError.Visible = true;
                return false;
            }

            if (string.IsNullOrEmpty(tToDate.Text))
            {
                lblError.Text = "Đến ngày không được để trống!";
                lblError.Visible = true;
                return false;
            }

            try
            {
                CultureInfo viVN = new CultureInfo("vi-VN");
                tDate = DateTime.ParseExact(tToDate.Text, "dd/MM/yyyy", viVN);
            }
            catch
            {
                lblError.Text = "Đến ngày không đúng định dạng!";
                lblError.Visible = true;
                return false;
            }

            return true;
        }

		private DataTable ReturnDatatable(List<RptOrderTransportModel> lstToTable)
		{
			DataTable objTable = new DataTable();

			#region Create header
			objTable.Columns.Add("STT");
			objTable.Columns.Add("Mã đơn hàng");
			objTable.Columns.Add("Ngày đặt hàng");
            objTable.Columns.Add("Ngày giao hàng");
			objTable.Columns.Add("Mã khách hàng");
			objTable.Columns.Add("Tên khách hàng");
			objTable.Columns.Add("Trọng lượng");
			objTable.Columns.Add("Tổng tiền");
			objTable.Columns.Add("Đã thanh toán");
			objTable.Columns.Add("Tình trạng");
			objTable.Columns.Add("Ghi chú");
			#endregion
			int index = 1;
			foreach (var item in lstToTable)
			{
				var row = objTable.NewRow();
				row["STT"] = index;
				row["Mã đơn hàng"] = item.OrderNo;
				row["Ngày đặt hàng"] = item.OrderDate==null?"":item.OrderDate.Value.ToString("dd/MM/yyyy");
                row["Ngày giao hàng"] = item.DeliverlyDate == null ? "" : item.DeliverlyDate.Value.ToString("dd/MM/yyyy");
				row["Mã khách hàng"] = item.CustomerCode;
				row["Tên khách hàng"] = item.CustomerName;
				row["Trọng lượng"] = item.SumWeight;
				row["Tổng tiền"] = item.SumAmount;
				row["Đã thanh toán"] = item.PayAmount;
				row["Tình trạng"] = item.StatusText;
				row["Ghi chú"] = item.Remark;

				objTable.Rows.Add(row);
				index += 1;
			}

			var rowFuter = objTable.NewRow();
			rowFuter["STT"] = "Tổng";
			rowFuter["Trọng lượng"] = lstToTable.Sum(p=>p.SumWeight);
			rowFuter["Tổng tiền"] = lstToTable.Sum(p => p.SumAmount);
			rowFuter["Đã thanh toán"] = lstToTable.Sum(p => p.PayAmount);
			objTable.Rows.Add(rowFuter);
			return objTable;
		}

		protected void btnExcel_Click(object sender, EventArgs e)
		{
			if (Session["ReportTransport"] == null)
			{
				Response.Redirect("~/admin/security/login.aspx");
			}
			var listResult = (List<RptOrderTransportModel>)Session["ReportTransport"];
			var table = ReturnDatatable(listResult);
			HttpContext.Current.Response.Clear();
			HttpContext.Current.Response.ClearContent();
			HttpContext.Current.Response.ClearHeaders();
			HttpContext.Current.Response.Buffer = true;
			HttpContext.Current.Response.ContentType = "application/ms-excel";
			HttpContext.Current.Response.Write(@"<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">");
			HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment;filename=ReportDHVC.xls");

			HttpContext.Current.Response.Charset = "utf-8";
			//HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.GetEncoding("windows-1250");
			//sets font
			HttpContext.Current.Response.Write("<font style='font-size:10.0pt; font-family:Calibri;'>");
			HttpContext.Current.Response.Write("<BR><BR><BR>");
			HttpContext.Current.Response.Write("<Table border='1' bgColor='#ffffff' borderColor='#000000' cellSpacing='0' cellPadding='0' style='font-size:10.0pt; font-family:Calibri; background:white;'> <TR>");
			int columnscount = table.Columns.Count;


			HttpContext.Current.Response.Write("<th colspan='11' style='font-size:14.0pt; font-family:Calibri;'>");
			HttpContext.Current.Response.Write("<B>");
			HttpContext.Current.Response.Write("BÁO CÁO TỔNG HỢP ĐƠN HÀNG VẬN CHUYỂN");
			HttpContext.Current.Response.Write("</B>");
			HttpContext.Current.Response.Write("</th>");
			HttpContext.Current.Response.Write("</TR>");

			// fromDate			
			HttpContext.Current.Response.Write("<th colspan='4' align='left' style='font-size:11.0pt; font-family:Calibri;'>");
			HttpContext.Current.Response.Write("<B>");
			HttpContext.Current.Response.Write(string.Format("<b>Từ ngày:</b> {0}", txtGHFromDate.Text));
			HttpContext.Current.Response.Write("</B>");
			HttpContext.Current.Response.Write("</th>");
			HttpContext.Current.Response.Write("</TR>");

			// toDate
			HttpContext.Current.Response.Write("<th colspan='4' align='left' style='font-size:11.0pt; font-family:Calibri;'>");
			HttpContext.Current.Response.Write("<B>");
			HttpContext.Current.Response.Write(string.Format("<b>Tới ngày:</b> {0}", txtGHToDate.Text));
			HttpContext.Current.Response.Write("</B>");
			HttpContext.Current.Response.Write("</th>");
			HttpContext.Current.Response.Write("</TR>");

			// orderNo
			HttpContext.Current.Response.Write("<th colspan='4' align='left' style='font-size:11.0pt; font-family:Calibri;'>");
			HttpContext.Current.Response.Write("<B>");
			HttpContext.Current.Response.Write(string.Format("<b>Mã đơn hàng:</b> {0}", txtOrderNo.Text));
			HttpContext.Current.Response.Write("</B>");
			HttpContext.Current.Response.Write("</th>");
			HttpContext.Current.Response.Write("</TR>");

			// CustomerCode
			HttpContext.Current.Response.Write("<th colspan='4' align='left' style='font-size:11.0pt; font-family:Calibri;'>");
			HttpContext.Current.Response.Write("<B>");
			HttpContext.Current.Response.Write(string.Format("<b>Mã khách hàng:</b> {0}", txtCustomerCode.Text));
			HttpContext.Current.Response.Write("</B>");
			HttpContext.Current.Response.Write("</th>");
			HttpContext.Current.Response.Write("</TR>");

			HttpContext.Current.Response.Write("<TR>");
			for (int j = 0; j < columnscount; j++)
			{
				//Makes headers bold
				HttpContext.Current.Response.Write("<Td>");
				HttpContext.Current.Response.Write("<B>");
				HttpContext.Current.Response.Write(table.Columns[j].ColumnName);
				HttpContext.Current.Response.Write("</B>");
				HttpContext.Current.Response.Write("</Td>");
			}
			HttpContext.Current.Response.Write("</TR>");
			foreach (DataRow row in table.Rows)
			{
				HttpContext.Current.Response.Write("<TR>");
				for (int i = 0; i < table.Columns.Count; i++)
				{
					HttpContext.Current.Response.Write("<Td>");
					HttpContext.Current.Response.Write(row[i].ToString());
					HttpContext.Current.Response.Write("</Td>");
				}
				HttpContext.Current.Response.Write("</TR>");
			}
			HttpContext.Current.Response.Write("</Table>");
			HttpContext.Current.Response.Write("</font>");
			HttpContext.Current.Response.Flush();
			HttpContext.Current.Response.End();

		}
        #endregion
    }
}