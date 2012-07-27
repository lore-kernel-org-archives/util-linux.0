Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:9190 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344Ab2G0LP4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Jul 2012 07:15:56 -0400
Date: Fri, 27 Jul 2012 13:15:50 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: kerolasa@gmail.com, util-linux@vger.kernel.org
Subject: Re: v2.22-rc2 wish list
Message-ID: <20120727111550.GA29738@x2.net.home>
References: <20120727081033.GA14019@x2.net.home>
 <CAG27Bk1mk08N=0Zbo-Bbd_v93C6cfEcO1chYyiDAtRf1sQOEpw@mail.gmail.com>
 <20120727103132.GA28708@x2.net.home>
 <501271D2.8090708@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <501271D2.8090708@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 27, 2012 at 12:47:46PM +0200, Bernhard Voelker wrote:
> On 07/27/2012 12:31 PM, Karel Zak wrote:
> >  Maybe, but many of the tests requires root permissions and it's
> >  designed for developers only. I'd like to avoid situations when the
> >  tests are executed with root permissions by automatic distro build
> >  systems etc.
> 
> Why? The more folks run the tests, the more bugs can be reported and fixed.
> What's wrong about the tests? And if there's something wrong: shouldn't
> they not be made more robust?
> 
> E.g. coreutils also has many tests which "require_root", and I think
> it's safe to run these tests.

Does the tests modify /etc/fstab, mount another filesystems and
initialize scsi_debug, loop and raid devices?

I have experience that some distros and end-users rebuild packages
as superuser. I don't want to be responsible for possible problems on
the target systems.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
