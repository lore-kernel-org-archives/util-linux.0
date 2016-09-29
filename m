Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934518AbcI2OkR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 29 Sep 2016 10:40:17 -0400
Date: Thu, 29 Sep 2016 16:40:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org,
        Federico Bento <up201407890@alunos.dcc.fc.up.pt>,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: Fixing su + runuser vulnerability CVE-2016-2779
Message-ID: <20160929144015.7cij7pbva3etcqeo@ws.net.home>
References: <56D7409A.6050407@suse.cz>
 <20160307131358.kzu4qb5yu6u7fd4x@ws.net.home>
 <56DEF7A4.4090209@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56DEF7A4.4090209@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 08, 2016 at 05:02:44PM +0100, Stanislav Brabec wrote:
> On Mar 7, 2016 at 14:13 Karel Zak wrote:
> > On Wed, Mar 02, 2016 at 08:35:54PM +0100, Stanislav Brabec wrote:
> > > There are some controversial things with the straightforward fix:
> > > 
> > > setsid() prevents TIOCSTI attack described in the report (easy to
> > > reproduce), but it has side effects: It disconnects the task from job
> > > control. With setsid(), ^Z cannot be used for sending the application
> > > to background any more (easy to reproduce by calling setsid()
> > > unconditionally in the same place).
> > > 
> > > su-common.c now calls setsid() only if new session is requested.
> > 
> > Yes, it's pretty stupid situation.
> > 
> > We have exactly specified setsid() use-cases and now TIOCSTI ioctl
> > forces us to modify the things (and maybe introduce regressions),
> > because the crazy ioctl is not possible to disable by any another
> > way...
> 
> I would like to see a kernel support for selective disabling of TIOCSTI
> without side effects like setsid() has.
> 
> setsid() fallback would be used for kernels that don't support it.
> 
> I am not sure, how complicated would be adding of such feature to the
> kernel.

I have applied patch based on libseccomp syscall filter:

   https://github.com/karelzak/util-linux/commit/8e4925016875c6a4f2ab4f833ba66f0fc57396a2

it works as expected, but IMHO it's workaround for our stupid kernel...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
