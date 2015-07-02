Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59598 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430AbbGBIXL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 2 Jul 2015 04:23:11 -0400
Date: Thu, 2 Jul 2015 10:23:09 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: script, broken test options/return
Message-ID: <20150702082309.GD26962@ws.net.home>
References: <201507020203.21632.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201507020203.21632.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 02, 2015 at 02:03:21AM +0200, Ruediger Meier wrote:
> on my system (interactive bash on openSUSE 13.1) the "return" subtest 
> of "script/options" is broken since 54c6611d.
> 
> Seems that input from /dev/null makes the difference. Reproduce like
> this:
> 
> $ export SCRIPT_DEBUG=all 
> $ ./script --command "exit 1" out_good >/dev/null            2>dbg_good
> $ ./script --command "exit 1" out_bad  >/dev/null </dev/null 2>dbg_bad
> ^C <abort ctrl-C>

 Does is mean that script(1) hangs?

 Anyway, I'm not able to reproduce the problem, script as well as the
 test(s) work as expected (bash-4.3.39-1).

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
