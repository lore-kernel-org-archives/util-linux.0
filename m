Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56656 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754349AbcAZKyk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 26 Jan 2016 05:54:40 -0500
Date: Tue, 26 Jan 2016 11:54:38 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] build-sys: remove libtermcap support
Message-ID: <20160126105438.7du3y4ivyxmtfkhb@ws.net.home>
References: <1452986584-14013-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452986584-14013-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jan 16, 2016 at 11:23:04PM +0000, Sami Kerola wrote:
>  configure.ac             |  11 -----
>  misc-utils/Makemodule.am |   3 --
>  misc-utils/cal.c         |  59 +++++--------------------
>  text-utils/Makemodule.am |   4 --
>  text-utils/more.c        | 110 ++++++++++-------------------------------------
>  5 files changed, 34 insertions(+), 153 deletions(-)

Good catch. I have removed my_*() functions from more.c too. It's
unnecessary any more.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
