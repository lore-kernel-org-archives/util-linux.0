Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:52315 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab2FSOqy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 19 Jun 2012 10:46:54 -0400
Message-ID: <4FE090DC.80304@bernhard-voelker.de>
Date: Tue, 19 Jun 2012 16:46:52 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Marcos Felipe Rasia de Mello <marcosfrm@gmail.com>,
        util-linux@vger.kernel.org
Subject: Re: lsblk "include" option?
References: <CAJZVDJCK3Z_u_2TYrFMdjhjNXAJgW2C9rGnwv4RdEkcca92C7Q@mail.gmail.com> <20120619142627.GA14727@x2.net.home>
In-Reply-To: <20120619142627.GA14727@x2.net.home>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 06/19/2012 04:26 PM, Karel Zak wrote:
> On Fri, Jun 15, 2012 at 10:09:16AM -0300, Marcos Felipe Rasia de Mello wrote:
>> lsblk has an "exclude" (-e, --exclude) option. I wonder if would be
>> possible to add an "include" option to tell it to show *only*
>> specified major number devices. Like
>>
>> lsblk -i 8
> 
>  Implemented (--include, -I)


> diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
> index f635a4a..0bcdbfc 100644
> --- a/misc-utils/lsblk.c
> +++ b/misc-utils/lsblk.c
> @@ -142,7 +142,7 @@ static struct colinfo infos[] = {
>  
>  struct lsblk {
>         struct tt *tt;                  /* output table */
> -       unsigned int all_devices:1;     /* print all devices */
> +       unsigned int all_devices:1;     /* print all devices, icluding empty */

s/icluding/including/

> @@ -1116,6 +1159,7 @@ static void __attribute__((__noreturn__)) help(FILE *out)
>                 " -d, --nodeps         don't print slaves or holders\n"
>                 " -D, --discard        print discard capabilities\n"
>                 " -e, --exclude <list> exclude devices by major number (default: RAM disks)\n"
> +               " -i, --include <list> show only devices with specified major numbers\n"

s/-i/-I/


BTW: the <list> does not necessarily have to be comma separated;
e.g. a dot also works: "lsblk -I 8.11". The same applies to "-e",
of course.

Have a nice day,
Berny
