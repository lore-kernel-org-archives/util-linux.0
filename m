Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f169.google.com ([209.85.217.169]:42672 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbaIOMWY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 15 Sep 2014 08:22:24 -0400
Received: by mail-lb0-f169.google.com with SMTP id p9so4352980lbv.14
        for <util-linux@vger.kernel.org>; Mon, 15 Sep 2014 05:22:23 -0700 (PDT)
Message-ID: <5416D9FC.50204@gmail.com>
Date: Mon, 15 Sep 2014 14:22:20 +0200
From: Marcin Kocur <marcin2006@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
CC: Jakub Bogusz <qboosh@pld-linux.org>
Subject: cfdisk 2.25 doesn't write partition table when using localized version
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

I'm using LANG=pl_PL.UTF-8, my cfdisk is translated into Polish. When 
trying to write the partition table, cfdisk tells me that the the 
partition table wasn't written, no matter if I type yes in English or 
"tak" in Polish. I have briefly checked the pl.po file and it seems to 
be fine. When I set export LANG=en_US, then I was able to save the 
partition table on the device.

CC to the last translator.

-- 
Pozdrawiam / Greetings
Marcin Kocur █
Dane kontaktowe / Contact details: http://koci.net.pl/email

