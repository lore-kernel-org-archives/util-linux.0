Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:47670 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbaLYW6S (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 25 Dec 2014 17:58:18 -0500
Received: by mail-wi0-f180.google.com with SMTP id n3so16113590wiv.1
        for <util-linux@vger.kernel.org>; Thu, 25 Dec 2014 14:58:16 -0800 (PST)
MIME-Version: 1.0
From: Kay Sievers <kay@vrfy.org>
Date: Thu, 25 Dec 2014 23:57:56 +0100
Message-ID: <CAPXgP1300xmdYHCbBpdbRiFDAKvab4w33Jt5ZEGdkrQ4_9tj_A@mail.gmail.com>
Subject: cfdisk created GPT tables are not recognized by the Windows 8.1 installer
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hey,

the Windows 8.1 installer does not recognize the GPT partition tables
created with cfdisk. It claims it will need to initialize the entire
disk to install Windows.

Reading-in the cfdisk-created table and writing-back the very same
table with parted, makes the Windows installer recognizes it, and
Windows just its two additional partitions.

I've installed Windows on that box now and don't want to try this
again, but maybe looking at the difference what parted will change in
the cfdisk created table is sufficient to find the bug.

Thanks,
Kay
