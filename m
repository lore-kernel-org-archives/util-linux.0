Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:57121 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932430Ab3IEKxR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 5 Sep 2013 06:53:17 -0400
Message-ID: <52286299.7000708@gmail.com>
Date: Thu, 05 Sep 2013 12:53:13 +0200
From: Gabriel de Perthuis <g2p.code@gmail.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Rolf Fokkens <rolf@rolffokkens.nl>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: bcache-tools package for Fedora / status probe-bcache
References: <521A55D4.20908@rolffokkens.nl> <52282A87.4000801@rolffokkens.nl> <52285A03.7080802@gmail.com> <FEBD3400-93F1-4286-8BE8-45D5413C2EA2@rolffokkens.nl>
In-Reply-To: <FEBD3400-93F1-4286-8BE8-45D5413C2EA2@rolffokkens.nl>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>> I'm not a fan of a blkid csum check (I pointed it out on the 
>> bug[1]). If a superblock gets scribbled or corrupted, you want 
>> bcache to complain, and you don't want blkid to look for the next 
>> possible signature.
> 
> Having blkid also verify the csum was requested by Karel Zak, the 
> maintainer of util-linux. As a packager of bcache-tools I'm in favour
> of having blkid identify bcache, but I don't have a preference on
> using csum to identify bcache. I can pass the message to Karel, but
> it would be better if we both discuss it on the appropriate 
> (util-linux?) mail list.

Karel, are you okay if blkid doesn't do the csum verification discussed above?
Checksum failures will be reported by the kernel instead.
Alternatively, do you see a way libblkid can return good magic / bad checksum
results?

>>> So now I'm wondering: are there any particular reasons to keep 
>>> probe-bcache part of the package, or will it really be obsolete?
>> 
>> If you address the above and tweak the udev rules, why not.
>> 
>> The upstream repo will need to keep probe-bcache for a while 
>> longer, because we don't have a way to require a sufficiently 
>> recent libblkid.
> 
> I agree, f20 is a specific case, but in general probe-bcache will be 
> needed for a while.

For the record, the libblkid patch is a good thing in the long run:
common interface, less forks in udev.

>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1001120#c9

