Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:6369 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752673Ab2CLO4h (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 Mar 2012 10:56:37 -0400
Date: Mon, 12 Mar 2012 15:20:43 +0100
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <d@falconindy.com>
Cc: util-linux@vger.kernel.org, Dave Reisner <dreisner@archlinux.org>,
        "Dr. Werner Fink" <werner@suse.de>, sysvinit-devel@nongnu.org
Subject: sulogin merged into util-linux (Re: [PATCH 00/13] Initial import of
 sulogin)
Message-ID: <20120312142043.GA27749@x2.net.home>
References: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 CC: to sysvinit upstream and Werner -- guys, sulogin has been merged
 into util-linux, because we believe that sulogin(8) is init independent
 util and it also seems that we can share some virtual console
 initialization code with agetty.

 It would be nice to mark sulogin in sysvinit as deprecated in favour of
 the util-linux version :-)

On Tue, Feb 28, 2012 at 11:45:08AM -0500, Dave Reisner wrote:
> This is an initial stab at importing sulogin from sysvinit and making it a bit
> more universal. I've removed the distro specific code and brought the rest of
> it more in line with the style of the remainder of the repo. I've also added
> internationalization and cleaned up the manpage.

Merged with some changes:

 - use err.h stuff
 - add long options
 - initialize NLS
 - add --disable-sulogin (enabled by default)
 - use virtual console initialization code from agetty (that's the
   same code used by Suse in the original sulogin in sysvinit).

Thanks!

    Karel

> Dave Reisner (13):
>   fstab.5: fix misspelling of deprecated
>   sulogin: initial import from sysvinit
>   sulogin.8: refactor manpage
>   sulogin: whitespace fixes
>   sulogin: replace older signal() with sigaction()
>   sulogin: remove CHECK_{DES,MD5} defines
>   sulogin: remove USE_ONELINE and SANE_TIO defines
>   sulogin: use size_t for iterator to avoid cast
>   sulogin: get rid of calls to /bin/sash
>   sulogin: use pathnames.h for file locations
>   sulogin: header/include cleanup
>   sulogin: use a more standard usage output
>   sulogin: add i18n strings

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
