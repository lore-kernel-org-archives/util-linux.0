Return-Path: hpa@zytor.com
Message-ID: <5292430D.6000709@zytor.com>
Date: Sun, 24 Nov 2013 10:18:53 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>, Craig <util-linux_contact@magister.com.au>
CC: util-linux@vger.kernel.org
Subject: Re: ***Urgent***!  Fdisk: GPT support utterly breaks hybrid MBR;
 *must* have disable option! :(
References: <alpine.LFD.2.03.1310092211290.7406@aslan.magister.com.au> <20131009141628.GB940@x2.net.home> <alpine.LFD.2.02.1310101129260.4624@trabz.zntvfgre.pbz.nh> <20131010111045.GA29199@x2.net.home> <alpine.LFD.2.02.1310111435300.6990@trabz.zntvfgre.pbz.nh> <20131011090442.GE14457@x2.net.home>
In-Reply-To: <20131011090442.GE14457@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 10/11/2013 02:04 AM, Karel Zak wrote:
> 
>  Yep. I don't want any "smart" solution there. All will be controlled
>  by users. 
>  
>  (Well, in the default mode for non-expert users with standard PMBR we will 
>   generate the MBR as expected by UEFI specification of course.)
> 

There is one other useful mode for non-expert users, which is the one in
which the current (hybrid) boot partition is manifest in the MBR (as
well as as the GPT of course.)  Changing the hybrid boot partition would
change the MBR to match.  From a UI perspective this could very easily
be done by setting or removing a "hybrid" flag on a partition.

One could potentially allow more than one hybrid partition, but when one
then accounts for PMBR partitions, there is no guarantee that one can
fit more than one unless the layout is suitable.

In the worst case, one can always fit one:

MBR:	1. Leading PMBR partition
	2. Hybrid boot partition
	3. Tailing PMBR partition

In the best case, one can fit 3:

MBR:	1. Hybrid partition 1
	2. Hybrid partition 2
	3. Hybrid partition 3
	4. Tailing PMBR partition

	-hpa
