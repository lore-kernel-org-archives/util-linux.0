Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33676 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbdFUONi (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 21 Jun 2017 10:13:38 -0400
Received: by mail-qk0-f175.google.com with SMTP id r62so83545482qkf.0
        for <util-linux@vger.kernel.org>; Wed, 21 Jun 2017 07:13:38 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <CAG27Bk2qLRTEQStSvo7wWeychM+MQofvDGhT_ZOx=4yD7C2v2w@mail.gmail.com>
References: <CAG27Bk2qLRTEQStSvo7wWeychM+MQofvDGhT_ZOx=4yD7C2v2w@mail.gmail.com>
From: Sami Kerola <kerolasa@iki.fi>
Date: Wed, 21 Jun 2017 15:13:36 +0100
Message-ID: <CAG27Bk1ufCja=52nynOtPD5E0=nyi+DjAJ8d7Du3dbuG3ZSLvQ@mail.gmail.com>
Subject: Re: mount(8) does not work when using a specific target dir
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 21 June 2017 at 13:15, Sami Kerola <kerolasa@iki.fi> wrote:
> We (Cloudflare) got a strange issue with mount(8) from debian jessie
> package v2.25.2. Kernel version is 4.4.46 (self compiled, works on
> other servers).
>
> An md device, that is constructed of 12 luks encrypted disks, will not
> mount to a path /disk/data but it happily mounts to any other path.
> This is rather unfortunate because we expect to see our device in that
> path. The same happens with a dummy file-based filesystem[1], so this
> is unlikely to be related to the device. Here is a debug sample.

Found it. A systemd mount unit defined a label, that the device did
not have and neither the dummy filesystem, so the systemd immediately
umounted the /data/disk/ mount point.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
