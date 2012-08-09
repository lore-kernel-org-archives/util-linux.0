Return-Path: faizanh@linux.vnet.ibm.com
Message-ID: <50236466.2030906@linux.vnet.ibm.com>
Date: Thu, 09 Aug 2012 12:49:02 +0530
From: faizan husain <faizanh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Karel Zak <kzak@redhat.com>, Bernhard Voelker <mail@bernhard-voelker.de>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: limit options --all, --online, --offline to parsable
 and extended output
References: <20120808085911.GA3441@osiris.de.ibm.com> <50235651.6030409@linux.vnet.ibm.com> <20120809065759.GA3930@osiris.de.ibm.com>
In-Reply-To: <20120809065759.GA3930@osiris.de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <util-linux.vger.kernel.org>

On Thursday 09 August 2012 12:27 PM, Heiko Carstens wrote:
> On Thu, Aug 09, 2012 at 11:48:57AM +0530, faizan husain wrote:
>> On Wednesday 08 August 2012 02:29 PM, Heiko Carstens wrote:
>>> So, how about the patch below in order to fix the issue Faisan
>>> brought up for lspcu?
>>>
>>>  From 0f0f80b71e90b6ab58d9f6009b8356bb42235916 Mon Sep 17 00:00:00 2001
>>> From: Heiko Carstens <heiko.carstens@de.ibm.com>
>>> Date: Wed, 8 Aug 2012 10:52:47 +0200
>>> Subject: [PATCH] lscpu: limit options --all, --online, --offline to parsable
>>>   and extended output
>>>
>>> Passing the --all, --online or --offline options for the output summary
>>> doesn't make much sense. It should be limited to the two list output options.
> [...]
>
>>> +	if (cpu_modifier_specified && mod->mode == OUTPUT_SUMMARY) {
>>> +		fprintf(stderr,
>>> +			_("%s: options --all, --online and --offline may only "
>>> +			  "be used with options --extended or --parsable.\n"),
>>> +			program_invocation_short_name);
>>> +		return EXIT_FAILURE;
>>> +	}
>>> +
>>>   	if (argc != optind)
>>>   		usage(stderr);
>>>
>> but...
>>
>> don't you think we are missing on other column information
>>
>>   [root@mx3650m2 ~]# lscpu -a
> That wouldn't work with the patch above applied (and without the patch
> applied there wouldn't be any difference in the output, regardless if you
> would specify "-a" or not).
>
> So.. I don't understand what your concern is.

My concern here is, earlier we used to print all the column information with -a, -b(limit online and other column info), -c(limit offline and other column info.

but with your patch we are certainly going to miss other information?

here is output from you patch:

[root@mx3650m2 ~]# lscpu -a
lscpu: options --all, --online and --offline may only be used with options --extended or --parsable.

[root@mx3650m2 util-linux-2.21.1]# lscpu -ae

CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE

0   0    0      0    0:0:0:0       yes

1   0    0      1    1:1:1:0       yes

2   0    0      2    2:2:2:0       yes

3   -    -      -    :::           no

4   1    1      3    3:3:3:1       yes

5   -    -      -    :::           no

6   1    1      4    4:4:4:1       yes

7   -    -      -    :::           no

8   0    0      0    0:0:0:0       yes

9   -    -      -    :::           no

10  0    0      2    2:2:2:0       yes

11  0    0      5    5:5:5:0       yes

12  1    1      3    3:3:3:1       yes

13  1    1      6    6:6:6:1       yes

14  1    1      4    4:4:4:1       yes

15  1    1      7    7:7:7:1       yes

[root@mx3650m2 util-linux-2.21.1]# lscpu -be

CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE

0   0    0      0    0:0:0:0       yes

1   0    0      1    1:1:1:0       yes

2   0    0      2    2:2:2:0       yes

4   1    1      3    3:3:3:1       yes

6   1    1      4    4:4:4:1       yes

8   0    0      0    0:0:0:0       yes

10  0    0      2    2:2:2:0       yes

11  0    0      5    5:5:5:0       yes

12  1    1      3    3:3:3:1       yes

13  1    1      6    6:6:6:1       yes

14  1    1      4    4:4:4:1       yes

15  1    1      7    7:7:7:1       yes

[root@mx3650m2 util-linux-2.21.1]# lscpu -ce

CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE

3   -    -      -    :::           no

5   -    -      -    :::           no

7   -    -      -    :::           no

9   -    -      -    :::           no

[root@mx3650m2 util-linux-2.21.1]#
so only CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE are printed with your patch.
other column like Architecture, CPU op-mode(s), Byte Order, Thread(s) per core, vendors ID, CPU family etc... user are going to miss.

Thanks
Faizan

> Besides that personally I would prefer to _only_ update the man page and
> don't change the code at all.
>
>> Architecture:          x86_64
>> CPU op-mode(s):        32-bit, 64-bit
>> Byte Order:            Little Endian
>> CPU(s):                16
>> On-line CPU(s) list:   0-5,7-13,15
>> Off-line CPU(s) list:  6,14
>> Thread(s) per core:    2
>> Core(s) per socket:    3
>> Socket(s):             2
>> NUMA node(s):          2
>> Vendor ID:             GenuineIntel
>> CPU family:            6
>> Model:                 26
>> Stepping:              5
>> CPU MHz:               1596.000
>> BogoMIPS:              5865.80
>> Virtualization:        VT-x
>> L1d cache:             32K
>> L1i cache:             32K
>> L2 cache:              256K
>> L3 cache:              8192K
>> NUMA node0 CPU(s):     0-3,8-11
>> NUMA node1 CPU(s):     4,5,7,12,13,15
