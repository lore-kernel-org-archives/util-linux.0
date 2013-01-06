Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f175.google.com ([209.85.214.175]:56765 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755918Ab3AFARx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 5 Jan 2013 19:17:53 -0500
Received: by mail-ob0-f175.google.com with SMTP id vb8so16254278obc.34
        for <util-linux@vger.kernel.org>; Sat, 05 Jan 2013 16:17:52 -0800 (PST)
MIME-Version: 1.0
Date: Sun, 6 Jan 2013 03:17:52 +0300
Message-ID: <CAGbmdnVWDifpsPvKUkdP+qX0m4GL7VYky5NyB-XYNGS19aXsvA@mail.gmail.com>
Subject: fstab zram swap integration idea
From: Maksim Melnikau <maxposedon@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Linux kernel now have interesting zram feature, which I would like to
initialize via fstab. May be you find it interesting, and this feature
will be implemented:

It will be nice, add to fstab option "mkswap before swapon", which
could be used for auto-initialization swap in zram.

Right now, I do it in next way, which isn't very nice I think:
1. zram size initialized via tmpfiles systemd mechanism
2. mkswap done via udev rule
3. /dev/zram0 added to fstab

I asked same question at systemd-devel ML, and was redirected to
util-linux http://lists.freedesktop.org/archives/systemd-devel/2012-November/007444.html
