Return-Path: util-linux-owner@vger.kernel.org
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:43009
	"EHLO qmta09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751249Ab3LRWic (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 18 Dec 2013 17:38:32 -0500
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.7/8.14.7) with ESMTP id rBIMWP1c020105
	for <util-linux@vger.kernel.org>; Wed, 18 Dec 2013 17:32:25 -0500
Date: Wed, 18 Dec 2013 17:32:25 -0500
Message-Id: <201312182232.rBIMWPWN020104@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: util-linux@vger.kernel.org
Subject: losetup "-p" option is not documented
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

(My understanding is that this is the correct place to report bugs for
util-linux.)

In the manual page for losetup (in util-linux-2.23.2-4.fc19.x86_64) is
the text:

       Setup loop device:

            losetup [-o offset] [--sizelimit size]
                    [-p pfd] [-rP] {-f[--show]|loopdev} file

However, the "-p" option is not described in the text.

There also should be a space after "-f".

Thanks for attending to this,

Dale
