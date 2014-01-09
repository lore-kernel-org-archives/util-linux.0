Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:17246 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753762AbaAIQVW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 9 Jan 2014 11:21:22 -0500
Date: Thu, 9 Jan 2014 17:21:18 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: mount: "nofail" and already mounted devices?
Message-ID: <20140109162118.GE7516@x2.net.home>
References: <1389203741.8841.31.camel@oct.suse.cz>
 <20140109100254.GD7516@x2.net.home>
 <1389282714.8841.109.camel@oct.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389282714.8841.109.camel@oct.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 09, 2014 at 04:51:54PM +0100, Stanislav Brabec wrote:
> Karel Zak wrote:
> The new behavior could simplify common situation and also prevent a
> race:
> if the device is not yet mounted
>    mount it
> do the work

It would be enough to add extra return code for EBUSY (which is
probably a good idea for all scenarios).

> > > - Make possible to use "-a" with further arguments.
> > 
> >   mount -a /foo /bar [...]
> > 
> > Right? 
> 
> Well, it sounds interesting as well, but I was thinking about
> (conflicting):
> mount -a /dev/device /mountpoint

 It's new feature, so we can be pretty strict about it

   mount -a [<mountpoint> ..]

 and do not support "mount -a <source> <target>". If you need
 something more advanced then you have to compose a script.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
