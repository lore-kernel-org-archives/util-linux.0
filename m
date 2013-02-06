Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40094 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341Ab3BFKxK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Feb 2013 05:53:10 -0500
Date: Wed, 6 Feb 2013 11:53:00 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/3] translation: unify exec error messages
Message-ID: <20130206105300.GB24476@x2.net.home>
References: <1359578005-13427-1-git-send-email-kerolasa@iki.fi>
 <1359578005-13427-2-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359578005-13427-2-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 30, 2013 at 08:33:24PM +0000, Sami Kerola wrote:
>  login-utils/newgrp.c    | 2 +-
>  login-utils/su-common.c | 4 ++--
>  login-utils/sulogin.c   | 4 ++--
>  schedutils/chrt.c       | 1 -
>  schedutils/ionice.c     | 2 +-
>  schedutils/taskset.c    | 2 +-
>  sys-utils/flock.c       | 2 +-
>  sys-utils/nsenter.c     | 2 +-
>  sys-utils/prlimit.c     | 2 +-
>  sys-utils/rtcwake.c     | 2 +-
>  sys-utils/setarch.c     | 4 ++--
>  sys-utils/setsid.c      | 2 +-
>  sys-utils/swapon.c      | 2 +-
>  sys-utils/unshare.c     | 2 +-
>  text-utils/pg.c         | 2 +-

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
