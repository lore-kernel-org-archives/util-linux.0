Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.186]:59352 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab3J3Qss convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 30 Oct 2013 12:48:48 -0400
Date: Wed, 30 Oct 2013 17:48:46 +0100 (CET)
From: Bernhard Voelker <mail@bernhard-voelker.de>
Reply-To: Bernhard Voelker <mail@bernhard-voelker.de>
To: helmut@hullen.de, util-linux@vger.kernel.org,
        Helmut Hullen <Hullen@t-online.de>
Message-ID: <2018489810.236892.1383151726720.open-xchange@email.1und1.de>
In-Reply-To: <CgqsAZmPCXB@helmut.hullen.de>
References: <345614206.235496.1383150183769.open-xchange@email.1und1.de> <CgqsAZmPCXB@helmut.hullen.de>
Subject: Re: Bind mounts record fstype of none
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> On October 30, 2013 at 5:31 PM Helmut Hullen <Hullen@t-online.de> wrote:
>> Du meintest am 30.10.13:
>
> >> So is mount wrong for recording the filesystem type as 'none' or
> >> not?
>
> > Where do you see 'none'?
>
>         df -a -T
>
> Maybe that problem is related to the option "-type"; "bind" is no 
> allowed "type".

I don't get that.
Is it possible you hit the "mtab is evil" (TM Kzak) issue?
  http://karelzak.blogspot.de/2011_04_01_archive.html

Have a nice day,
Berny
