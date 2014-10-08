Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f175.google.com ([209.85.217.175]:60363 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601AbaJHKDR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 8 Oct 2014 06:03:17 -0400
Received: by mail-lb0-f175.google.com with SMTP id u10so7689106lbd.6
        for <util-linux@vger.kernel.org>; Wed, 08 Oct 2014 03:03:15 -0700 (PDT)
Message-ID: <54350C79.3080208@gmail.com>
Date: Wed, 08 Oct 2014 12:05:45 +0200
From: Francis Moreau <francis.moro@gmail.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: losetup: failed to setup loop device > 1
References: <5432C4C8.30101@gmail.com> <20141006174041.GA8057@x2.net.home> <54330294.1090908@gmail.com> <20141007091711.GB8057@x2.net.home> <5433B316.30106@gmail.com> <5434FC75.7060209@gmail.com> <20141008094453.GF8057@x2.net.home>
In-Reply-To: <20141008094453.GF8057@x2.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 10/08/2014 11:44 AM, Karel Zak wrote:
> On Wed, Oct 08, 2014 at 10:57:25AM +0200, Francis Moreau wrote:
>> In HEAD of the git tree, in file losetup.c, the return value of
>> loopcxt_add_device() is not checked in main().
>>
>> Is this expected ?
> 
> Good question :-)
> 

At least one ;)

> The loop-control is optional (from the code point of view). If the system 
> does not have control file (old kernels) and on command line specified loop
> device does not exist then it will end with open() error later
> (in loopcxt_setup_device()).
> 

in losetup.c, line 638:

		if (hasdev && !is_loopdev(loopcxt_get_device(&lc)))
			loopcxt_add_device(&lc);

I don't really see why having loop-control here or not matter: in both
case you want to stop if loopcxt_add_device() fails, no ?

If it fails then the loop device node, doesn't exist.

Thanks
