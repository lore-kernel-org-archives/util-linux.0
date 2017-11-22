Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752268AbdKVMAb (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 22 Nov 2017 07:00:31 -0500
Date: Wed, 22 Nov 2017 13:00:28 +0100
From: Karel Zak <kzak@redhat.com>
To: kalle <kalle@projektwerkstatt.de>
Cc: util-linux@vger.kernel.org
Subject: Re: man lsblk
Message-ID: <20171122120028.lozaoz4fifrzvzjj@ws.net.home>
References: <bc06a7b2-87f3-50af-4e51-f9f3166186d4@projektwerkstatt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bc06a7b2-87f3-50af-4e51-f9f3166186d4@projektwerkstatt.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Nov 21, 2017 at 11:44:17PM +0100, kalle wrote:
> hello,
> here some critics:
> -I had problems with reading the label through `lsblk', when not using
> privileges. And the related man-page doesn't mention privilege matters.
> For what is mentioned (in the `Notes'), that /sys/dev/block has to be
> readable, my systems seems to be ok (read and write rights granted for
> `others') -> I assume that it is a question of privileges, which should
> be better documented

Frankly, I'm not sure if this is the right place to discuss end-user
issues. It would be better to use distro specific mailing list or bug
tracker. For example I have no clue if you have lsblk with or without
udev support, used versions, etc. etc.

> -proposition: put the options of `lsblk(8)' explicitly in the man-file
> instead than only in `lsblk --help'
> -`lsblk -m -o LABELs'shows only LABELs, but why? While `lsblk -o LABEL
> -m' shows both. I think the options should be commutative...

I cannot reproduce this problem with 2.30.2 and the current upstream
tree.

> -after unmounting a device `lsblk' doesn't list it anymore

Hmm... lsblk list block device, mount/umount affects only MOUNTPOINT
column.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
