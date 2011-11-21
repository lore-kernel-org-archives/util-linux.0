Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcagg.dreamhost.com ([208.97.132.66]:37926 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754281Ab1KUWGU (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Nov 2011 17:06:20 -0500
Subject: Re: mkfs.minix V3 is broken
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Maurizio Lombardi <m.lombardi85@gmail.com>
Cc: util-linux@vger.kernel.org
In-Reply-To: <CAMtsiiDWF3xCiFtENTaYS36zKOJjRHML0x2nk1P0d0zeU3qi0A@mail.gmail.com>
References: <CAMtsiiDWF3xCiFtENTaYS36zKOJjRHML0x2nk1P0d0zeU3qi0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 21 Nov 2011 23:06:15 +0100
Message-ID: <1321913175.3253.8.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 2011-11-21 at 20:40 +0100, Maurizio Lombardi wrote:
> Hi all,
> 
> I noticed a lot of bugs in the mkfs.minix program when dealing with V3
> filesystems.
> I did a lot of fixes in the source code and then I decided to set up a
> github repository to make the review easier:
> 
> git@github.com:maurizio-lombardi/util-linux.git
> 
> Can the mkfs.minix mantainer review the patches please?

Most of the work I did on supporting v3 was based on the kernel's
implementation and the mkfs shipped with minix (by ast), so a lot of
what you say makes sense. I've taken a quick look at the changes and
most are bugs are pretty straightforward, except:

- mkfs.minix: The total number of zones is limited to 65536 only on V1
filesystems

Unless I'm missing something, this doesn't really change any logic.


I'll give the changes a proper test over the weekend.

Thanks,
Davidlohr

> 
> Please cc me because I'm not subscribed to the list.
> 
> Regards,


