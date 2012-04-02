Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32001 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819Ab2DBL1r (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Apr 2012 07:27:47 -0400
Date: Mon, 2 Apr 2012 13:27:37 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/3] script: error in usage() output
Message-ID: <20120402112737.GD1084@x2.net.home>
References: <20120330150457.GE23437@x2.net.home>
 <1333304372-25944-1-git-send-email-kerolasa@iki.fi>
 <1333304372-25944-3-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333304372-25944-3-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 01, 2012 at 08:19:31PM +0200, Sami Kerola wrote:
> Error originates to commit 3ff526391fb5c6b33418dc9cfec31c2ff9b4792e
> which is bit more than year, and part or releases v2.20 & v2.21.

Wouldn't be possible to write a tools/checkusage script to check
long_options[] and getopt_long() with usage() ?

>  term-utils/script.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
