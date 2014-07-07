Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45080 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751976AbaGGUM1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 7 Jul 2014 16:12:27 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D55D420AC0
	for <util-linux@vger.kernel.org>; Mon,  7 Jul 2014 16:12:26 -0400 (EDT)
Message-Id: <1404763946.11261.139018425.3433757B@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: 2.25-rc2: how to disable prlimit?
Date: Mon, 07 Jul 2014 22:12:26 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Running ./configure I get this:

-----
checking for syscall prlimit64... no
configure: WARNING: Unable to detect syscall prlimit64.
configure: WARNING: prlimit64 syscall not found; do not build prlimit
-----

There were several other messages, like "do not build nsenter" and
"do not build runuser".  All of those are suppressed when using the
appropriate --disable flags.  But when I try --disable-prlimit, it says:

configure: WARNING: unrecognized options: --disable-prlimit

How does one prevent prlimit from being built?

Benno

-- 
http://www.fastmail.fm - One of many happy users:
  http://www.fastmail.fm/help/overview_quotes.html

