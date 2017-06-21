Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbdFUPEN (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 21 Jun 2017 11:04:13 -0400
Date: Wed, 21 Jun 2017 17:04:06 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: mount(8) does not work when using a specific target dir
Message-ID: <20170621150406.c4bxgqiy6srqc462@ws.net.home>
References: <CAG27Bk2qLRTEQStSvo7wWeychM+MQofvDGhT_ZOx=4yD7C2v2w@mail.gmail.com>
 <CAG27Bk1ufCja=52nynOtPD5E0=nyi+DjAJ8d7Du3dbuG3ZSLvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk1ufCja=52nynOtPD5E0=nyi+DjAJ8d7Du3dbuG3ZSLvQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jun 21, 2017 at 03:13:36PM +0100, Sami Kerola wrote:
> On 21 June 2017 at 13:15, Sami Kerola <kerolasa@iki.fi> wrote:
> > We (Cloudflare) got a strange issue with mount(8) from debian jessie
> > package v2.25.2. Kernel version is 4.4.46 (self compiled, works on
> > other servers).
> >
> > An md device, that is constructed of 12 luks encrypted disks, will not
> > mount to a path /disk/data but it happily mounts to any other path.
> > This is rather unfortunate because we expect to see our device in that
> > path. The same happens with a dummy file-based filesystem[1], so this
> > is unlikely to be related to the device. Here is a debug sample.
> 
> Found it. A systemd mount unit defined a label, that the device did
> not have and neither the dummy filesystem, so the systemd immediately
> umounted the /data/disk/ mount point.

If I good remember there was some systemd issue with "immediately
umounted", it should be fixed in the recent versions.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
