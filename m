Return-Path: util-linux-owner@vger.kernel.org
Received: from drutsystem.com ([84.10.39.251]:39248 "EHLO drutsystem.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751222AbdBALUL (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 1 Feb 2017 06:20:11 -0500
To: util-linux@vger.kernel.org
From: Michal Soltys <soltys@ziu.info>
Subject: findmnt under container
Message-ID: <008ff846-8010-44ef-2056-5e0ecdc355c1@ziu.info>
Date: Wed, 1 Feb 2017 12:10:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

If I start a container by say systemd-nspawn (also tested with ubuntu through 
debootstrap):

pacstrap -c -d arch base
systemd-nspawn -b -D arch

then findmnt without any arguments just returns one line (to be precise - it 
always seems to be the first mount under /sys/fs/cgroup), e.g.:

/sys/fs/cgroup/devices cgroup cgroup ro,nosuid,nodev,noexec,relatime,devices

If I point it directly to the root, e.g.

findmnt -T / -R

then it lists all mounts correctly (in case of arch, 2.29.1 was used).

It kind of looks like a [display] bug (especially that -T / -R work fine).
