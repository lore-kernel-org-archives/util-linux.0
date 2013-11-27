Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:11170 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648Ab3K0UHk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 27 Nov 2013 15:07:40 -0500
Date: Wed, 27 Nov 2013 21:07:24 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: Marc MERLIN <marc@merlins.org>, util-linux@vger.kernel.org
Subject: Re: Severe fdisk problem leading to data loss?
Message-ID: <20131127200724.GT5572@x2.net.home>
References: <20131118102051.GA31813@merlins.org>
 <20131124135226.GH11389@merlins.org>
 <20131125103124.GQ5572@x2.net.home>
 <529605B7.3020903@ubuntu.com>
 <20131127145840.GB32483@x2.net.home>
 <52963910.60800@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52963910.60800@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 27, 2013 at 01:25:20PM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 11/27/2013 9:58 AM, Karel Zak wrote:
> > After 20 years it's feature ;-) as I'm almost sure that we cannot
> > fix it and disable all partition where is no the ID.
> 
> While that's cute and all, I think we both know it isn't really true ;)

:-)

> > And Linux kernel have never cared about partition type (this is
> > not specific to MBR, the same behaviour we have for Sun, SGI, MAC,
> > BSD, ..), only PT where we care is GPT (zero GUID is ignored).
> 
> True, the type does not matter... so long as it is !0.  Windows will
> consider such an entry unused and happily allow you to create a new
> partition using that space, so we certainly don't want to allow people
> to make such a partition in fdisk, and the kernel really should ignore
> it too.  To do otherwise will lead people to lose data when Windows
> thinks the entry is unused.

 windows bug? :-)

 Seriously, maybe it's fine to ignore the partition with the zero type
 by kernel, but I don't think it's good way for fdisk-like applications.
 
 IMHO it's better to force users to delete the partition than rely on
 the flag. See this thread, user lost data because somehow set the
 type to zero and fdisk reused the space. 
 
 From my point of view all partitions with non-zero size should be 
 visible by fdisk (or parted) independently on flags or types.
    
 I'll probably add a warning to fdisk to inform users about the zero 
 type problem.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
