using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NLog;
using NLog.Targets;
using NLog.Targets.Wrappers;
using System.Reflection;
using System.Diagnostics;
using System.Security.Cryptography;
using System.Globalization;
using System.Configuration;
using System.IO;
using System.Collections;

namespace CommonUtils
{
	class MbgnUtils
	{
	}

    public class StringUtils
    {
        static StringUtils()
        {
            InitVNCharsMap();
        }

        #region // Vietnamese:
        private static Hashtable s_htVNCharsMap = null;
        private static void InitVNCharsMap()
        {
            s_htVNCharsMap = new Hashtable(200);
            s_htVNCharsMap.Add('A', 'A'); s_htVNCharsMap.Add('Á', 'A'); s_htVNCharsMap.Add('À', 'A'); s_htVNCharsMap.Add('Ả', 'A'); s_htVNCharsMap.Add('Ã', 'A'); s_htVNCharsMap.Add('Ạ', 'A');
            s_htVNCharsMap.Add('Ă', 'A'); s_htVNCharsMap.Add('Ắ', 'A'); s_htVNCharsMap.Add('Ằ', 'A'); s_htVNCharsMap.Add('Ẳ', 'A'); s_htVNCharsMap.Add('Ẵ', 'A'); s_htVNCharsMap.Add('Ặ', 'A');
            s_htVNCharsMap.Add('Â', 'A'); s_htVNCharsMap.Add('Ấ', 'A'); s_htVNCharsMap.Add('Ầ', 'A'); s_htVNCharsMap.Add('Ẩ', 'A'); s_htVNCharsMap.Add('Ẫ', 'A'); s_htVNCharsMap.Add('Ậ', 'A');
            s_htVNCharsMap.Add('B', 'B');
            s_htVNCharsMap.Add('C', 'C');
            s_htVNCharsMap.Add('D', 'D');
            s_htVNCharsMap.Add('Đ', 'D');
            s_htVNCharsMap.Add('E', 'E'); s_htVNCharsMap.Add('É', 'E'); s_htVNCharsMap.Add('È', 'E'); s_htVNCharsMap.Add('Ẻ', 'E'); s_htVNCharsMap.Add('Ẽ', 'E'); s_htVNCharsMap.Add('Ẹ', 'E');
            s_htVNCharsMap.Add('Ê', 'E'); s_htVNCharsMap.Add('Ế', 'E'); s_htVNCharsMap.Add('Ề', 'E'); s_htVNCharsMap.Add('Ể', 'E'); s_htVNCharsMap.Add('Ễ', 'E'); s_htVNCharsMap.Add('Ệ', 'E');
            s_htVNCharsMap.Add('F', 'F');
            s_htVNCharsMap.Add('G', 'G');
            s_htVNCharsMap.Add('H', 'H');
            s_htVNCharsMap.Add('I', 'I'); s_htVNCharsMap.Add('Í', 'I'); s_htVNCharsMap.Add('Ì', 'I'); s_htVNCharsMap.Add('Ỉ', 'I'); s_htVNCharsMap.Add('Ĩ', 'I'); s_htVNCharsMap.Add('Ị', 'I');
            s_htVNCharsMap.Add('J', 'J');
            s_htVNCharsMap.Add('K', 'K');
            s_htVNCharsMap.Add('L', 'L');
            s_htVNCharsMap.Add('M', 'M');
            s_htVNCharsMap.Add('N', 'N');
            s_htVNCharsMap.Add('O', 'O'); s_htVNCharsMap.Add('Ó', 'O'); s_htVNCharsMap.Add('Ò', 'O'); s_htVNCharsMap.Add('Ỏ', 'O'); s_htVNCharsMap.Add('Õ', 'O'); s_htVNCharsMap.Add('Ọ', 'O');
            s_htVNCharsMap.Add('Ô', 'O'); s_htVNCharsMap.Add('Ố', 'O'); s_htVNCharsMap.Add('Ồ', 'O'); s_htVNCharsMap.Add('Ổ', 'O'); s_htVNCharsMap.Add('Ỗ', 'O'); s_htVNCharsMap.Add('Ộ', 'O');
            s_htVNCharsMap.Add('Ơ', 'O'); s_htVNCharsMap.Add('Ớ', 'O'); s_htVNCharsMap.Add('Ờ', 'O'); s_htVNCharsMap.Add('Ở', 'O'); s_htVNCharsMap.Add('Ỡ', 'O'); s_htVNCharsMap.Add('Ợ', 'O');
            s_htVNCharsMap.Add('P', 'P');
            s_htVNCharsMap.Add('Q', 'Q');
            s_htVNCharsMap.Add('R', 'R');
            s_htVNCharsMap.Add('S', 'S');
            s_htVNCharsMap.Add('T', 'T');
            s_htVNCharsMap.Add('U', 'U'); s_htVNCharsMap.Add('Ú', 'U'); s_htVNCharsMap.Add('Ù', 'U'); s_htVNCharsMap.Add('Ủ', 'U'); s_htVNCharsMap.Add('Ũ', 'U'); s_htVNCharsMap.Add('Ụ', 'U');
            s_htVNCharsMap.Add('Ư', 'U'); s_htVNCharsMap.Add('Ứ', 'U'); s_htVNCharsMap.Add('Ừ', 'U'); s_htVNCharsMap.Add('Ử', 'U'); s_htVNCharsMap.Add('Ữ', 'U'); s_htVNCharsMap.Add('Ự', 'U');
            s_htVNCharsMap.Add('V', 'V');
            s_htVNCharsMap.Add('W', 'W');
            s_htVNCharsMap.Add('X', 'X');
            s_htVNCharsMap.Add('Y', 'Y'); s_htVNCharsMap.Add('Ý', 'Y'); s_htVNCharsMap.Add('Ỳ', 'Y'); s_htVNCharsMap.Add('Ỷ', 'Y'); s_htVNCharsMap.Add('Ỹ', 'Y'); s_htVNCharsMap.Add('Ỵ', 'Y');
            s_htVNCharsMap.Add('Z', 'Z');
        }
        private static char CharVN2CharEN(char c)
        {
            object obj = s_htVNCharsMap[c];
            if (obj == null) return c;
            return (char)obj;
        }
        public static string StringVN2StringEN(string strVN)
        {
            if (strVN == null || strVN.Length == 0) return strVN;
            string str = strVN.ToUpper(new System.Globalization.CultureInfo("vi-VN"));
            StringBuilder strbd = new StringBuilder(200);
            for (int i = 0; i < str.Length; i++)
            {
                strbd.Append(CharVN2CharEN(str[i]));
            }
            return strbd.ToString();
        }

