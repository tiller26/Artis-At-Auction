using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace Art_Backend
{
	[DataContract]
	public class ProductReg
	{
		[DataMember]
		public string Name { get; set; }

		[DataMember]
		public string Description { get; set; }

		[DataMember]
		public decimal Price { get; set; }

		[DataMember]
		public int Quantity { get; set; }

		[DataMember]
		public string Color { get; set; }

		[DataMember]
		public int SellerId { get; set; }

		[DataMember]
		public string[] Images { get; set; }

		[DataMember]
		public string Category { get; set; }
	}
}