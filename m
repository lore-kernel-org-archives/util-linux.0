Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38260 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936Ab3JWP1s (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 23 Oct 2013 11:27:48 -0400
Date: Wed, 23 Oct 2013 17:27:44 +0200
From: Karel Zak <kzak@redhat.com>
To: Aleksey Midenkov <midenok@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Per-filesystem default mount options
Message-ID: <20131023152744.GB21504@x2.net.home>
References: <CAF8BazAW7xxXpO1-vCBJvfvORBLXnJkDxv=qagoe0ZJe-12aJg@mail.gmail.com>
 <CAF8BazDFWf7-NPwCr7Cg=aV9prKsWNUxJu2neZ3x+8XP1fZPHQ@mail.gmail.com>
 <20131018083452.GB15115@x2.net.home>
 <CAF8BazB4jsWj0_3Ns14o5qDF2wVch9_K5u_ZsJ8GwjMyNZb6Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAF8BazB4jsWj0_3Ns14o5qDF2wVch9_K5u_ZsJ8GwjMyNZb6Uw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Oct 19, 2013 at 08:03:29AM +0400, Aleksey Midenkov wrote:
> On Fri, Oct 18, 2013 at 12:34 PM, Karel Zak <kzak@redhat.com> wrote:
> > On Wed, Oct 16, 2013 at 06:13:17PM +0400, Aleksey Midenkov wrote:
> >> Is it possible to specify per-filesystem default mount options
> >> somewhere in configuration file?
> >
> >  /etc/fstab, or tune2fs for extN, or /etc/nsfmount.conf for NFS.
> >
> >  The per-filesystem-type default options are also hardcoded in kernel.
> >
> 
> I'm sorry for my misguide and, perhaps, a wrong start. What I mean is
> per-fs type default mount options. That's true, they are hardcoded in
> kernel. But, there is a need to have them customized. I know, there is
> ton of user-level utils that maybe can provide it. But... I feel that
> this basic feature is important for the core. That's why I decided to
> ask here in hope that you will discuss this with me.

 If you really need a generic (on device independent solution), then I
 don't see a better way than improve libmount for read something 
 like /etc/mount/<fsname>.conf. The problem is that such feature will 
 not be usable for non-libmount applications.

> I keep stumbling upon this lack for a million-th times for as long as
> 15 years. Every barely installed host, f.ex. even routers that have no
> ability to install another utils except the 'mount', they require me
> each time to put charset from command line. And you know, this is the
> common source for errors for non-latin countries like your servant's.

 I understand the pain for removable media, but for regular disks you
 can use /etc/fstab, right?

> When charset option is forgotten the filenames are garbled after copy.
> And you not always notice it because non-latin ones are somewhere deep
> inside. But after some time passed you see the surprise...

 I understand.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
