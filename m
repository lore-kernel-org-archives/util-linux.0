Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:15979 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756580Ab1GMReg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Jul 2011 13:34:36 -0400
Date: Wed, 13 Jul 2011 19:34:30 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: dave@gnu.org, util-linux@vger.kernel.org
Subject: Re: [PATCH] minix: v3 super-block does not have s_state field
Message-ID: <20110713173430.GD3486@nb.net.home>
References: <1310485846-3685-1-git-send-email-kerolasa@iki.fi> <1310529931.4444.7.camel@offbook> <CAG27Bk0vW2LZySAf8B38OBbVaXpSDP81C+wVuA1vSW1rwhgwgg@mail.gmail.com> <20110713121232.GC3486@nb.net.home> <CAG27Bk2m+d=N9yVTSbByzhfkMUmP-d7heQXS643uWE3n+05+Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAG27Bk2m+d=N9yVTSbByzhfkMUmP-d7heQXS643uWE3n+05+Mw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 13, 2011 at 04:54:22PM +0200, Sami Kerola wrote:
> On Wed, Jul 13, 2011 at 14:12, Karel Zak <kzak@redhat.com> wrote:
> > On Wed, Jul 13, 2011 at 01:33:03PM +0200, Sami Kerola wrote:
> >> On Wed, Jul 13, 2011 at 06:05, Davidlohr Bueso <dave@gnu.org> wrote:
> >> > I don't think we should always rely on having the kernel headers, that's
> >> > why the fallback is provided.
> >> [snip]
> >> > I think with this patch we address the issue without removing our
> >> > fallback.
> >>
> >> The preprocessor directive bellow is problematic. I don't see where,
> >> or how, it might get satisfied so I am afraid the 'fall back' is
> >> always in use regardless whether an user has kernel headers or not.
> >>
> >> #ifdef KERNEL_INCLUDES_ARE_CLEAN
> >>
> >> To fix that I modified the patch to use autoconf to check whether each
> >> necessary header is present, and use them if possible. Notice that
> >> Dave that I wrote your name to Reviewed-by patch line so it would be
> >> nice to hear that you're OK with the change. See the attachment, or
> >> pull from my repository.
> >
> >  This is wrong way... the kernel types (e.g. u32, s64) are
> >  *unexpected* in util-linux. The new code should not use this junk. We
> >  have <stdint.h> and <inttypes.h>.
> 
> Fixed.
> 
> >  The mkfs.minix should not depend on kernel headers. It's normal that
> >  we use our own (on kernel independent) copy of FS superbloks. See
> >  libblkid code.
> 
> By depend do you mean;
> 
> 1. Distrust that kernel headers are present, and have alternative
> copy, but use them when they are present.
> 2. Use always util-linux copy of structures ignoring the possible
> header even they might be present.

 Ignore kernel, 2. is right in this case.

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
