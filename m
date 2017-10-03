Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f48.google.com ([209.85.218.48]:45953 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbdJCQ5J (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 3 Oct 2017 12:57:09 -0400
Received: by mail-oi0-f48.google.com with SMTP id f3so15390215oia.2
        for <util-linux@vger.kernel.org>; Tue, 03 Oct 2017 09:57:08 -0700 (PDT)
Received: from [192.168.0.76] (cpe-70-123-251-100.satx.res.rr.com. [70.123.251.100])
        by smtp.gmail.com with ESMTPSA id j194sm6380690oih.22.2017.10.03.09.57.07
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Oct 2017 09:57:07 -0700 (PDT)
To: Util-Linux <util-linux@vger.kernel.org>
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Subject: fdisk request for functionality (or info)
Message-ID: <59D3C162.4050005@gmail.com>
Date: Tue, 3 Oct 2017 11:57:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I have been having a problem with fdisk on old computers.

What I am doing is installing Debian, but dropping to the command line and 
creating a GPT manually because Debian seems to want to always create a 
msdos partition table.

After creating the GPT and partitioning, the install proceeds normally, 
but upon reboot the old bios tells me "No bootable disk".

I can fix this by going into rescue mode and setting the pmbr_boot flag 
using parted.

My question is whether this can be done in fdisk.  If not, can it be added?

I did try going into expert mode and selecting "toggle the legacy BIOS 
bootable flag", but does not seem to work.  I did not see any change to 
the boot sector when using 'd: print the raw data of the first sector from 
the device'.

Advice appreciated.

   -- Bruce Dubbs
