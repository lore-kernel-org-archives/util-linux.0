Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:22268 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755030AbaDGJgP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Apr 2014 05:36:15 -0400
Date: Mon, 7 Apr 2014 11:36:04 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 02/10] kill: fix coding style
Message-ID: <20140407093604.GF22126@x2.net.home>
References: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
 <1394397023-7050-2-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394397023-7050-2-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 09, 2014 at 03:30:15PM -0500, Sami Kerola wrote:
> The kill was deprecated at the time lot of other tools got style
> unification.  Now when deprecation is lifted it is time to get kill
> cleaner.

OK, all applied.
 
I also did some changes to the code and the man page. The most
visible change is that kill(1) now returns 64 (like mount or chcpu)
for partial success when more than one process specified.

  $ kill -s 0 firefox mutt xxx; echo $?
  kill: cannot find process "xxx".
  64

the old version always return "1" in this situation.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
