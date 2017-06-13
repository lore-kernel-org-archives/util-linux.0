Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:58304 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753382AbdFMVLf (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 13 Jun 2017 17:11:35 -0400
Received: from [10.0.0.104] ([146.52.24.88]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MKHik-1dMXG2028E-001jKt for
 <util-linux@vger.kernel.org>; Tue, 13 Jun 2017 23:11:28 +0200
Subject: Re: [PATCH 0/5] Fix even more random compiler warnings
From: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
References: <20170613153235.11164-1-sweet_f_a@gmx.de>
Message-ID: <8d8b34ff-6173-55b7-7aea-6afe6b960804@gmx.de>
Date: Tue, 13 Jun 2017 23:11:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170613153235.11164-1-sweet_f_a@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I will resubmit this and my other pull request via github.
There are some minor issues and typos.

On 06/13/2017 05:32 PM, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> Two patches regarding "taking address of packed member". The first
> one (sun) makes things more nice, the second one (gpt) is more ugly.
> Don't know how serious the problem is, see
> https://stackoverflow.com/questions/8568432/is-gccs-attribute-packed-pragma-pack-unsafe
> 
> The wall/OSX patch is maybe too ugly and probably does not fix
> a real issue. Maybe skip it.
> 
> Ruediger Meier (5):
>    libfdisk: cleanup sun label checksum usuage
>    libfdisk: fix guid usage of packed structure gpt_entry
>    libsmartcols: fix warning "unused parameter"
>    wall: fix OSX getgrouplist, gid_t* vs int*
>    tests: add more tests for line(1)
> 
>   include/pt-sun.h               |  2 +-
>   libfdisk/src/gpt.c             | 37 +++++++++++++++++++++++++++----------
>   libfdisk/src/sun.c             | 33 +++++++--------------------------
>   libsmartcols/src/table_print.c |  9 +++++++--
>   term-utils/wall.c              | 13 ++++++++++---
>   tests/expected/misc/line       | 18 ++++++++++++++++++
>   tests/ts/misc/line             | 28 ++++++++++++++++++++++++----
>   7 files changed, 94 insertions(+), 46 deletions(-)
> 
