Return-Path: faizanh@linux.vnet.ibm.com
Message-ID: <50237463.4040401@linux.vnet.ibm.com>
Date: Thu, 09 Aug 2012 13:57:15 +0530
From: faizan husain <faizanh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Karel Zak <kzak@redhat.com>, Bernhard Voelker <mail@bernhard-voelker.de>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: limit options --all, --online, --offline to parsable
 and extended output
References: <20120808085911.GA3441@osiris.de.ibm.com> <50235651.6030409@linux.vnet.ibm.com> <20120809065759.GA3930@osiris.de.ibm.com> <50236466.2030906@linux.vnet.ibm.com> <20120809075859.GA6814@osiris.de.ibm.com>
In-Reply-To: <20120809075859.GA6814@osiris.de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <util-linux.vger.kernel.org>

On Thursday 09 August 2012 01:28 PM, Heiko Carstens wrote:
> On Thu, Aug 09, 2012 at 12:49:02PM +0530, faizan husain wrote:
>> On Thursday 09 August 2012 12:27 PM, Heiko Carstens wrote:
>>>>   [root@mx3650m2 ~]# lscpu -a
>>> That wouldn't work with the patch above applied (and without the patch
>>> applied there wouldn't be any difference in the output, regardless if you
>>> would specify "-a" or not).
>>>
>>> So.. I don't understand what your concern is.
>> My concern here is, earlier we used to print all the column information with
>> -a, -b(limit online and other column info), -c(limit offline and other column info.
>>
>> but with your patch we are certainly going to miss other information?
>>
>> here is output from you patch:
>>
>> [root@mx3650m2 ~]# lscpu -a
>> lscpu: options --all, --online and --offline may only be used with options --extended or --parsable.
>>
>> [root@mx3650m2 util-linux-2.21.1]# lscpu -ae
>>
>> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE
>> 0   0    0      0    0:0:0:0       yes
>> 1   0    0      1    1:1:1:0       yes
> [...]
>
>> so only CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE are printed with your patch.
>> other column like Architecture, CPU op-mode(s), Byte Order, Thread(s) per core,
>> vendors ID, CPU family etc... user are going to miss.
> lscpu never printed columns for architecture, threads per core etc. for the
> extended and parsable output. My patch doesn't make any difference here.
> Also it doesn't make any sense to print such static and identical information
> for each and every cpu line.
>
> The purpose of the extended and parsable output is to give the user an overview
> of the cpu topology and per cpu attributes.
> It's purpose is certainly not to give an overview of the whole system.

Sorry for creating confusion here,that is correct, lscpu never printed columns for architecture, threads per core etc. for the
extended and parsable output.
what i feel is earlier we used to have lot of other CPU Architecture specific information printed (see man page DESCRIPTION) with -a, -b ,-c option
but with your patch as -a, -b and -c are used only with -e and -p option those column information are suppressed.

Thanks

Faizan
