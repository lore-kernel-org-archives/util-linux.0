Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:65041 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932076Ab2LRPSZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 18 Dec 2012 10:18:25 -0500
Date: Tue, 18 Dec 2012 16:17:42 +0100
From: Karel Zak <kzak@redhat.com>
To: Werner Fink <werner@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/5] sulogin: mount temporary /dev and /proc if not found
Message-ID: <20121218151742.GC12659@x2.net.home>
References: <1354867258-14206-1-git-send-email-werner@suse.de>
 <1354867258-14206-4-git-send-email-werner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354867258-14206-4-git-send-email-werner@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 07, 2012 at 09:00:57AM +0100, Werner Fink wrote:
>  configure.ac          |   10 ++++++++
>  login-utils/sulogin.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)

 Applied with some minor changes, thanks.

> +AC_ARG_ENABLE([use-emergency-dev],
> +  AS_HELP_STRING([--disable-use-emergency-dev], [do not use emergency mount of /dev and /proc for sulogin]),
> +  [], enable_use_emergency_dev=yes
> +)

 renamed to --disable-sulogin-emergency-mount

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
