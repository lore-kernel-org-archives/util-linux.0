Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40479 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087AbaLSN4O (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 19 Dec 2014 08:56:14 -0500
Date: Fri, 19 Dec 2014 14:56:08 +0100
From: Karel Zak <kzak@redhat.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: "Dale R. Worley" <worley@alum.mit.edu>, util-linux@vger.kernel.org
Subject: Re: Fwd: Re: util-linux: libblkid: UDF superblock
Message-ID: <20141219135608.GN19904@x2.net.home>
References: <87oaric0fs.fsf@hobgoblin.ariadne.com>
 <201412050325.06569@pali>
 <20141209103520.GK19904@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141209103520.GK19904@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 09, 2014 at 11:35:20AM +0100, Karel Zak wrote:
> > I looked into grub2 code and it is identifying UDF label also 
> > from LogicalVolumeIdentifier. So if you want to boot something 
> > from UDF FS via grub you probably see label problems...
> > 
> > So I think that rather than using broken linux implementation is 
> > better to fix it (which could bring problems with different label 
> > names in new version). And I would like to see human readable 
> > label as "555e3160".
> 
> It's more important to not introduce regression, if you have LABEL= in
> your fstab then you don't want to see that after util-linux update
> your setting is obsolete and filesystem unmounted.

You have convinced me that fix the problem (and improve compatibility)
with UDF LABEL= is a good idea.

Not sure, but I guess that for many users the change will be invisible
because preferred way is to read the LABEL from ISO9660 header and
UDF specific LABEL is just fallback solution only. 

The latest Pali's patches are at:
https://github.com/karelzak/util-linux/pull/135

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
