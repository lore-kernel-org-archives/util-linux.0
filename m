Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35931 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbbFNUuK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Jun 2015 16:50:10 -0400
Received: by lbbqq2 with SMTP id qq2so42601314lbb.3
        for <util-linux@vger.kernel.org>; Sun, 14 Jun 2015 13:50:09 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 14 Jun 2015 16:50:09 -0400
Message-ID: <CA+X5Wn71btX_teX7AF-RJjo_2te5_VEZABAQSa6uWuYCtna1+g@mail.gmail.com>
Subject: Mount doesn't show subvol option for btrfs
From: james harvey <jamespharvey20@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Not sure if this could be a linux-unionfs (btrfs) bug instead...

On arch, /etc/fstab includes:

/dev/sda1   /.snapshots   btrfs
rw,noatime,compress=lzo,ssd,discard,space_cache,subvol=.snapshots   0
 0

But mount includes:

/dev/sda1 on /.snapshots type btrfs
(rw,noatime,compress=lzo,ssd,discard,space_cache)

The subvol option isn't reported in mount.

This happens on all of my btrfs mounts, not just .snapshots.
