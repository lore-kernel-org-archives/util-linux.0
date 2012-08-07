Return-Path: util-linux-owner@vger.kernel.org
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:60061 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab2HGJBg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Aug 2012 05:01:36 -0400
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <faizanh@linux.vnet.ibm.com>;
	Tue, 7 Aug 2012 14:31:33 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q7791Wwv27459786
	for <util-linux@vger.kernel.org>; Tue, 7 Aug 2012 14:31:32 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q7791T8v027776
	for <util-linux@vger.kernel.org>; Tue, 7 Aug 2012 19:01:31 +1000
Message-ID: <5020D968.4020405@linux.vnet.ibm.com>
Date: Tue, 07 Aug 2012 14:31:28 +0530
From: faizan husain <faizanh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu : -b and -c option does not give expected output.
References: <1344229852-4737-1-git-send-email-faizanh@linux.vnet.ibm.com> <20120806114906.GA3432@osiris.de.ibm.com> <5020A7F8.9070402@linux.vnet.ibm.com> <20120807073509.GA31284@osiris.de.ibm.com>
In-Reply-To: <20120807073509.GA31284@osiris.de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 07 August 2012 01:05 PM, Heiko Carstens wrote:
> On Tue, Aug 07, 2012 at 11:00:32AM +0530, faizan husain wrote:
>> On Monday 06 August 2012 05:20 PM, Heiko Carstens wrote:
>>> On Sun, Aug 05, 2012 at 10:10:52PM -0700, Faizan husain wrote:
>>>> From: faizan husain <faizanh@linux.vnet.ibm.com>
>>>>
>>>> Options for lscpu command are giving incorrect output.
>>>> As per the man page or help, '-b' option should limit the output to online CPUs
>>>> and '-c' option should limit the output to offline CPUs.
>>>> But we could see the output is same for '-a','-b' and '-c' options.
>>>>
>>>> Signed-off-by: faizan husain <faizanh@linux.vnet.ibm.com>
>>> The -a, -b and -c options were meant to influence the output for the
>>> extended (-e) and parsable (-p) output options.
>>> I'm not sure it makes sense to change the default output with these
>>> options. I'd prefer an update of the man page.
>>>
>>> Hm?
>> This fix is not going to influence the default output with these
>> options (-e and -p),
> Yes, I'm aware of that.
>
>> and it does not make any sense if -a, -b and -c option print same output.
> Just to make sure we talk about the same things:
>
> extended output: -e option
> parsable output: -p option
> default output : no -e or -p option specified
>
> What I tried to say above was that the -a, -b and -c modifiers were
> only added to influence the output for the extended and parsable
> options.
> If you have a system with a lot of cpus the output can be significantly
> different for the extended and parsable options if you specify any of the
> modifiers.

yes it does ...

[root@mx3650m2 ~]# lscpu -a

[...]

CPU(s):                16

On-line CPU(s) list:   0-2,4,6-8,10-15

Off-line CPU(s) list:  3,5,9

[...]

[root@mx3650m2 ~]# lscpu -e

CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE

0   0    0      0    0:0:0:0       yes

1   0    0      1    1:1:1:0       yes

2   0    0      2    2:2:2:0       yes

3   -    -      -    :::           no

4   1    1      3    3:3:3:1       yes

5   -    -      -    :::           no

6   1    1      4    4:4:4:1       yes

7   1    1      5    5:5:5:1       yes

8   0    0      0    0:0:0:0       yes

9   -    -      -    :::           no

10  0    0      2    2:2:2:0       yes

11  0    0      6    6:6:6:0       yes

12  1    1      3    3:3:3:1       yes

13  1    1      7    7:7:7:1       yes

14  1    1      4    4:4:4:1       yes

15  1    1      5    5:5:5:1       yes

[root@mx3650m2 ~]# lscpu -p

# The following is the parsable format, which can be fed to other

# programs. Each different item in every column has an unique ID

# starting from zero.

# CPU,Core,Socket,Node,,L1d,L1i,L2,L3

0,0,0,0,,0,0,0,0

1,1,0,0,,1,1,1,0

2,2,0,0,,2,2,2,0

4,3,1,1,,3,3,3,1

6,4,1,1,,4,4,4,1

7,5,1,1,,5,5,5,1

8,0,0,0,,0,0,0,0

10,2,0,0,,2,2,2,0

11,6,0,0,,6,6,6,0

12,3,1,1,,3,3,3,1

13,7,1,1,,7,7,7,1

14,4,1,1,,4,4,4,1

15,5,1,1,,5,5,5,1

[root@mx3650m2 ~]#

>
> The default output (no -e or -p) however is intended to give an overview
> of the complete system.
>
> So from a usability point of view: why would a user want to exclude the
> line which contains the online list of cpus for the default output?

default output has no problem here,it will contain both online and offline cpus

as mentioned in the man page.

        -a, --all

               Include online and offline CPUs in the output (default for -e).

and if user wants to limit the output to only online/offline cpus then he can use -b / -c modifier

        -b, --online

               Limit the output to online CPUs (default for -p).

        -c, --offline

               Limit the output to offline CPUs.

>  From my point of view the correct "fix" would be to change the lscpu man
> page in order to document that the -a, -b and -c modifiers only influence
> the output for the extended and parsable options.

Thanks

Faizan

