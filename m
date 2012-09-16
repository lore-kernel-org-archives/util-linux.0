Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ie0-f174.google.com ([209.85.223.174]:59364 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab2IPUth (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Sep 2012 16:49:37 -0400
Received: by ieje11 with SMTP id e11so8638555iej.19
        for <util-linux@vger.kernel.org>; Sun, 16 Sep 2012 13:49:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201209161644.36467.vapier@gentoo.org>
References: <k2amjt$fh0$1@ger.gmane.org> <201209161644.36467.vapier@gentoo.org>
From: Christer Solskogen <christer.solskogen@gmail.com>
Date: Sun, 16 Sep 2012 22:49:16 +0200
Message-ID: <CAMVU60ZL66er3xZejjBNSSvLsQ1w2sbxor=QTdgWcFmGaP31+w@mail.gmail.com>
Subject: Re: cross compiling util-linux
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Sep 16, 2012 at 10:44 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Thursday 06 September 2012 13:30:36 Christer Solskogen wrote:
>> libtool: link: cannot find the library `/lib64/libpam.la' or unhandled
>> argument `/lib64/libpam.la'
>
> not a bug in util-linux.  libtool linker scripts do not play well with cross-
> compiling.  you can remove them, hack them, or hack up the local libtool.
>

I disagree. GMP, MPFR, MPC, ISL and CLooG also deal with that kind of
problems with libtool. But --with-sysroot solves it.
CLooG did had a problem, but when I recreated the configure script
with a new versions of libtool, automake and autoconf the problem was
solved.


-- 
chs,
