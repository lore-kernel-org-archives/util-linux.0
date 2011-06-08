Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:29656 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213Ab1FHMJ1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 8 Jun 2011 08:09:27 -0400
Date: Wed, 8 Jun 2011 14:09:24 +0200
From: Karel Zak <kzak@redhat.com>
To: "KESHAV P.R." <skodabenz@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: support for PARTUUID in blkid
Message-ID: <20110608120924.GD2150@nb.net.home>
References: <BANLkTikcxGrwfoTDbphnW16s52dqKcgSBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTikcxGrwfoTDbphnW16s52dqKcgSBg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 07, 2011 at 07:17:01PM +0530, KESHAV P.R. wrote:
> Hi,
>      Is it possible to add support for PARTUUID to device name
> conversion in blkid similar to FS UUID. The PARTUUID mentioned here is
> the ID_PART_ENTRY_UUID output of 'blkid -p -i -o udev /dev/sda1' (for
> example). What I want is the support for PARTUUID in 'blkid -U
> <PARTUUID>' (not exactly -U , a similar command). Is it possible to
> implement? Sorry I am not a programmer. This request is mainly to
> support https://github.com/falconindy/geninit/commit/72272da8a855d9551c04de9ba502f3befb2a91d5

This is on my TODO list for long time :-) Maybe Iill have time to
implement it for 2.21 (the end of this year).

It would be nice to support the UUIDs in mount and fsck. Then we can
use it in projects like dracut or in /etc/fstab, etc.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
