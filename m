Return-Path: worley@ariadne.com
Date: Thu, 8 May 2014 17:01:10 -0400
Message-Id: <201405082101.s48L1AYa030864@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
Sender: worley@alum.mit.edu (Dale R. Worley)
To: Andy Lutomirski <luto@amacapital.net>
CC: util-linux@vger.kernel.org, kzak@redhat.com
In-reply-to: 
	<CALCETrUBTf=Wyz76Y3T=2CXqtKNhgK1YVgmBv1mEh85mNt4MKA@mail.gmail.com>
	(luto@amacapital.net)
Subject: Re: getting rid of "mount: only root can ..."
References: <CALCETrUbaFwpdiLBv7G8GbkgUuiEgyyBWn0dr8R57NzCdSL9gg@mail.gmail.com>
	<201405022221.s42MLpT4015462@hobgoblin.ariadne.com>
	<CALCETrUU6ziKYA3RSb_6nEW4HyeR5BLGQ_3SgcnnnLnBX1us0g@mail.gmail.com>
	<201405052250.s45Monxm008110@hobgoblin.ariadne.com>
	<CALCETrXTJpkA-EqzS=kvSfS4QEO5Gc3TV42+FFrUbQN3ALfuCw@mail.gmail.com>
	<20140506094631.GG5962@x2.net.home>
	<201405061350.s46DoVxC008646@hobgoblin.ariadne.com> <CALCETrUBTf=Wyz76Y3T=2CXqtKNhgK1YVgmBv1mEh85mNt4MKA@mail.gmail.com>
List-ID: <util-linux.vger.kernel.org>

> From: Andy Lutomirski <luto@amacapital.net>
> 
> A kind of hackish solution would be for mount --nopriv or whatever to drop
> privileges immediately and stop enforcing any policy at all.

Given what Karel has said, I'm not sure that would give the correct
behavior:

    The problem is that mount(8) is not just about mount(2) call only. If
    we drop privileges then mount(8) will report problems with things like
    FS detection, loopdevs setups, etc. It's necessary to review the code
    and make errors/warnings somehow usable.

Dale
