using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Transactions;
using Ecms.Biz.Entities;
using CommonUtils;

namespace Ecms.Biz
{
	public class Test3 : Respository
	{
		public Test3()
			: base()
		{

		}

		public void a_33()
		{
			// update

			var a = this.EcmsDataContext.Invoices.Any(x => x.InvoiceCode == "a");

			var c10 = this.EcmsDataContext.Companies.Any(p => p.DUser == "a");
			var c1 = this.EcmsDataContext.Companies.SingleOrDefault(p => p.CompanyId == 1);
			c1.CompanyName = string.Format("C1_1_{0}",DateTime.Now.ToString("yyMMddHHmmssfff"));
			this.EcmsDataContext.SaveChanges();
			NLogLogger.Info(string.Format("update : {0}, Time: {1}", "a_3", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
		}

		
	}
}
