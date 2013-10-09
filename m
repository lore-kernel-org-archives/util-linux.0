Return-Path: util-linux-owner@vger.kernel.org
Received: from awesome.dsw2k3.info ([217.188.63.246]:37030 "EHLO
	awesome.dsw2k3.info" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751611Ab3JIKXa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Oct 2013 06:23:30 -0400
Date: Wed, 9 Oct 2013 12:16:15 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Karel Zak <kzak@redhat.com>
Cc: butter@breezl.com, util-linux@vger.kernel.org,
        Phillip Susi <psusi@ubuntu.com>
Subject: Re: losetup -d does not move partition devices
Message-ID: <20131009101615.GA31760@citd.de>
References: <5241BC33.8050700@breezl.com>
 <20131007113852.GF14360@x2.net.home>
 <525493CA.40207@breezl.com>
 <20131009075305.GG13559@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131009075305.GG13559@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 09.10.2013 09:53, Karel Zak wrote:
> On Wed, Oct 09, 2013 at 01:22:50AM +0200, butter@breezl.com wrote:
> > Anyway, one last minor comment: 
> > 
> > Ubuntu 13.04 64bit does not yet support option -P for losetup. So
> > this must be an older version of util-linux. But then: how do I
> > determine the version of util-linux installed? The binaries have
> > no --version option and 'strings /sbin/losetup | egrep '[0-9]' does
> > not reveal anything useful either. Maybe there is a general version
> > for util-linux available in another binary? The man page does not
> > tell. I failed to identify the version number!
> 
>  The option --version for losetup is supported since v2.21.

As Debian (even SID/unstable) only has an ancient version of util-linux 
i'm not surprised.

$ dpkg -l | grep util-linux
ii  util-linux                              2.20.1-5.5                          i386         Miscellaneous system utilities

$ losetup --version
losetup: unrecognized option '--version'
...


If Ubuntu doesn't roll it's own util-linux, there is the explantion.



-- 

Matthias
