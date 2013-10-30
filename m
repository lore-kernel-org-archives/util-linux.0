Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.8]:60350 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab3J3PkA convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 30 Oct 2013 11:40:00 -0400
Date: Wed, 30 Oct 2013 16:39:57 +0100 (CET)
From: Bernhard Voelker <mail@bernhard-voelker.de>
Reply-To: Bernhard Voelker <mail@bernhard-voelker.de>
To: Phillip Susi <psusi@ubuntu.com>, util-linux@vger.kernel.org
Message-ID: <1530541679.232932.1383147597747.open-xchange@email.1und1.de>
In-Reply-To: <527122AF.90003@ubuntu.com>
References: <527122AF.90003@ubuntu.com>
Subject: Re: Bind mounts record fstype of none
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



> On October 30, 2013 at 4:15 PM Phillip Susi <psusi@ubuntu.com> wrote:
> I came across an old bug filed in debian noting that mount records the
> fstype for bind mounts as 'none' and this causes df to suppress
> showing it.  This seems like an error to me.  The type should be what
> the actual filesystem type is, and if df wants to suppress showing
> bind mounts, it should do so based on the bind flag.
>
> Thoughts?

yes, df(1) is from coreutils. ;-)

However, latest df(1) will skip such bind mounts per default - but
now because of some 'bind' information (which is not available
anyway), but just because it skips "duplicates" based on the device
numbers. For the same device number, it will output that with the
shortest mount point name.
You have to use -a to see all.

Have a nice day,
Berny
