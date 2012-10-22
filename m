Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:22758 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793Ab2JVJHR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Oct 2012 05:07:17 -0400
Date: Mon, 22 Oct 2012 11:07:06 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/19] compliancy fixes
Message-ID: <20121022090706.GC21724@x2.net.home>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Oct 14, 2012 at 09:20:51PM +0100, Sami Kerola wrote:
>      1  last: stop using MAXHOSTNAMELEN
>      2  login: stop using MAXHOSTNAMELEN
>      3  write: stop using MAXHOSTNAMELEN
>      4  agetty: stop using MAXHOSTNAMELEN
>      5  c.h: remove unnecessary MAXHOSTNAMELEN fallback definition

Applied, I did some changes to the code:

    - get_hostname_max() moved to c.h
    - added xgethostname() to xalloc.h to avoid duplicate code.

>      6  docs: add line breaks to whereis.1

>      7  sd-daemon: fix cppcheck warnings

ignored

>      8  libmount: replace usleep with nanosleep
>      9  include/all-io: replace usleep with nanosleep
>     10  hwclock: replace usleep with nanosleep
>     11  rtcwake: replace usleep with nanosleep
>     12  agetty: replace usleep with nanosleep
>     13  tailf: replace usleep with nanosleep
>     14  include/usleep: remove remaining references to usleep

 it seems unnecessary as we already have a fallback solution for
 systems without usleep()

 I have moved the fallbcack from include/usleep.h to include/c.h.

>     15  libmount, eject: replace index() and rindex() with strrch() or strrchr()
>     16  logger: replace gethostbyname() with getaddrinfo()
>     17  agetty: replace gethostbyname() with getaddrinfo()
>     18  build-sys: remove gethostbyname() check

 applied

>     19  fsck.cramfs: replace utime() with utimensat()

 I have add fsck.cramfs to check_PROGRAMS.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
