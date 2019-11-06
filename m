Return-Path: <SRS0=Vf/c=Y6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70468C5DF62
	for <util-linux@archiver.kernel.org>; Wed,  6 Nov 2019 08:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBA2206A3
	for <util-linux@archiver.kernel.org>; Wed,  6 Nov 2019 08:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbfKFIDR (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:03:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:39992 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729734AbfKFIDR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 6 Nov 2019 03:03:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2A22B31A;
        Wed,  6 Nov 2019 08:03:14 +0000 (UTC)
Date:   Wed, 6 Nov 2019 09:02:56 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] blkid: open device in nonblock mode.
Message-ID: <20191106080256.GA19254@kitsune.suse.cz>
References: <20191104202315.4879-1-msuchanek@suse.de>
 <20191105114122.o3cjzfnoy3hp2rbm@10.255.255.10>
 <20191105171357.GV1384@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191105171357.GV1384@kitsune.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Nov 05, 2019 at 06:13:57PM +0100, Michal Suchánek wrote:
> On Tue, Nov 05, 2019 at 12:41:22PM +0100, Karel Zak wrote:
> > On Mon, Nov 04, 2019 at 09:23:15PM +0100, Michal Suchanek wrote:
> > > When autoclose is set (kernel default but many distributions reverse the
> > > setting) opening a CD-rom device causes the tray to close.
> > > 
> > > The function of blkid is to report the current state of the device and
> > > not to change it. Hence it should use O_NONBLOCK when opening the
> > > device to avoid closing a CD-rom tray.
> > 
> > I can imagine this as optional solution (command line option), but I
> 
> That defeats the purpose of this change. You cannot use the option with
> old blkid, so using the option is broken and not using it is also broken.
> 
> > have doubts to use O_NONBLOCK by default for all block devices. I have
> > no example, but it sounds like a way how to introduce regressions in
> > libblkid behavior. (Any kernel guy around?) Is it really only cdrom
> > driver(s) where O_NONBLOCK has any impact? What about USB, some random
Yes, it affect floppies as well:

drivers/block/ataflop.c:        if (mode & FMODE_NDELAY)
drivers/block/floppy.c: if (!(mode & FMODE_NDELAY)) {
drivers/block/pktcdvd.c:        ret = blkdev_get(bdev, FMODE_READ |
FMODE_NDELAY, NULL);
drivers/block/pktcdvd.c:                blkdev_put(bdev, FMODE_READ |
FMODE_NDELAY);
drivers/block/pktcdvd.c:        blkdev_put(bdev, FMODE_READ |
FMODE_NDELAY);
drivers/block/pktcdvd.c:        blkdev_put(pd->bdev, FMODE_READ |
FMODE_NDELAY);
drivers/block/swim.c:   if (mode & FMODE_NDELAY)
drivers/block/swim3.c:  if (err == 0 && (mode & FMODE_NDELAY) == 0
drivers/cdrom/cdrom.c:  if ((mode & FMODE_NDELAY) && (cdi->options &
CDO_USE_FFLAGS)) {
drivers/cdrom/cdrom.c:          !(mode & FMODE_NDELAY);
drivers/ide/ide-gd.c:           if (ret && (mode & FMODE_NDELAY) == 0) {
drivers/scsi/sd.c:      if (sdev->removable && !sdkp->media_present &&
!(mode & FMODE_NDELAY))
drivers/scsi/sd.c:                      (mode & FMODE_NDELAY) != 0);
drivers/scsi/sd.c:                      (mode & FMODE_NDELAY) != 0);
drivers/scsi/sr.c:      return __sr_block_open(bdev, mode |
FMODE_NDELAY);
drivers/scsi/sr.c:      if ((ret == -ENOMEDIUM) && !(mode &
FMODE_NDELAY))
drivers/scsi/sr.c:                      (mode & FMODE_NDELAY) != 0);


> > SCSI, ... I don't know.
> > 
> > The another problem is that the library does not have to open the device,
> > you can use already open file descriptor (blkid_probe_set_device()). 
> > So, in many cases the patch will have no effect.
> 
> If some random program using libblkid closes the tray I don't care that
> much. However, many system scripts use blkid, probably to find a device
> with particular ID:
> 
> /usr/bin/dracut:            dev=$(blkid -l -t UUID=${dev#UUID=} -o
> device)
> /usr/bin/dracut:            dev=$(blkid -l -t LABEL=${dev#LABEL=} -o
> device)
> /usr/bin/dracut:            dev=$(blkid -l -t PARTUUID=${dev#PARTUUID=}
> -o device)
> /usr/bin/dracut:            dev=$(blkid -l -t
> PARTLABEL=${dev#PARTLABEL=} -o device)
> 
> /usr/bin/linux-boot-prober:	partition=$(blkid | grep "$UUID" | cut
> -d ':' -f 1 | tr '\n' ' ' | cut -d ' ' -f 1)
> /usr/bin/os-prober:	blkid | grep btrfs | cut -d ':' -f 1
> /usr/bin/os-prober:	type=$(blkid -o value -s TYPE $mapped || true)
> /usr/bin/os-prober:		uuid=$(blkid -o value -s UUID $mapped)
> 
> > 
> > > blkid is used liberally in scripts so it can potentially interfere with
> > > the user operating the CD-rom hardware.
> > 
> > It's better to use lsblk in script, it reads info from udev -- call
> > blindly blkid(8) is usually overkill.
which uses the udev identifiers which already use O_NONBLOCK:
src/udev/ata_id/ata_id.c:        fd = open(node,
O_RDONLY|O_NONBLOCK|O_CLOEXEC);
src/udev/cdrom_id/cdrom_id.c:                fd = open(node,
O_RDONLY|O_NONBLOCK|O_CLOEXEC);
src/udev/scsi_id/scsi_serial.c:        fd = open(devname, O_RDONLY |
O_NONBLOCK | O_CLOEXEC);
src/udev/scsi_id/scsi_serial.c:                fd = open(devname,
O_RDONLY | O_NONBLOCK | O_CLOEXEC);

> 
> First off you need to explain it to all authors of all random scripts
> out there.
> 
> Secondly udev is not guaranteed to exist/run on every system.
> 
> Thanks
> 
> Michal
