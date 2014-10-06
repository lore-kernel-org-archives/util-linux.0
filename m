Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:61009 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbaJFU4c (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Oct 2014 16:56:32 -0400
Received: by mail-wi0-f176.google.com with SMTP id hi2so5901840wib.9
        for <util-linux@vger.kernel.org>; Mon, 06 Oct 2014 13:56:31 -0700 (PDT)
Message-ID: <54330294.1090908@gmail.com>
Date: Mon, 06 Oct 2014 22:59:00 +0200
From: Francis Moreau <francis.moro@gmail.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: losetup: failed to setup loop device > 1
References: <5432C4C8.30101@gmail.com> <20141006174041.GA8057@x2.net.home>
In-Reply-To: <20141006174041.GA8057@x2.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 10/06/2014 07:40 PM, Karel Zak wrote:
> On Mon, Oct 06, 2014 at 06:35:20PM +0200, Francis Moreau wrote:
>> One last details is that the system uses pretty old stuff: kernel
>> 3.4.50, util-linux 2.21.1.
> 
> $ git log --oneline v2.21.. -- lib/loopdev.c sys-utils/losetup.c | wc -l
> 62
> 
>> Could anybody give me some help ?
> 
> update, this is upstream mailing list I have doubts anyone is ready
> to help you with code released 2 years ago.

well it looks like more a kernel issue since the sequence of syscalls
done by losetup looks correct. Maybe someone here already encountered
this...

I just found that loop module was loaded with max_part=16 and
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8. If max_part is set to 0 then the issue
is gone :-/


