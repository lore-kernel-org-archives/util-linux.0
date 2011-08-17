Return-Path: util-linux-owner@vger.kernel.org
Received: from thot02.seeweb.it ([85.94.213.58]:49610 "EHLO thot02.seeweb.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752130Ab1HQJd2 convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 17 Aug 2011 05:33:28 -0400
From: Giulio <giulioo@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: sfdisk: trying to create aligned partitions: fail
Date: Wed, 17 Aug 2011 11:31:56 +0200
Reply-To: giulioo@pobox.com
References: <20110817061256.BB29DF815@i3.golden.dom> <20110817075613.GB28856@nb.net.home>
In-Reply-To: <20110817075613.GB28856@nb.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20110817093146.860D9F815@i3.golden.dom>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, 17 Aug 2011 09:56:13 +0200, Karel Zak <kzak@redhat.com> wrote:

>On Wed, Aug 17, 2011 at 08:13:06AM +0200, Giulio wrote:
>> Linux 2.6.18-238.12.1.el5
>> sfdisk from util-linux 2.20-rc1
>> fdisk (util-linux 2.20-rc1)
>> 200GB VMware SCSI disk
>> 
>> It seems it's not immediately possible to create aligned partitions (ie:
>> starting at 1MB/2048 sectors) with sfdisk.
>
> This is unsupported by sfdisk and cfdisk. You have to use fdisk or
> parted.

What is unsupported?

I know sfdisk won't automatically align partitions and didn't expect it to
do it, my email was about sfdisk behaving in an unexpected way:
- not respecting 1MB as start of partition when I ask for it
- creating partitions out of order when using sectors

Maybe I chose the wrong subject, I was trying to align partition manually
and sfidk won't let me do it.

Thanks.
