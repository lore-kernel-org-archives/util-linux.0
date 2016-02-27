Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:57045 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389AbcB0TkO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 27 Feb 2016 14:40:14 -0500
From: =?utf-8?q?R=C3=BCdiger_Meier?= <sweet_f_a@gmx.de>
To: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Subject: Re: [PATCH] Proper fallback for systems that lacks O_CLOEXEC (was: [PATCH 12/14] lib: provide mkostemp fallback function)
Date: Sat, 27 Feb 2016 20:40:09 +0100
Cc: util-linux@vger.kernel.org
References: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de> <m337sfocs8.fsf@gmail.com> <m3y4a7msnj.fsf_-_@gmail.com>
In-Reply-To: <m3y4a7msnj.fsf_-_@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201602272040.09740.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Friday 26 February 2016 15:51:28 Yuriy M. Kaminskiy wrote:
> yumkam@gmail.com (Yuriy M. Kaminskiy)
>
> writes:
> > Ruediger Meier <sweet_f_a@gmx.de> writes:
> >> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>
> [...]
>
> > `O_CREAT`, etc; most notable, `O_CLOEXEC`; however, if `O_CLOEXEC` is
> > missing on system, "c.h" defines it as 0, so it is silently ignored on
> > those systems, instead of being emulated; so, whenever it matters,
> > callers must call **both** `open(O_CLOEXEC)` and
> > `fcntl(F_SETFD,FD_CLOEXEC)`]).
>
> ... something like attached below. In some cases it is maybe
> unnecessary, but better safe than sorry.

I'm not sure whether we should add all these fcntl lines just for a few old 
non-Linux systems. That's probably why Karel simply added quick and dirty 
this unsafe fallback defining O_CLOEXEC to 0.

We are using this fallback already since 2011 and and now 2016 we have even 
less systems where O_CLOEXEC is not available. BTW we are using mkostemp 
(which is a real showstopper for the build!) since 3 years and nobody 
complained. I assume any system with mkostemp will also have O_CLOEXEC.

I'm going to add another hopefully correct patch for case mkostemp only.

cu,
Rudi
