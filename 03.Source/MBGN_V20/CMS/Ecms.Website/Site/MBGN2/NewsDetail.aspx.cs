using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ecms.Website.DBServices;
using Ecms.Website.Common;

namespace Ecms.Website.Site.MBGN2
{
    public partial class NewsDetail : System.Web.UI.Page
    {
        #region //Declares

        private readonly CommonService _commonService = new CommonService();

        #endregion

        #region //Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        #endregion 

        #region //Private methods

        private void LoadData()
        {
            try
            {
                if (RouteData.Values["newsId"] != null)
                {
                    var news = _commonService.NewsGet(RouteData.Values["newsId"].ToString(), "", "", this).FirstOrDefault();
                    if (news != null)
                    {
                        lblNewsTitle.Text   = news.Title;
                        litNewsContent.Text = news.NewsContent;
                    }
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