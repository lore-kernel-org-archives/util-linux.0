Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f175.google.com ([209.85.214.175]:34270 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbbC0TDr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 27 Mar 2015 15:03:47 -0400
Received: by obbgh1 with SMTP id gh1so16199903obb.1
        for <util-linux@vger.kernel.org>; Fri, 27 Mar 2015 12:03:47 -0700 (PDT)
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com. [209.85.218.43])
        by mx.google.com with ESMTPSA id ut10sm1474564obc.20.2015.03.27.12.03.46
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2015 12:03:46 -0700 (PDT)
Received: by oicf142 with SMTP id f142so74762924oic.3
        for <util-linux@vger.kernel.org>; Fri, 27 Mar 2015 12:03:46 -0700 (PDT)
MIME-Version: 1.0
From: Alex Deymo <deymo@chromium.org>
Date: Fri, 27 Mar 2015 12:03:26 -0700
Message-ID: <CAGd9gwi86agrHS3HgFixjZGD3bYjoFabai3G856qw9Rwfo7W-A@mail.gmail.com>
Subject: umount --detach-loop fails but fs is unmounted
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I'm running into a problem when using -d in umount. I'm using
util-linux 2.25.1, but didn't see changes in that code in ToT. When
calling "umount -d" if the passed argument is *not* a loop device (for
example /dev/loopX or /mnt/foo/bar), it will umount it, but the
command will fail (return != 0) and print EINVAL error (22).
Documentation says:

  -d, --detach-loop
    When the unmounted device was a loop device, also free this loop device.

So the command shouldn't fail if you didn't pass a loop device but
still used -d; right? Is this a problem in the documentation or the
code?

* Examples: if you mount your ${image} (an ext4 fs, but whatever) in
${mount_point} this way:

  loop_device=$(sudo losetup --find --show ${image})
  sudo mount -o rw ${loop_device} ${mount_point}


The following command fails (error code 1) and does NOT remove the
loop device, but unmounts the fs properly:
  sudo umount -d ${mount_point}
umount: ${mount_point}: filesystem was unmounted, but mount(8) failed:
Invalid argument

On the other hand, if you run this command instead, it succeeds and
removes the loop device:
  sudo umount -d ${loop_device}


If your loop device has AUTOCLEAN=1 (see "losetup --list --all") the
loop device is removed either way, but the command still fails when
using ${mount_point}:
  sudo mount -o loop,rw ${image} ${mount_point}

This command fails but loop is removed due to the autoclean.
  sudo umount -d ${mount_point}

Thanks,
deymo.
