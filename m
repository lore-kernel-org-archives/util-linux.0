Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751973AbdC0Llk (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 27 Mar 2017 07:41:40 -0400
Date: Mon, 27 Mar 2017 13:41:22 +0200
From: Karel Zak <kzak@redhat.com>
To: Assaf Gordon <assafgordon@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: correct usage of unshare+nsenter for persistent namespaces?
Message-ID: <20170327114122.f5mulpy62jcaq4du@ws.net.home>
References: <20170310175156.GB21783@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170310175156.GB21783@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 10, 2017 at 05:51:57PM +0000, Assaf Gordon wrote:
> IIUC, this is a kernel limitation:
> If the program which is PID1 inside the container
> terminates, there is no way to re-enter the PID namespace
> (http://man7.org/linux/man-pages/man7/pid_namespaces.7.html).
> 
> Is that correct?

Yes, this namespace is strictly based on the within namespace init
process.

> If so, perhaps it would be helpful to add a caveat in the
> unshare/nsenter man pages, saying the PID namespace will
> not persist if the process termintes?

Added.

> There are already some examples of minimal 'init' for containers:
>  https://github.com/Yelp/dumb-init
>  https://github.com/krallin/tini
>  and most minimal: https://gist.github.com/rofl0r/6168719
> 
> I wonder if you will be willing to consider a patch to add
> something like 'unshare --do-nothing-init' which
> will simply create a process that does nothing except handling signals
> and never terminates, to facilitate truly persistent namespaces with
> unshare(1) ? (if so I'm happy to try and write it).

Hmm, when I think about it I'm not able to see any argument against
this feature :-) So go ahead.

Important is keep it simple and stupid and avoid arbitrary additional
features. I think for serious containers people will use another
solutions (systemd etc.).
 
> The working URL seems like 'www.kernel.org' (www. instead of ftp.):
>  https://www.kernel.org/pub/linux/utils/util-linux/

Ah, thanks! (Seems my template is a little bit obsolete. Fixed.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
