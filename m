Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751237AbdISLGB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 19 Sep 2017 07:06:01 -0400
Date: Tue, 19 Sep 2017 13:05:56 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] If using wide nscurses, use wide tinfo (tinfow)
Message-ID: <20170919110556.g4chfnwz3wkcoe5o@ws.net.home>
References: <89952e72-6858-5a11-8157-995f75b3774b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <89952e72-6858-5a11-8157-995f75b3774b@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 18, 2017 at 06:10:09PM +0200, Stanislav Brabec wrote:
> util-linux checks for libtinfo, even if libncursesw is used. It can cause
> ugly crashes inside ncurses, e. g. in cfdisk.

Hmm... this i is first time I see this problem. Ah yes, it seems we
need another permutation for the wonderful ncurses world :-)

> To prevent these crashes, never link non-wide libtinfo together with
> libncursesw.
> 
> This change can cause non-detection of tinfo on some systems with
> ncursesw but without tinfow. It would be easy to fix, but I am not sure
> whether to check for a combination that can cause crash.

Unfortunately on Fedora we have two ncurses libs (wide/nonwide), but
only one tinfo lib. So, the patch without fallback to tinfo is
useless.

I've committed a little different solution. I've added UL_TINFO_CHECK()
and call it from configure with "tinfow" and fallback to "tinfo" if
not found the widechar version or for non-widechar ncurses.

Please, test it for your environment. I'd like to release -rc1 ASAP.
Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
