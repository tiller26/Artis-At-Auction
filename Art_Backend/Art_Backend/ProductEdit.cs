using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace Art_Backend
{
	[DataContract]
	public class ProductEdit
	{
		[DataMember]
		public int Id { get; set; }
		
		[DataMember]
		public string Name { get; set; }

		[DataMember]
		public string Description { get; set; }

		[DataMember]
		public decimal Price { get; set; }
	}
}