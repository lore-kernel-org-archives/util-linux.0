Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59205 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753007AbbCIUNC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 9 Mar 2015 16:13:02 -0400
Date: Mon, 9 Mar 2015 21:12:59 +0100
From: Karel Zak <kzak@redhat.com>
To: Sitsofe Wheeler <sitsofe@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: agetty --reload
Message-ID: <20150309201259.GC26473@ws.net.home>
References: <CALjAwxjTo=krFxHht2029Sh-h3maEvGK1Xa0fXUOScsamG_=Eg@mail.gmail.com>
 <20150309115259.GB26473@ws.net.home>
 <CALjAwxhefTrWEcxo+P4X98N5W12y2U5Jycj=1sjHju4WsA8ORA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALjAwxhefTrWEcxo+P4X98N5W12y2U5Jycj=1sjHju4WsA8ORA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 09, 2015 at 02:38:23PM +0000, Sitsofe Wheeler wrote:
> On 9 March 2015 at 11:52, Karel Zak <kzak@redhat.com> wrote:
> > On Sun, Mar 08, 2015 at 09:02:11PM +0000, Sitsofe Wheeler wrote:
> >> The main issue seems to be that /etc/issue isn't reparsed when agetty
> >> --reload is done unless /run/agetty.reload exists before the original
> >> agetty is started. Is this the intended behaviour?
> >
> > No, this is a bug, fixed by commit c9f5ec0faa2b2d9cf7fc162baf99499457b8b909.
> >
> >> The second issue occurs when --autologin and --login-pause are being
> >> used and a reload happens even when the above is done. Since the login
> >> program hasn't actually been started (as we are waiting for the user
> >> to press enter) I expected the reload to cause agetty to reload
> >> /etc/issue and start waiting again but this does not currently happen.
> >> Is this also intentional?
> >
> > Well, it wasn't implemented, improved by commit c2ef308bbfdc9fb9a0053e258828f5bd6fbb0c5d.
> >
> > The changes will be in v2.26.1.
> 
> Phew, that was fast! I've found with your patches the first issue is
> fixed but when waiting at the [press ENTER to login] prompt agetty
> --reload still has no effect...

 It works for me.

 # grep autologin /etc/systemd/system/getty@.service 
 ExecStart=-/sbin/agetty --autologin kzak --login-pause --noclear %I $TERM

 # echo "Hello world!" >> /etc/issue
 # agetty --reload

 .. then I see the "Hello..." line before [press ENTER to login].

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
