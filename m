Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:60583 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751851AbdGAQHo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 1 Jul 2017 12:07:44 -0400
Subject: Re: 0b2b32e8a7 caused an unusual increase in hwclock size
To: util-linux <util-linux@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>, Ruediger Meier <sweet_f_a@gmx.de>
References: <bbb77383-8a90-b1b1-0dfa-78cee5fb6267@gmx.com>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <919e5992-abd9-b66c-5799-833c594cece1@gmx.com>
Date: Sat, 1 Jul 2017 12:07:24 -0400
MIME-Version: 1.0
In-Reply-To: <bbb77383-8a90-b1b1-0dfa-78cee5fb6267@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On 06/30/2017 04:41 PM, J William Piggott wrote:
> 
> Does anyone know why this small change added 43K (+23%) to the binary?

I'm no compiler guru, but it appears to me that gcc is smart enough to
exclude the unused strutils.h file without using '#if defined', and this
new code pulls it in.

So as I said when reviewing the commit, the new code needs to be in:
#if defined(__linux__) && defined(__alpha__)
https://marc.info/?l=util-linux-ng&m=149830453215524&w=2

After doing so the unused fat is no longer in the binary. I'm a bit
surprised that strutils adds 43K though.

Then adding '#if defined' to the header include actually made the binary
32 bytes larger. The striped binary was unchanged.

I'm going to submit a patch to remove strutils from hwclock, but this
information might apply to other commands that were changed?

> 
> 222802 2017-06-30 15:55:54 hwclock-0b2b32e*
> 180175 2017-06-30 16:06:12 hwclock-9c8b9fb*
> 
> 
> commit 0b2b32e8a7a6aed1e3ff1cfc3f63cf33361a67b8
> 
> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
> index 5433cd0..325106a 100644
> --- a/sys-utils/hwclock.c
> +++ b/sys-utils/hwclock.c
> @@ -1326,6 +1326,8 @@ int main(int argc, char **argv)
>         };
>         int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
>  
> +       strutils_set_exitcode(EX_USAGE);
> +
>         /* Remember what time we were invoked */
>         gettimeofday(&startup_time, NULL);
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
