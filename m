Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.131]:45133 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbeJDRH4 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 4 Oct 2018 13:07:56 -0400
Subject: Re: [PATCH 1/2] unshare: allow to set a new root
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <20180928124512.13979-1-laurent@vivier.eu>
 <20180928124512.13979-2-laurent@vivier.eu>
 <20181004101112.2542qy4di4sykelp@ws.net.home>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <fd5c5d6d-8e65-ddfd-f07f-832c9baab53f@vivier.eu>
Date: Thu, 4 Oct 2018 12:15:15 +0200
MIME-Version: 1.0
In-Reply-To: <20181004101112.2542qy4di4sykelp@ws.net.home>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Le 04/10/2018 à 12:11, Karel Zak a écrit :
> On Fri, Sep 28, 2018 at 02:45:11PM +0200, Laurent Vivier wrote:
>> +	if (newroot) {
>> +		if (chroot(newroot) != 0)
>> +			err(EXIT_FAILURE,
>> +			    _("cannot change root directory to '%s'"), newroot);
>> +		if (chdir(newdir))
>> +			err(EXIT_FAILURE, _("cannot chdir to '%s'"), newdir);
>> +	}
> 
> It means that --wd is usable only when --root is specified. Is it
> expected? Would be better to use

Yes, the idea was to switch to a working directory in the chroot case.

But if you think it can be useful to switch to another directory on the
non-chroot case, I can upgrade the patch as you say.

Thanks,
Laurent
>  char *newdir = NULL;
> 
>  while ((c = getopt_long(....))) {
>     ...
>     case 'w':
>         newdir = optarg;
>         break;
>  }
>  ...
> 
>  if (newroot) {
>     if (chroot(newroot))
>         ... error ...
>     if (chdir(newdir ? newdir : "/"))
>         ... error ...
> 
>  } else if (newdir && chdir(newdir))
>     ... error ...
> 
> 
>     Karel
> 
