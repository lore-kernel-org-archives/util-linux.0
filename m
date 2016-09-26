Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lf0-f51.google.com ([209.85.215.51]:32926 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754621AbcIZWZe (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 26 Sep 2016 18:25:34 -0400
Received: by mail-lf0-f51.google.com with SMTP id b71so135896468lfg.0
        for <util-linux@vger.kernel.org>; Mon, 26 Sep 2016 15:25:33 -0700 (PDT)
MIME-Version: 1.0
From: Andreas Fenkart <afenkart@gmail.com>
Date: Tue, 27 Sep 2016 00:25:32 +0200
Message-ID: <CALtMJED52KKWgMmg+hcGavZAP6fwh_AbTWFZKz+LYEWszsjLJw@mail.gmail.com>
Subject: getmntent wrapper?
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

Parsing /etc/fstab or /proc/mount with sed/awk is awful and platform
dependent. Would it be acceptable to add a wrapper for getmntent to
parse those files and make the content available to shell scripts?

Typical use is to check if a given device is already mounted and
returning its mountpoint. In case a device is mounted twice or more,
several mountpoints will be listed

$ getmntent -f /proc/mounts /dev/sda4
/mnt/
/home/user/bind

Playing around with mount parsing the output with awk seems to work
pretty well. It avoids to handle the whitespace separately.

$ mount -l  | awk  '/\/dev\/sda4/ { print $3; }'

negative:
- I can't use the a different filesystem description file (small minus)
- Is the output from 'mount' stable?

Is it worth to add a utility wrapper for getmntent to util-linux?

Andi
