Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46453 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752238AbaGGUe4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 7 Jul 2014 16:34:56 -0400
Message-Id: <1404765295.16902.139036593.3B689FEB@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
Cc: Sami Kerola <kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain
Subject: small problem with kill --queue
Date: Mon, 07 Jul 2014 22:34:55 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hello Sami,

./kill --queue 11 12
kill: sending signal to 12 failed: Operation not permitted

/kill --queue data 12
kill: unknown signal data; valid signals:
 1 HUP      2 INT      3 QUIT     4 ILL      5 TRAP     [...]

But "data" is not a signal, it is meant to be a number, an integer,
a value passed to the signalled process.

In misc-utils.c it does this:

        arg = *argv;
        if ((ctl->numsig = arg_to_signum(arg, 0)) < 0)
                err_nosig(arg);

But it should not run arg_to_signum() on the argument, it
should simply parse it as an integer, and when that fails,
it should not call err_nosig() but say something like "not
a number".  Right?

Benno

-- 
http://www.fastmail.fm - mmm... Fastmail...

