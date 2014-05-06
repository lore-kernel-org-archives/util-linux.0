Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38157 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934608AbaEFJqh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 6 May 2014 05:46:37 -0400
Date: Tue, 6 May 2014 11:46:31 +0200
From: Karel Zak <kzak@redhat.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: "Dale R. Worley" <worley@alum.mit.edu>, util-linux@vger.kernel.org
Subject: Re: getting rid of "mount: only root can ..."
Message-ID: <20140506094631.GG5962@x2.net.home>
References: <CALCETrUbaFwpdiLBv7G8GbkgUuiEgyyBWn0dr8R57NzCdSL9gg@mail.gmail.com>
 <201405022221.s42MLpT4015462@hobgoblin.ariadne.com>
 <CALCETrUU6ziKYA3RSb_6nEW4HyeR5BLGQ_3SgcnnnLnBX1us0g@mail.gmail.com>
 <201405052250.s45Monxm008110@hobgoblin.ariadne.com>
 <CALCETrXTJpkA-EqzS=kvSfS4QEO5Gc3TV42+FFrUbQN3ALfuCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALCETrXTJpkA-EqzS=kvSfS4QEO5Gc3TV42+FFrUbQN3ALfuCw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, May 05, 2014 at 03:58:50PM -0700, Andy Lutomirski wrote:
> On Mon, May 5, 2014 at 3:50 PM, Dale R. Worley <worley@alum.mit.edu> wrote:
> >> From: Andy Lutomirski <luto@amacapital.net>
> >
> >> What if mount determined that the requested option wasn't allowed by
> >> fstab and instead fell back to dropping privileges and trying anyway?
> >
> > I'm not envisioning the problem that you're addressing very well.
> 
> If I set up a user namespace in which non-root users can call mount
> (the system call), it's annoying to work with because mount (the
> util-linux program) just assumes that uid != 0 means that mount won't
> work.
> 
> The issue here is that there are two conflicting sets of policy: the
> in-kernel policy of who may mount/umount and the userspace policy of
> who may use the setuid mount tool to mount as euid == 0 despite their
> actual (kernel) privileges.

Andy is right, mount(8) is very paranoid when executed by non-root
users (sure, because it's suid almost everywhere).

I'll try to improve it to make it more usable with user namespaces.
The problem is that mount(8) is not just about mount(2) call only. If
we drop privileges then mount(8) will report problems with things like
FS detection, loopdevs setups, etc. It's necessary to review the code
and make errors/warnings somehow usable. ... added to my TODO for the
next week ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
