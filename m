Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751777AbdFNTnf (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 14 Jun 2017 15:43:35 -0400
Date: Wed, 14 Jun 2017 21:43:16 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: partx: deleting single partitions fails
Message-ID: <20170614194316.uhplmksedwangz43@ws.net.home>
References: <201706141243.11785.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201706141243.11785.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jun 14, 2017 at 12:43:11PM +0200, Ruediger Meier wrote:
> Looks like since commit 2d47fa39 partx does not understand
> single partition numbers anymore.

No, this syntax is

    partx <operation> <partition> <wholedisk>

where <partition> and <wholedisk> is device name, and the both paths
has to match, it means

    partx -d /dev/sda1 /dev/sdc

is mistake (sda vs sdc).

> $ partx 2 /dev/sdb
> partx: partition and disk name do not match

This syntax has not been supported before commit
c4ecaf21d59671ac7ec0bd26bd2c346c98c7771c (year 2010) where was
introduced weak code in get_partno_from_device(). This weak code cares
about last number, for example "Jun2" will be interpreted as a second
partition :-)

I don't think such syntax has been ever announced anywhere. The -n|--nr
is required to specify partition by number.

And since 2d47fa39 we care if the <partition> exists or matches with
<wholedisk>.

> $ partx -d 2 /dev/sdb
> partx: partition and disk name do not match

 partx -d --nr 2 /dev/sdb

> We are using the last syntax in test "delete-non-existent" but do not 
> check stderr.

I don't think we need to change partx.c. IMHO the broken thing is the
test and it should be fixed by "--nr" (and check stderr :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
