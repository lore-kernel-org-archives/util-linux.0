Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36418 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbbFVOsw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Jun 2015 10:48:52 -0400
Received: by paceq1 with SMTP id eq1so111044529pac.3
        for <util-linux@vger.kernel.org>; Mon, 22 Jun 2015 07:48:51 -0700 (PDT)
Date: Mon, 22 Jun 2015 07:49:03 -0700
From: Isaac Dunham <ibid.ag@gmail.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: mount existing tmpfs mounts a new tmpfs
Message-ID: <20150622144903.GA1595@localhost>
References: <55876C53.7030505@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55876C53.7030505@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 21, 2015 at 10:00:51PM -0400, Phillip Susi wrote:

> Forwarding this from debian bug #772419: Run mount /run, and it mounts
> a new tmpfs over top of the existing one in /run ( even if /run isn't
> listed in /etc/fstab ), hiding the existing files.  It should say that
> it is already mounted.

Devuan Jessie, mount 2.26.2-6+devuan1, only says that /run is not in
/etc/fstab unless I use:
 mount -t tmpfs tmpfs /run

The "filesystem mounted or mountpoint busy" stuff should be from
getting errno == EBUSY; this won't happen if you use a virtual filesystem
that supports multiple instances.

*As far as I know*, the only way mount with a single argument is
able to determine the correct filesystem or mountpoint without reading
/etc/fstab is if you add the "remount" option.

HTH,
Isaac Dunham
--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
