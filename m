Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39642 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754883AbbGYPRZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 25 Jul 2015 11:17:25 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 5852320255
	for <util-linux@vger.kernel.org>; Sat, 25 Jul 2015 11:17:22 -0400 (EDT)
Message-Id: <1437837442.451484.332903777.1A436FE4@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: cfdisk: partition type wraps to next line on small screens
Date: Sat, 25 Jul 2015 17:17:22 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Do for example:

stty cols 64
./cfdisk

Press <Down> several times; then <Up> several times.
See how fragments of the partition type remain at the
start of each line.


Something else.  The extra info block contains two lines
giving the Start C/H/S and End C/H/S.  But on my system
all of them say "1023/63/254" (except for the first
partition), so that seems to me pointless information.
Maybe show them only when the Start and End values differ?

Also, leaving out that information will make it more likely
that, on small screens, useful info like filesystem type and
label can be shown.

Further, on https://en.wikipedia.org/wiki/Cylinder-head-sector
it says that heads went up to 254 and sectors up to 63, so,
if shown, shouldn't it say "1023/254/63" instead?


Upcoming patches try to improve the layout of the cfdisk
screen a bit: bringing the menu line closer to the hint line
again, and the info block closer to the partition list.

However, on narrow screens this might lead to the last one
or two menu items being temporarily overwritten by the info
line.  I don't think this is a big deal: when there is little
space, one must expect a bit of a shuffle.  But if this seems
unacceptable, then it will be better to define MENU_START_LINE
as ui_lines - 4 instead.

Benno

-- 
http://www.fastmail.com - mmm... Fastmail...

