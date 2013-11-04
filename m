Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.186]:55094 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab3KDLJO convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 4 Nov 2013 06:09:14 -0500
Date: Mon, 4 Nov 2013 12:09:12 +0100 (CET)
From: Bernhard Voelker <mail@bernhard-voelker.de>
Reply-To: Bernhard Voelker <mail@bernhard-voelker.de>
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Message-ID: <749356890.38567.1383563352930.open-xchange@email.1und1.de>
Subject: mount --bind /A /A multiplies mount entries
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Using the same mount point as SRC and DST with mount --bind
somehow multiplies the number of mount points:

  $ ./mount | grep sdb
  /dev/sdb on /home type ext4 (rw,relatime,data=ordered)

  $ ./mount --bind /home /home

  $ ./mount | grep sdb
  /dev/sdb on /home type ext4 (rw,relatime,data=ordered)
  /dev/sdb on /home type ext4 (rw,relatime,data=ordered)

  $ ./mount --bind /home /home

  $ ./mount | grep sdb
  /dev/sdb on /home type ext4 (rw,relatime,data=ordered)
  /dev/sdb on /home type ext4 (rw,relatime,data=ordered)
  /dev/sdb on /home type ext4 (rw,relatime,data=ordered)
  /dev/sdb on /home type ext4 (rw,relatime,data=ordered)

  $ ./mount --bind /home /home

  $ ./mount | grep sdb
  /dev/sdb on /home type ext4 (rw,relatime,data=ordered)
  /dev/sdb on /home type ext4 (rw,relatime,data=ordered)
  /dev/sdb on /home type ext4 (rw,relatime,data=ordered)
  /dev/sdb on /home type ext4 (rw,relatime,data=ordered)
  /dev/sdb on /home type ext4 (rw,relatime,data=ordered)
  /dev/sdb on /home type ext4 (rw,relatime,data=ordered)
  /dev/sdb on /home type ext4 (rw,relatime,data=ordered)
  /dev/sdb on /home type ext4 (rw,relatime,data=ordered)

This is probably a kernel bug, but as bind mounts to self
are not that much of use, wouldn't it be worthwhile to
prohibit it at all in mount(8)?

System (mount from latest git):

  $ lsb_release -a
  LSB Version:    n/a
  Distributor ID: openSUSE project
  Description:    openSUSE 12.3 (x86_64)
  Release:        12.3
  Codename:       Dartmouth

  $ uname -r
  3.7.10-1.16-desktop

Have a nice day,
Berny
