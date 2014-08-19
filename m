Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49187 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753AbaHSJHo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Aug 2014 05:07:44 -0400
Date: Tue, 19 Aug 2014 11:07:37 +0200
From: Karel Zak <kzak@redhat.com>
To: Steven Stewart-Gallus <sstewartgallus00@mylangara.bc.ca>
Cc: Mike Frysinger <vapier@gentoo.org>, util-linux@vger.kernel.org
Subject: Re: Utilities don't take into account capabilities
Message-ID: <20140819090737.GA22187@x2.net.home>
References: <fbcec6cf5352.53efd3e4@langara.bc.ca>
 <3715739.62j44Bg1Aj@vapier>
 <fb47b4bfaf39.53f23a83@langara.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fb47b4bfaf39.53f23a83@langara.bc.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 18, 2014 at 05:40:19PM +0000, Steven Stewart-Gallus wrote:
> > guessing the sandbox isn't really meant for security purposes since 
> > CAP_SYS_ADMIN can easily be used to recover just about every other 
> > capability.	http://lwn.net/Articles/486306/

 The currently supported scenario is that you can remove suid from
 mount(8) and replace it with cap_dac_override,cap_sys_admin+ep. Note
 that in this case mount(8) still requires 'user' in fstab of course.
 
 The disadvantage is that mount(8) is not able to update for example
 /etc/mtab (or /run/mount/utab), because cap_sys_admin is just subset
 of the original suid privileges.
 
> capabilities in a CLONE_NEW_USER sandbox only apply to the sandbox and not
> things outside of the sandbox such as devices.

 Well, user namespace is little bit different story and we already
 talked about it (in May).
 
   http://www.spinics.net/lists/util-linux-ng/msg09309.html
 
 The idea is that we can drop privileges rather than exit with "only
 root can..." error message. I'd like to try it during this release
 cycle.

    Karel



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
