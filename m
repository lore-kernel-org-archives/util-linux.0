Return-Path: <SRS0=Zjrq=Y5=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A74CC5DF60
	for <util-linux@archiver.kernel.org>; Tue,  5 Nov 2019 17:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1941920663
	for <util-linux@archiver.kernel.org>; Tue,  5 Nov 2019 17:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbfKEROA (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 5 Nov 2019 12:14:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:50210 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728399AbfKEROA (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 5 Nov 2019 12:14:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D03E6ADFB;
        Tue,  5 Nov 2019 17:13:58 +0000 (UTC)
Date:   Tue, 5 Nov 2019 18:13:57 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] blkid: open device in nonblock mode.
Message-ID: <20191105171357.GV1384@kitsune.suse.cz>
References: <20191104202315.4879-1-msuchanek@suse.de>
 <20191105114122.o3cjzfnoy3hp2rbm@10.255.255.10>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105114122.o3cjzfnoy3hp2rbm@10.255.255.10>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Nov 05, 2019 at 12:41:22PM +0100, Karel Zak wrote:
> On Mon, Nov 04, 2019 at 09:23:15PM +0100, Michal Suchanek wrote:
> > When autoclose is set (kernel default but many distributions reverse the
> > setting) opening a CD-rom device causes the tray to close.
> > 
> > The function of blkid is to report the current state of the device and
> > not to change it. Hence it should use O_NONBLOCK when opening the
> > device to avoid closing a CD-rom tray.
> 
> I can imagine this as optional solution (command line option), but I

That defeats the purpose of this change. You cannot use the option with
old blkid, so using the option is broken and not using it is also broken.

> have doubts to use O_NONBLOCK by default for all block devices. I have
> no example, but it sounds like a way how to introduce regressions in
> libblkid behavior. (Any kernel guy around?) Is it really only cdrom
> driver(s) where O_NONBLOCK has any impact? What about USB, some random
> SCSI, ... I don't know.
> 
> The another problem is that the library does not have to open the device,
> you can use already open file descriptor (blkid_probe_set_device()). 
> So, in many cases the patch will have no effect.

If some random program using libblkid closes the tray I don't care that
much. However, many system scripts use blkid, probably to find a device
with particular ID:

/usr/bin/dracut:            dev=$(blkid -l -t UUID=${dev#UUID=} -o
device)
/usr/bin/dracut:            dev=$(blkid -l -t LABEL=${dev#LABEL=} -o
device)
/usr/bin/dracut:            dev=$(blkid -l -t PARTUUID=${dev#PARTUUID=}
-o device)
/usr/bin/dracut:            dev=$(blkid -l -t
PARTLABEL=${dev#PARTLABEL=} -o device)

/usr/bin/linux-boot-prober:	partition=$(blkid | grep "$UUID" | cut
-d ':' -f 1 | tr '\n' ' ' | cut -d ' ' -f 1)
/usr/bin/os-prober:	blkid | grep btrfs | cut -d ':' -f 1
/usr/bin/os-prober:	type=$(blkid -o value -s TYPE $mapped || true)
/usr/bin/os-prober:		uuid=$(blkid -o value -s UUID $mapped)

> 
> > blkid is used liberally in scripts so it can potentially interfere with
> > the user operating the CD-rom hardware.
> 
> It's better to use lsblk in script, it reads info from udev -- call
> blindly blkid(8) is usually overkill.

First off you need to explain it to all authors of all random scripts
out there.

Secondly udev is not guaranteed to exist/run on every system.

Thanks

Michal
