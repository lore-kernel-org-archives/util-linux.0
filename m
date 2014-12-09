Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57115 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755114AbaLIKfZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 9 Dec 2014 05:35:25 -0500
Date: Tue, 9 Dec 2014 11:35:20 +0100
From: Karel Zak <kzak@redhat.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: "Dale R. Worley" <worley@alum.mit.edu>, util-linux@vger.kernel.org
Subject: Re: Fwd: Re: util-linux: libblkid: UDF superblock
Message-ID: <20141209103520.GK19904@x2.net.home>
References: <87oaric0fs.fsf@hobgoblin.ariadne.com>
 <201412050325.06569@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <201412050325.06569@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 05, 2014 at 03:25:06AM +0100, Pali Rohár wrote:
> On Friday 05 December 2014 03:09:11 Dale R. Worley wrote:
> > Pali Rohár <pali.rohar@gmail.com> writes:
> > >> So I think that it is better to use LogicalVolumeIdentifier
> > >> for libblkid LABEL. And not current VolumeIdentifier.
> > >> 
> > >> What do you think?
> > 
> > If you change how the LABEL value is read from the disk, every
> > user will see different LABEL values than they saw in the
> > past.
> > 
> > Dale
> 
> Yes, but apparently other systems are using LABEL from 
> LogicalVolumeIdentifier. So now you see different labels on 
> different systems which is not good too.
> 
> Also that bsd project UDFclient (which is working on Linux too!) 
> is using LogicalVolumeIdentifier as volume/disk name in newfs_udf 
> tool.
> 
> I looked into grub2 code and it is identifying UDF label also 
> from LogicalVolumeIdentifier. So if you want to boot something 
> from UDF FS via grub you probably see label problems...
> 
> So I think that rather than using broken linux implementation is 
> better to fix it (which could bring problems with different label 
> names in new version). And I would like to see human readable 
> label as "555e3160".

It's more important to not introduce regression, if you have LABEL= in
your fstab then you don't want to see that after util-linux update
your setting is obsolete and filesystem unmounted.

It would be possible use another header field (LogicalVolumeIdentifier) for 
LABEL= only if the currently used field is empty.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
