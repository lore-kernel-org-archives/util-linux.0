Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f171.google.com ([209.85.214.171]:48240 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab3EJEGE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 10 May 2013 00:06:04 -0400
Received: by mail-ob0-f171.google.com with SMTP id ef5so965042obb.16
        for <util-linux@vger.kernel.org>; Thu, 09 May 2013 21:06:03 -0700 (PDT)
Received: from [192.168.0.75] (cpe-70-123-200-41.satx.res.rr.com. [70.123.200.41])
        by mx.google.com with ESMTPSA id jt9sm1351620obc.0.2013.05.09.21.05.59
        for <util-linux@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 09 May 2013 21:06:00 -0700 (PDT)
Message-ID: <518C7226.7020407@gmail.com>
Date: Thu, 09 May 2013 23:05:58 -0500
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: umount -r
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

We have as a part of our shutdown scripts:

umount -a -d -r -t notmpfs,nosysfs,nodevtmpfs,noproc

What we expect is that the rootfs (/) will fail, but be remounted read 
only.  This doesn't seem to be happening because we get messages about 
recovery needed during the next boot.

We can work around it by adding

mount -n -o remount,ro /

I have a report that umount works as expected in version 2.21.2, but not 
in 2.22.2 or later.  I this a misunderstanding about umount or a bug?

   -- Bruce Dubbs
      linuxfromscratch
