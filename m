Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752584AbeDJNLq (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 10 Apr 2018 09:11:46 -0400
Date: Tue, 10 Apr 2018 15:11:42 +0200
From: Karel Zak <kzak@redhat.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] cfdisk: fix missing prototype for `get_wch`
Message-ID: <20180410131142.jiqgjcuf6mtmuu2d@ws.net.home>
References: <b96441d34412526f7d55da793c6bb2dd05f152c2.1523363782.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b96441d34412526f7d55da793c6bb2dd05f152c2.1523363782.git.ps@pks.im>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 10, 2018 at 01:36:31PM +0100, Patrick Steinhardt wrote:
> The header <ncursesw/ncurses.h> defines the get_wch(3) function only
> when `NCURSES_WIDECHAR` is defined. This define is actually getting set

Oh, ncurses saga continues...  why someone has to define NCURSES_WIDECHAR 
when use ncursesw/ (wide-char!) directory ?

> in the same header file, but only in case `_XOPEN_SOURCE` is defined and
> has a value of 500 or higher. As we already have the precedence of
> defining `_XOPEN_SOURCE` to a value of 600 in some other files, simply
> define it to the minimum required value of 500 in "cfdisk.c". This
> silences a warning for `get_wch` being unknown.

OK, I'll apply the patch. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
