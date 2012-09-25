Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56303 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753652Ab2IYUdJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 25 Sep 2012 16:33:09 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 088D2201DE
	for <util-linux@vger.kernel.org>; Tue, 25 Sep 2012 16:33:09 -0400 (EDT)
Message-Id: <1348605188.19630.140661132636721.0CD0D5D4@webmail.messagingengine.com>
From: Francesco Turco <fturco@fastmail.fm>
To: util-linux@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain
Subject: Why fdisk wants the first partition to start at 1 MiB?
Date: Tue, 25 Sep 2012 22:33:08 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello.

I'm trying to use fdisk (from util-linux 2.19.1) for creating a
partition on a drive. I noticed that the start sector of the first
partition must be at least 2048, that is 1 MiB from the beginning of the
drive. This can be changed by entering the "expert mode" and using the
"move beginning of data in a partition" option. But I'm still wondering
why fdisk reserves so much space by default.

As far as I know the only sector that should not be used for partitions
is the first one, that is, sector 0. It is reserved for the MBR. So the
first partition can start at sector 1. I read that the 1 MiB thing is
Windows related: http://en.wikipedia.org/wiki/Logical_Disk_Manager. Or
it's something that Linux users should also care about? I can't find a
convincing explanation anywhere.

This 1 MiB thing seems to affect parted, too, as it wants partition
boundaries to be multiples of 1 MiB. I don't know if it's related to the
problem I have with fdisk, though.

Any help is much appreciated.
