using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ecms.Website.DBServices;
using Ecms.Biz.Entities;
using Ecms.Biz;
using Ecms.Website.Common;
using CommonUtils;

namespace Ecms.Website.Site.MBGN
{
    public partial class Cart : System.Web.UI.Page
    {
        #region // Declares

        private readonly OrderService _orderService = new OrderService();
		protected double dTotalMoney = 0;

        #endregion

        #region // Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        protected void gridCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                switch (e.CommandName)
                {
                    case "productDelete":
                        var productId = Convert.ToInt32(e.CommandArgument);
                        if (Session["Cart"] != null)
                        {
                            var productCart = (List<Ecms.Website.Site.MBGN.CartModel>)Session["Cart"];
                            if (productCart.Count != 0)
                            {
                                var product = productCart.Where(x => x.ProductId == productId).FirstOrDefault();

                                if (product != null)
                                {
                                    productCart.Remove(product);
                                    Session["Cart"] = productCart;
                                    Response.Redirect("");
                                }
                            }
                        }
                        break;
                    case "calculatorCart":
                        foreach (GridViewRow item in gridCart.Rows)
                        {
                            if (item.RowType == DataControlRowType.DataRow)
                            {
                                var hdProductId = (HiddenField)item.FindControl("hdProductId");
                                var txtQuantity = (TextBox)item.FindControl("txtQuantity");
                                if (Session["Cart"] != null)
                                {
                                    List<Ecms.Website.Site.MBGN.CartModel> carts = new List<Ecms.Website.Site.MBGN.CartModel>();
                                    Ecms.Website.Site.MBGN.CartModel productTemp = new Ecms.Website.Site.MBGN.CartModel();
                                    var proId = Convert.ToInt32(hdProductId.Value);
                                    carts = (List<Ecms.Website.Site.MBGN.CartModel>)Session["Cart"];
                                    var product = carts.SingleOrDefault(x => x.ProductId == proId);
                                    if (product != null)
                                    {
                                        productTemp = product;
                                        //Update quantity product
                                        carts.Remove(product);
                                        productTemp.Quantity = Convert.ToInt32(txtQuantity.Text);
                                        carts.Add(productTemp);
                                    }
                                    Session["Cart"] = carts;
                                }
                            }
                        }
                        Response.Redirect("");
                        break;
                }
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        protected void btnOrder_Click(object sender, EventArgs e)
        {
			try
			{
				if (Session["Customer"] == null && Session["Cart"] == null)
				{
					Response.Redirect("~/site/mbgn/login.aspx");
				}
				Order order = new Order();
				order.OrderDate = order.CreatedDate = DateTime.Now;
				order.OrderTypeId = OrderType_Const.OrderByProduct;

				foreach (GridViewRow item in gridCart.Rows)
				{
					if (item.RowType == DataControlRowType.DataRow)
					{
						var hdProductId = (HiddenField)item.FindControl("hdProductId");
						var txtQuantity = (TextBox)item.FindControl("txtQuantity");
						
						if (Session["Cart"] != null)
						{
                            List<Ecms.Website.Site.MBGN.CartModel> carts = new List<Ecms.Website.Site.MBGN.CartModel>();
							Ecms.Website.Site.MBGN.CartModel productTemp = new Ecms.Website.Site.MBGN.CartModel();
							var proId = Convert.ToInt32(hdProductId.Value);
							carts = (List<Ecms.Website.Site.MBGN.CartModel>)Session["Cart"];
							var product = carts.SingleOrDefault(x => x.ProductId == proId);
							if (product != null)
							{
								productTemp = product;
								//Update quantity product
								carts.Remove(product);
								productTemp.Quantity = Convert.ToInt32(txtQuantity.Text);
								if (productTemp.Quantity > 0)
								{
									carts.Add(productTemp);
								}
							}
							Session["Cart"] = carts;
						}
					}
				}

				if (Session["Cart"] != null)
				{
					var listProductCart = (List<Ecms.Website.Site.MBGN.CartModel>)Session["Cart"];
					foreach (var item in listProductCart)
					{
						var orderDetail = new OrderDetail();
						orderDetail.ProductId = item.ProductId;
						orderDetail.Quantity = item.Quantity;
						orderDetail.PriceWeb = item.Price;
                        orderDetail.ProductName = item.ProductName;                        
						order.OrderDetails.Add(orderDetail);
					}
				}

				Session["Order"] = order;

				dTotalMoney = order.OrderDetails.Sum(p => (p.Quantity ?? 0) * (p.PriceWeb ?? 0));

				gridCartConfirm.DataSource = order.OrderDetails;
				gridCartConfirm.DataBind();

				gridCart.Visible = false;
				gridCartConfirm.Visible = true;

				btnOrder.Visible = false;
				btnOrderAccept.Visible = true;
			}
			catch (Exception ex)
			{
				Utils.ShowExceptionBox(ex, this);
			}
        }

		protected void btnOrderAccept_Click(object sender, EventArgs e)
		{
			try
			{
				if (Session["Customer"] != null)
				{
					Response.Redirect("~/site/mbgn/addInfodelivery.aspx");
				}
				else
				{
					if (Session["Order"] != null)
					{
						Response.Redirect("~/site/mbgn/login.aspx?ordercart=1");
					}
					else
					{
						Response.Redirect("~/site/mbgn/login.aspx");
					}
				}
			}
			catch (Exception ex)
			{
				Utils.ShowExceptionBox(ex, this);
			}
		}

        protected void btnContinues_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/site/mbgn2/productcategory.aspx");
        }

        #endregion

        #region // Private methods

        private void LoadData()
        {
            try
            {
                if (Session["Cart"] != null)
                {
                    List<Ecms.Website.Site.MBGN.CartModel> listProduct = (List<Ecms.Website.Site.MBGN.CartModel>)Session["Cart"];
                    if (listProduct.Count != 0)
                    {
                        pnCartEmpty.Visible = false;
                        pnCartNotEmty.Visible = true;

                        gridCart.DataSource = listProduct;
                        gridCart.DataBind();
                        //lblTotalMoney.Text = Convert.ToDouble(listProduct.Sum(x => x.Money)).ToString("N0");
                    }
                    else
                    {
                        pnCartEmpty.Visible = true;
                        pnCartNotEmty.Visible = false;
                    }
                }
                else
                {
                    pnCartEmpty.Visible = true;
                    pnCartNotEmty.Visible = false;
                }
            }
            catch (Exception ex)
            {
                Utils.ShowExceptionBox(ex, this);
            }
        }

        #endregion
    }
}