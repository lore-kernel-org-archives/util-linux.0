Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35863 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbbH2Dcc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 28 Aug 2015 23:32:32 -0400
Received: by lbvd4 with SMTP id d4so3208516lbv.3
        for <util-linux@vger.kernel.org>; Fri, 28 Aug 2015 20:32:30 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 29 Aug 2015 03:32:30 +0000
Message-ID: <CA+X5Wn45VNhXYztEVxrccF6uePshfFv3X3isB39y5RYT1-uUAg@mail.gmail.com>
Subject: Expected behavior of "mount /mnt/root /mnt/root --bind"
From: james harvey <jamespharvey20@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If /dev/vda is a btrfs volume (not using partitioning) and is mounted to /mnt

And if /mnt/root is made as a normal directory (not a subdirectory)

And if an nfs share is mounted to /mnt/root/mnt

And for some reason "mount /mnt/root /mnt/root --bind" is ran

... Should /mnt/root/mnt now be viewable as an empty mountpoint,
hiding the nfs share?

Right now it does that.  Not sure what the expected behavior would be.
Not sure if "mount x x" is ever desired to be allowed, or if it should
refuse to do that.
