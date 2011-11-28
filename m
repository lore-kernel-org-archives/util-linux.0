Return-Path: util-linux-owner@vger.kernel.org
Received: from nagini.codelibre.net ([80.68.93.164]:46790 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273Ab1K1WwZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 28 Nov 2011 17:52:25 -0500
Date: Mon, 28 Nov 2011 22:52:23 +0000
From: Roger Leigh <rleigh@codelibre.net>
To: util-linux@vger.kernel.org
Subject: Re: Using /etc/fstab.d
Message-ID: <20111128225223.GJ17458@codelibre.net>
References: <20111127221956.GF17458@codelibre.net>
 <20111128091435.GB29168@nb.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111128091435.GB29168@nb.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 28, 2011 at 10:14:35AM +0100, Karel Zak wrote:
> On Sun, Nov 27, 2011 at 10:19:56PM +0000, Roger Leigh wrote:
> > I noticed that support had recently been added for /etc/fstab.d.
> > In Debian, we're configuring with --enable-libmount-mount, but
> > I'm not seeing it being used; strace shows no opendir/stat calls
> > for it.  Is anything else necessary to enable it, or is it not
> > yet actually used by mount?
> 
>  Do you really have the latest git tree (gil pull to refresh)?

I was testing the 2.20.1 release, which I saw had fstab.d
support implemented (at least partially) in libmount.  It does
indeed now work with current git.  Just saw that it was only
enabled last week in mount, looking at the history.  Will it
be long until this is in a release?


Thanks,
Roger

-- 
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux             http://people.debian.org/~rleigh/
 `. `'   Printing on GNU/Linux?       http://gutenprint.sourceforge.net/
   `-    GPG Public Key: 0x25BFB848   Please GPG sign your mail.
