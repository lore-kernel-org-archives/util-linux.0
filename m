Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55826 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932085Ab2B1Ofn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 28 Feb 2012 09:35:43 -0500
Date: Tue, 28 Feb 2012 15:35:37 +0100
From: Karel Zak <kzak@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] Add uuid to the linker flags if using built LIBBLKID
Message-ID: <20120228143537.GD22034@x2.net.home>
References: <1330103768-32139-1-git-send-email-bigeasy@linutronix.de>
 <1330103768-32139-2-git-send-email-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330103768-32139-2-git-send-email-bigeasy@linutronix.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 24, 2012 at 06:16:08PM +0100, Sebastian Andrzej Siewior wrote:
> |ld: warning: libuuid.so.1, needed by ../libblkid/src/.libs/libblkid.so, not found (try using -rpath or -rpath-link)
> |../libblkid/src/.libs/libblkid.so: undefined reference to `uuid_unparse@UUID_1.0'
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  config/include-Makefile.am |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/config/include-Makefile.am b/config/include-Makefile.am
> index 29760d4..895d4bc 100644
> --- a/config/include-Makefile.am
> +++ b/config/include-Makefile.am
> @@ -31,6 +31,9 @@ ul_libuuid_la = $(top_builddir)/libuuid/src/libuuid.la
>  $(ul_libuuid_la):
>  	$(MAKE) -C $(ul_libuuid_builddir)
>  
> +if BUILD_LIBBLKID

 I guess you mean "if BUILD_LIBUUID".

> + ul_libblkid_la += $(ul_libuuid_la)
> +endif

 Hmm... I don't like this, it creates explicit dependence, libtool
 should be smart enough to maintain dependencies dynamically.

 We have libuuid.la in libblkid_la_LIBADD (see in libblkid/src/Makefile.am) and
 on my system it generates the final libblkid.la with

   # Libraries that this one depends upon.
   dependency_libs='/home/projects/util-linux/util-linux/libuuid/src/libuuid.la'


 It would be nice to know more details about your environment to
 reproduce this problem. If I will be able to reproduce the problem
 then I can also add regression test (for cross compiling).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
