Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:16803 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753924AbaIVMsw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Sep 2014 08:48:52 -0400
Date: Mon, 22 Sep 2014 14:48:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/6] pull: renice changes
Message-ID: <20140922124838.GJ5366@x2.net.home>
References: <1410002693-16540-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410002693-16540-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Sep 06, 2014 at 12:24:47PM +0100, Sami Kerola wrote:
> Sami Kerola (6):
>   renice: reorder functions to avoid need of function prototype
>   rename: use usage and version print out macros
>   renice: disallow --priority <arg> without pid argument
>   renice: avoid having same lines of code twice
>   renice: fix numeric uid argument parsing
>   rename: add getpriority() message lookup table

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
