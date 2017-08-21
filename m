Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752253AbdHUJcD (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 21 Aug 2017 05:32:03 -0400
Date: Mon, 21 Aug 2017 11:31:58 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 5/6] hwclock: rename/refactor set_system_clock()
Message-ID: <20170821093158.2kmbowciuklu47yc@ws.net.home>
References: <7059c516-6d5f-0579-81be-60b4519f0ce7@gmx.com>
 <ab175fb6-72c2-c3a4-5f72-fa0600c2b13d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ab175fb6-72c2-c3a4-5f72-fa0600c2b13d@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Aug 18, 2017 at 08:23:01PM -0400, J William Piggott wrote:
> 
> Signed-off-by: J William Piggott <elseifthen@gmx.com>
> ---
>  sys-utils/hwclock.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
> index c398d60..4279931 100644
> --- a/sys-utils/hwclock.c
> +++ b/sys-utils/hwclock.c
> @@ -601,12 +601,8 @@ display_time(struct timeval hwctime)
>   *                         * only on first call after boot
>   */
>  static int
> -set_system_clock(const struct hwclock_control *ctl,
> -		 const struct timeval newtime)
> +kernel_time_ctl(const struct hwclock_control *ctl, const struct timeval newtime)

Hmm... the new name does not make the code more readable for me.  

We have "HW-clock" (hc) and "system time", would be nice to keep
this terminology for functions names too? 

IMHO set_system_clock() is not so bad :-) (Maybe use system_set_clock()
if you want to use "system_" prefix for more functions.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
