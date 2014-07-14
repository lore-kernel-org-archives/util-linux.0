Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41116 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754890AbaGNPHz (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Jul 2014 11:07:55 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id ACCEF20EC1
	for <util-linux@vger.kernel.org>; Mon, 14 Jul 2014 11:07:50 -0400 (EDT)
Message-Id: <1405350470.21924.141447857.78268FC5@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: some comments about the new cfdisk
Date: Mon, 14 Jul 2014 17:07:50 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hi,

Running cfdisk without an argument no longer works - it just
blurts out the usage text, instead of picking the first and only
hard drive in the system.

When exiting from cfdisk without having changed anything and
without having written the table to disk, it still writes to
standard output "Syncing disks." (with a missing newline).
To a novice that will be an alarming message.  I think that
when the user did not ask to write anything to disk, cfdisk
should not be syncing disks, there is no need to, or at least
it should not show that message.

When in the "Select partition type" submenu, it is not possible
to exit from there with Esc.  Hitting ^C instead kills the entire
cfdisk, which is kind of surprising and undesirable: any already
made changes would be lost.

I have two megabytes of free space at the tail of the disk.  If
with the old cfdisk I delete the last partition, it will create
a single expanse of free space.  But with the new cfdisk it will
then have two free spaces:

>>  `-Free space      282779648 312576704  29797057  14.2G                      
    Free space        312578048 312581807      3760   1.9M

It appears to be impossible to reuse that tailing free space.

Benno

-- 
http://www.fastmail.fm - Accessible with your email software
                          or over the web

