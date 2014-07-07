Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.187]:55800 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbaGGLcK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 7 Jul 2014 07:32:10 -0400
Message-ID: <53BA8537.2090504@bernhard-voelker.de>
Date: Mon, 07 Jul 2014 13:32:07 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Util-Linux <util-linux@vger.kernel.org>
Subject: fdisk -b segfaults
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Easy reproducer:

   $ dd if=/dev/zero of=xxx bs=1M count=20
   20+0 records in
   20+0 records out
   20971520 bytes (21 MB) copied, 0.0275507 s, 761 MB/s

   $ ~/util-linux/fdisk -b 4096 xxx

   Welcome to fdisk (util-linux 2.25-rc2).
   Changes will remain in memory only, until you decide to write them.
   Be careful before using the write command.

   Device does not contain a recognized partition table.
   Segmentation fault

I can't have a look myself right now, because UL's autogen.sh
doesn't work here on openSUSE-13.1 anymore.

Have a nice day,
Berny
