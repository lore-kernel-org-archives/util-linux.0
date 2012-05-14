Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1339 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755235Ab2ENJmd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 May 2012 05:42:33 -0400
Date: Mon, 14 May 2012 11:42:08 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/2] lib/tt: make get_terminal_width available externally
Message-ID: <20120514094208.GB16926@x2.net.home>
References: <1336981918-18123-1-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336981918-18123-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, May 14, 2012 at 09:51:57AM +0200, Petr Uzel wrote:
> Also, rename get_terminal_width() to tt_get_terminal_width()
> to match naming convention of other exported functions.

 That's overkill to compile whole tt.c (for example for blkid) for
 this one simple function.  What about to add get_terminal_width() to
 include/ttyutils.h as a static function?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
