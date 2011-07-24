Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-fx0-f52.google.com ([209.85.161.52]:44550 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030Ab1GXSJt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 24 Jul 2011 14:09:49 -0400
Received: by fxd18 with SMTP id 18so7830691fxd.11
        for <util-linux@vger.kernel.org>; Sun, 24 Jul 2011 11:09:47 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 24 Jul 2011 19:09:47 +0100
Message-ID: <CAGq3pz7FctJcUsO-1FmFmV=EW0N=n_ZYBCHGcyXQMr1CJ24zRA@mail.gmail.com>
Subject: Can't remount loopback ext4 without /etc/mtab
From: Daniel Drake <dsd@laptop.org>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

In Fedora 14, the test case below worked fine. In Fedora 15, it fails.
I think this is due to the change to have /etc/mtab as a symlink to
/proc/mounts.

# dd if=/dev/zero of=fs.img bs=1M count=20
# mkfs.ext4 fs.img
# mkdir mountpt
# mount -o loop fs.img mountpt

Now try to remount it read-only:

# mount -o remount,ro mountpt
mount: /home/dsd/tmpdisk/mountpt not mounted already, or bad option

(On Fedora 14 no error was returned and the mount became read-only)

When the error occurs, dmesg says:
[ 5495.860391] EXT4-fs (loop0): Unrecognized mount option "seclabel"
or missing value

Here is the corresponding entry from /proc/mounts:
/dev/loop0 /home/dsd/tmpdisk/mountpt ext4
rw,seclabel,relatime,barrier=1,data=ordered 0 0

Is this a util-linux bug? Or an ext4 issue?

Thanks,
Daniel