        #endregion

        #region // LongInt2VNSpeakString
        /// <summary>
		/// Translate number to String (for read currency)
		/// Ex : strTmp = LongInt2VNSpeakString(Convert.ToInt64(this.textBox1.Text), "Đồng");
		/// </summary>
		/// <param name="So">Number need translate</param>
		/// <param name="DVT">Đồng</param>
		/// <returns>Viet Namese String</returns>
		public static string LongInt2VNSpeakString(long So, string DVT)
		{

			if (So.ToString().Length > 18)
			{
				return "Số quá lớn";
			}
			else if (So == 0)
			{
				return "Không " + DVT;
			}
			else
			{
				string KQ = "";
				string[] donvi = { DVT, "ngàn", "triệu", "tỷ", "ngàn tỷ", "triệu tỷ" };
				string[] chuso = { "không", "một", "hai", "ba", "bốn", "năm", "sáu", "bảy", "tám", "chín" };
				if (So.ToString().Length > 3)
				{
					int ind;
					int sonhom;
					long tmp;
					sonhom = So.ToString().Length / 3;
					if (So.ToString().Length % 3 > 0)
					{
						sonhom += 1;
					}
					for (ind = 0; ind <= sonhom - 1; ind++)
					{
						tmp = (So / System.Convert.ToInt64(Math.Pow(1000, ind))) % 1000;
						if (tmp > 0)
						{
							if (ind > 0)
							{
								if (KQ == donvi[0])
								{
									KQ = LongInt2VNSpeakString(tmp, donvi[ind]) + " " + KQ.ToLower();
								}
								else
								{
									KQ = LongInt2VNSpeakString(tmp, donvi[ind]) + ", " + KQ.ToLower();
								}
							}
							else
							{
								KQ = LongInt2VNSpeakString(tmp, donvi[ind]);
							}
						}
						else if (ind == 0)
						{
							KQ = donvi[0];
						}
					}
					return KQ;
				}
				else
				{
					int tram;
					int chuc;
					int dv;
					tram = System.Convert.ToInt32((So / 100) % 10);
					chuc = System.Convert.ToInt32((So / 10) % 10);
					dv = System.Convert.ToInt32(So % 10);
					string tmp = "";
					if (tram == 0 & chuc == 0)
					{
						tmp = chuso[dv] + " " + DVT;
						//tmp = Microsoft.VisualBasic.Left(tmp, 1).ToUpper + tmp.Substring(1);
						tmp = tmp.Substring(0, 1).ToUpper() + tmp.Substring(1);
						return tmp;
					}
					if (tram != 0 & chuc == 0)
					{
						if (dv != 0)
						{
							tmp = chuso[tram] + " trăm lẻ " + chuso[dv] + " " + DVT;
						}
						else
						{
							tmp = chuso[tram] + " trăm " + DVT;
						}
						//tmp = Microsoft.VisualBasic.Left(tmp, 1).ToUpper + tmp.Substring(1);
						tmp = tmp.Substring(0, 1).ToUpper() + tmp.Substring(1);
						return tmp;
					}
					if (chuc == 1)
					{
						if (dv != 0)
						{
							if (dv == 5)
							{
								tmp = "mười lăm " + DVT;
							}
							else
							{
								tmp = "mười " + chuso[dv] + " " + DVT;
							}
						}
						else
						{
							tmp = "mười " + DVT;
						}
					}
					else
					{
						if (dv != 0)
						{
							if (dv == 5)
							{
								tmp = chuso[chuc] + " mươi lăm " + DVT;
							}
							else if (dv == 1)
							{
								tmp = chuso[chuc] + " mươi mốt " + DVT;
							}
							else
							{
								tmp = chuso[chuc] + " mươi " + chuso[dv] + " " + DVT;
							}
						}
						else
						{
							tmp = chuso[chuc] + " mươi " + DVT;
						}
					}
					if (tram != 0)
					{
						tmp = chuso[tram] + " trăm " + tmp;
						//tmp = Microsoft.VisualBasic.Left(tmp, 1).ToUpper + tmp.Substring(1);
						tmp = tmp.Substring(0, 1).ToUpper() + tmp.Substring(1);
						return tmp;
					}
					else
					{
						//tmp = Microsoft.VisualBasic.Left(tmp, 1).ToUpper + tmp.Substring(1);
						tmp = tmp.Substring(0, 1).ToUpper() + tmp.Substring(1);
						return tmp;
					}
				}
			}
		}
		#endregion
    }
}
