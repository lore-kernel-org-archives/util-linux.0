Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43139 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753803AbaKYL0S (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 25 Nov 2014 06:26:18 -0500
Date: Tue, 25 Nov 2014 12:26:15 +0100
From: Karel Zak <kzak@redhat.com>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: LUKS partition types, redux
Message-ID: <20141125112615.GC2610@x2.net.home>
References: <546D0495.2030803@dasyatidae.net>
 <20141124113733.GC926@x2.net.home>
 <547343EA.6090606@ubuntu.com>
 <20141124154604.GA2610@x2.net.home>
 <54738D83.9010108@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54738D83.9010108@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 24, 2014 at 01:56:51PM -0600, Bruce Dubbs wrote:
> Karel Zak wrote:
> >On Mon, Nov 24, 2014 at 09:42:50AM -0500, Phillip Susi wrote:
> >>-----BEGIN PGP SIGNED MESSAGE-----
> >>Hash: SHA1
> >>
> >>On 11/24/2014 6:37 AM, Karel Zak wrote:
> >>>The current trend is to use partition type to define for what
> >>>purpose we want to use the partition (for example "this is /home")
> >>>independently on partition format.
> >>
> >>I wouldn't call this bone headed idea of redhat's a trend.  Using
> >>partition table type codes to decide to auto mount in particular parts
> >>of the filesystem is such a brain damaged idea, those who thought it
> >>up need beaten with a clue-by-four and its use needs to be *strongly*
> >>discouraged.
> >
> >  well, it's designed for auto-generated fstab-less systems like
> >  containers/virt images, etc. I'm not big fan of this feature, but for
> >  some use cases it makes sense. (And it's systemd upstream decision.)
> >
> >  Anyway, use partition type for "usage" makes more sense than for "fs-type".
> 
> Since when is systemd upstream of util-linux?

 Ah.. freedesktop guys introduced some new GUID and util-linux project
 has accepted these identifiers (rather than interpret these IDs as
 "unknown") ...  as well as we accepted partition IDs for Apple stuff,
 as well as we accepted Hurd patches, ports to freebsd, uClibc,
 not-perfect zram stuff from kernel, stuff from SysVinit, and many
 many many other things.

 I don't plan to be censor for another projects and apply any
 emotional criteria. The reason why this project still alive is that
 we are very friendly to arbitrary distributions and another projects. 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
