using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace Art_Backend
{
    [DataContract]
    public class CustomerDT
    {
        // Properties from User

        [DataMember]
        public string Name { get; set; }

        [DataMember]
        public string Surname { get; set; }

        [DataMember]
        public string Email { get; set; }

        [DataMember]
        public string ContactNumber { get; set; }

        [DataMember]
        public string StreetAddress { get; set; }

        [DataMember]
        public string City { get; set; }

        [DataMember]
        public string Province { get; set; }

        [DataMember]
        public string Image { get; set; }

        [DataMember]
        public DateTime CreatedAt { get; set; }

        // Properties from Customer
        [DataMember]
        public int? NoPurchases { get; set; }
    }
}