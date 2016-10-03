Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751061AbcJCK2e (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 3 Oct 2016 06:28:34 -0400
Date: Mon, 3 Oct 2016 12:28:30 +0200
From: Karel Zak <kzak@redhat.com>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Stanislav Brabec <sbrabec@suse.cz>, util-linux@vger.kernel.org,
        Federico Bento <up201407890@alunos.dcc.fc.up.pt>,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: Fixing su + runuser vulnerability CVE-2016-2779
Message-ID: <20161003102830.mczd6omz6lqftrzy@ws.net.home>
References: <56D7409A.6050407@suse.cz>
 <20160307131358.kzu4qb5yu6u7fd4x@ws.net.home>
 <56DEF7A4.4090209@suse.cz>
 <20160929144015.7cij7pbva3etcqeo@ws.net.home>
 <87vaxaao33.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87vaxaao33.fsf@mid.deneb.enyo.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Oct 02, 2016 at 03:16:00PM +0200, Florian Weimer wrote:
> * Karel Zak:
> 
> > I have applied patch based on libseccomp syscall filter:
> >
> >    https://github.com/karelzak/util-linux/commit/8e4925016875c6a4f2ab4f833ba66f0fc57396a2
> >
> > it works as expected, but IMHO it's workaround for our stupid kernel...
> 
> How does this work?
> 
> Isn't it possible to pass the descriptor to another, unrestricted
> process (perhaps spawned from cron) and then run the ioctl from there?

 Good point, I don't know. The question is how secure is TIOCSTI
 itself, does it work for arbitrary another process which without
 any relation to the original tty processes?

 The ioctl should be fired in the hell... :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
