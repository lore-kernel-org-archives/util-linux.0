Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40886 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbcHPKKA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 16 Aug 2016 06:10:00 -0400
Date: Tue, 16 Aug 2016 12:09:56 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] misc: always check setenv(3) return value
Message-ID: <20160816100956.hnz4icwcwvowfol5@ws.net.home>
References: <20160814072406.2991-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160814072406.2991-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Aug 14, 2016 at 08:24:04AM +0100, Sami Kerola wrote:
>  include/env.h           |  2 +-
>  lib/pager.c             |  3 ++-
>  login-utils/login.c     | 19 +++++++++++--------
>  login-utils/su-common.c |  2 +-
>  login-utils/sulogin.c   | 21 +++++++++++----------
>  sys-utils/hwclock.c     |  5 +++--
>  sys-utils/rtcwake.c     |  3 ++-
>  term-utils/agetty.c     |  4 +++-
>  8 files changed, 34 insertions(+), 25 deletions(-)

 All "misc" branch merged. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
