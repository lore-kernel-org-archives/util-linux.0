Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751192AbdBALmw (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 1 Feb 2017 06:42:52 -0500
Date: Wed, 1 Feb 2017 12:42:46 +0100
From: Karel Zak <kzak@redhat.com>
To: Michal Soltys <soltys@ziu.info>
Cc: util-linux@vger.kernel.org
Subject: Re: findmnt under container
Message-ID: <20170201114246.tpjirhsk52qaijuo@ws.net.home>
References: <008ff846-8010-44ef-2056-5e0ecdc355c1@ziu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <008ff846-8010-44ef-2056-5e0ecdc355c1@ziu.info>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Feb 01, 2017 at 12:10:38PM +0100, Michal Soltys wrote:
> Hi,
> 
> If I start a container by say systemd-nspawn (also tested with ubuntu
> through debootstrap):
> 
> pacstrap -c -d arch base
> systemd-nspawn -b -D arch
> 
> then findmnt without any arguments just returns one line (to be precise - it
> always seems to be the first mount under /sys/fs/cgroup), e.g.:
> 
> /sys/fs/cgroup/devices cgroup cgroup ro,nosuid,nodev,noexec,relatime,devices

 1) /proc/self/mountinfo content?

 2) try: LIBMOUNT_DEBUG=all findmnt

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
