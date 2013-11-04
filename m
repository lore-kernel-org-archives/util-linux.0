Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:27483 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753174Ab3KDOcG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 4 Nov 2013 09:32:06 -0500
Date: Mon, 4 Nov 2013 15:32:03 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: /proc/mounts doesn't store bind flag
Message-ID: <20131104143203.GE21311@x2.net.home>
References: <5273DCB6.4020909@ubuntu.com>
 <20131104102932.GF23604@x2.net.home>
 <5277A8EC.30809@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5277A8EC.30809@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 04, 2013 at 09:02:20AM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> That is pretty much what I thought, but why is the bind flag stored
> when you do use mtab then?  Shouldn't they give the same behavior, so

 Historical reasons... 10 years ago nobody cares about the 
 sense of the flag in the mtab ;-(
 
 And it's also difficult for userspace to generate the right mount
 source device if a directory is specified. 

 I'm not sure if I want to change the mtab behavior if for example
 old coreutils df(1) or some backup tools depend on this odd behavior. 
 
 It seems better to keep it without a change and provide a better
 solution only for new systems without mtab.

> bind should not be stored in mtab?  In particular it changes the way
> you have to remount a bind mount ro, which is an unexpected user
> visible change.

 Yes. The update to systems without mtab has some disadvantages, but
 it's still acceptable compare to mtab disadvantages.

 Fedora did the change years (2?) ago and the number of the bug
 reports related to this problem is almost zero. The question is what
 will happen on server (e.g. RHEL), we will see :-)

    Karel
 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
