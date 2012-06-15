Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38525 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753394Ab2FOJk4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 15 Jun 2012 05:40:56 -0400
Date: Fri, 15 Jun 2012 11:40:51 +0200
From: Karel Zak <kzak@redhat.com>
To: Ludwig Nussel <ludwig.nussel@suse.de>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: remove encryption options from mount and losetup?
Message-ID: <20120615094051.GC16531@x2.net.home>
References: <4FD8A950.5000906@suse.de>
 <20120613150144.GE10561@x2.net.home>
 <4FD9CF44.8090800@suse.de>
 <20120615084753.GA2566@x2.net.home>
 <4FDAFCD4.7010205@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FDAFCD4.7010205@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jun 15, 2012 at 11:13:56AM +0200, Ludwig Nussel wrote:
> Karel Zak wrote:
> > On Thu, Jun 14, 2012 at 01:47:16PM +0200, Ludwig Nussel wrote:
> >> Karel Zak wrote:
> >>> On Wed, Jun 13, 2012 at 04:53:04PM +0200, Ludwig Nussel wrote:
> >>>> Is there any reason to still keep the encryption options in losetup and
> >>>> mount around? They look entirely useless to me. Even when using passfd
> >>>> and an external key generation function it's still broken as the key
> >>>> size is fixed at 32 byte and the last byte is always set to '\0'.
> >>>> So would a patch that removes encryption support completely be
> >>>> acceptable?
> >>>
> >>> Our goal is to follow kernel, so it would be better to remove this
> >>> feature from kernel loopdev first.
> >>
> >> Well, someone could come up with another tool to support cryptoloop, or
> >> rather 'transfer functions'.
> >> If losetup has the philosophy to provide the canonical implementation
> >> for all loop features then losetup isn't complete anyways. It needs
> > 
> >  I don't know what was original idea, but the current '--encryption'
> >  works somehow. Yes, it's not perfect, it's maybe almost useless,
> >  but it's still have some users and we cannot remove it without a
> >  prior warning.
> > 
> >  Fortunately, cryptoloop is in our deprecated.txt for years, so I think
> >  it's should be enough to add a fat warning to the next v2.22 release
> >  and remove this feature in v2.23.
> 
> From a distribution PoV it doesn't really matter. I just need to know
> the direction :-)

 Just remove the encryption, that's the direction ;-) I'll do that for
 RHEL7, Fedora 18 and v2.23 upstream.

> I'm currently struggling between porting our old patch
> that adds password hashing to losetup once again or to remove encryption
> support from losetup completely. I think we cannot ship 12.2 with the
> current upstream state as that would add a third and even more broken
> way than what we had before.
> 
> >  Anyway, I like Milan's idea with libcryptsetup, and we will try to
> >  prepare any solution. BTW, the current cryptsetup also support loop-aes ;-)
> 
> Sure but setting up the block device is probably not what mount
> should do.

 I have talked about it with Milan on IRC, it will be better to kill
 cryptoloop at all without any extra workaround. It seems that
 arbitrary workaround will drag out the agony of cryptoloop.

 The current cryptsetup is able to work with loop devices so it should
 be enough (I guess).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
