Return-Path: util-linux-owner@vger.kernel.org
Received: from awesome.dsw2k3.info ([217.188.63.246]:51789 "EHLO
	awesome.dsw2k3.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754504AbbAIJXd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 9 Jan 2015 04:23:33 -0500
Date: Fri, 9 Jan 2015 10:16:34 +0100
From: Matthias Schniedermeyer <ms@citd.de>
To: Linda Walsh <lkml@tlinx.org>
Cc: Phillip Susi <psusi@ubuntu.com>, util-linux@vger.kernel.org,
        Matthew Eaton <m.eaton82@gmail.com>, Karel Zak <kzak@redhat.com>
Subject: Re: fdisk units size & disk manufacturers buying the standard
Message-ID: <20150109091634.GA18388@citd.de>
References: <CAF+0mvmE_i0P350hT4E4a-ZTTuuS5PdZ2vw1siQ2HowpB2Xn-g@mail.gmail.com>
 <20141204130044.GH1994@x2.net.home>
 <CAF+0mvm-fGvf3BOL6f8SsJgp75a3CP1xsVwkdD+_zP4hg06npQ@mail.gmail.com>
 <548619AF.5070900@tlinx.org>
 <54AB0D8F.2010100@ubuntu.com>
 <54ADCD95.4010903@tlinx.org>
 <54AE0005.9070502@ubuntu.com>
 <54AF3ED8.2030508@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54AF3ED8.2030508@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 08.01.2015 18:37, Linda Walsh wrote:
> Phillip Susi wrote:
> >>speed in Bytes varies by protocol.  1Gb-Base-T ethernet maxes out
> >>at a theoretical 125MB/s - divisible by 8.  But 10Gb ethernet maxes
> >>out at 1000MB/s -- with 20% of its bandwidth going to protocol
> >>overhead.
> >
> >I'm not aware of any additional overhead that 10Gb ethernet has over
> >1Gb ethernet,
> ----
> See kernel messages for a 10b-T ethernet.
> 
> [   21.224641] ixgbe 0000:05:00.0: PCI Express bandwidth of 32GT/s available
> [   21.224644] ixgbe 0000:05:00.0: (Speed:5.0GT/s, Width: x8, Encoding
> Loss:20%)
> 
> I don't recall a 20% encoding loss in 1Gb or 100Mb ethernet and the kernel
> displays
> no such messages for the slower speed cards.

The message speaks about PCIe.

So the 40GBit/s (a.k.a. 40GT/s) is in effect 32GBit/s on the PCIe side.
5.0 GT/s = PCIe Gen. 2. PCIe Gen. 1 & 2 use 8b/10b encoding.
IOW for every 8 bits of payload 10 bits go ever the wire. This is 20% 
the enconding loss the message speaks about.

PCIe Gen 3 (and 4) use an enhanced encoding called 128b/130b. IOW for
every 128 Bit of data 130Bits are send over the wire, so only 8GT/s
(instead of 10GT/s) were needed to (nearly) double the effective
datarate in Gen 3.

See:
http://en.wikipedia.org/wiki/PCI_Express

Which still leaves well enough headroom to get the 10Git/s for the 
ethernet-connection across.




-- 

Matthias
