Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:59831 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753142AbcCQVxB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Mar 2016 17:53:01 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] tests: fix fdisk/bsd for alpha
Date: Thu, 17 Mar 2016 22:52:49 +0100
Cc: util-linux@vger.kernel.org
References: <1458088844-23523-1-git-send-email-sweet_f_a@gmx.de> <201603161627.10907.sweet_f_a@gmx.de> <20160317133341.fwjakpzsdln3oivg@ws.net.home>
In-Reply-To: <20160317133341.fwjakpzsdln3oivg@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201603172252.49517.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 17 March 2016, Karel Zak wrote:
> On Wed, Mar 16, 2016 at 04:27:10PM +0100, Ruediger Meier wrote:
> > And we could disable setarch's uname26 test because
> > # glibc requires kernel >= 3.0, thus setarch --uname-2.6 fails
> > # on platforms without VDSO
>
> OK, added exception for sparc.

I don't fully understand the real problem. See also this Debian package 
comment:
 "Apparently glibc does not support 2.6 personality on some
  architectures when built to require newer kernels (e.g. >= 3.2).
  See https://bugs.debian.org/806911"

Couldn't we tell setarch at build time that uname26 will not work with 
the used glibc?

On openSUSE 13.2,arm7vl and on that debian,sparc machine we see this 
diff:

 Switching on STICKY_TIMEOUTS.
 Switching on ADDR_LIMIT_3GB.
 Switching on UNAME26.
-success
+FATAL: kernel too old

Where does the "FATAL" message come from? Is it printed directly by 
glibc? If yes then we could use it to skip the test. (Allthough the 
kernel is not really too old but probably something is too new or just 
different.)

But on openSUSE 13.2 arm6vl and aarch64 I don't get this last "FATAL" 
message but a segfault instead! Is there something we could do in 
setarch to avoid this segfault? (These arm6vl and aarch64 machines seem 
to run differently as "qemu_user_space_build").

BTW the test works fine on openSUSE 13.1 and 42.1. (newer and older than 
13.2).

cu,
Rudi
