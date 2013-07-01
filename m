Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:7570 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753233Ab3GAJBQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 1 Jul 2013 05:01:16 -0400
Date: Mon, 1 Jul 2013 11:01:03 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 15/15] hexdump: use simple printing functions when
 possible
Message-ID: <20130701090103.GA28709@x2.net.home>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
 <1371408836-16663-16-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371408836-16663-16-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 16, 2013 at 07:53:56PM +0100, Sami Kerola wrote:
> This makes common cases 35-50% quicker.

 What about portability and code readability?

 It would be nice to have include/unlocked-io.h and add 
 AC_CHECK_DECLS_ONCE() for all *_unlocked functions. 

 See gnulib/lib/unlocked-io.h
     gnulib/m4/unlocked-io.m4

 .. then you can control all the behaviour by "#include unlocked-io.h"
 rather than change all the code in the util(s). Maybe we can use the
 functions in more utils where we intensively print something (e.g.
 dmesg).

 I guess we don't want separate m4 file for this stuff.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
