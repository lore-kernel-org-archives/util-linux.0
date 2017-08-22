Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932205AbdHVJFB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 22 Aug 2017 05:05:01 -0400
Date: Tue, 22 Aug 2017 11:04:57 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 5/6] hwclock: rename/refactor set_system_clock()
Message-ID: <20170822090457.xd65avktdmp6z76e@ws.net.home>
References: <7059c516-6d5f-0579-81be-60b4519f0ce7@gmx.com>
 <ab175fb6-72c2-c3a4-5f72-fa0600c2b13d@gmx.com>
 <20170821093158.2kmbowciuklu47yc@ws.net.home>
 <113d8ff2-e593-675b-5ef2-21e15d5cea98@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <113d8ff2-e593-675b-5ef2-21e15d5cea98@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 21, 2017 at 08:56:41AM -0400, J William Piggott wrote:
> 
> 
> On 08/21/2017 05:31 AM, Karel Zak wrote:
> > On Fri, Aug 18, 2017 at 08:23:01PM -0400, J William Piggott wrote:
> >>
> >> Signed-off-by: J William Piggott <elseifthen@gmx.com>
> >> ---
> >>  sys-utils/hwclock.c | 24 +++++++++---------------
> >>  1 file changed, 9 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
> >> index c398d60..4279931 100644
> >> --- a/sys-utils/hwclock.c
> >> +++ b/sys-utils/hwclock.c
> >> @@ -601,12 +601,8 @@ display_time(struct timeval hwctime)
> >>   *                         * only on first call after boot
> >>   */
> >>  static int
> >> -set_system_clock(const struct hwclock_control *ctl,
> >> -		 const struct timeval newtime)
> >> +kernel_time_ctl(const struct hwclock_control *ctl, const struct timeval newtime)
> > 
> > Hmm... the new name does not make the code more readable for me.  
> > 
> > We have "HW-clock" (hc) and "system time", would be nice to keep
> > this terminology for functions names too? 
> 
> I've been moving away from the term 'Hardware Clock' in favor of RTC
> because:
>  * use of /dev/rtcN is the only recommended access now
>  * RTC seems more common (anecdotal observation)
>  * it is more concise for usage() and docs

RTC is fine.

> > IMHO set_system_clock() is not so bad :-) (Maybe use system_set_clock()
> > if you want to use "system_" prefix for more functions.)
> 
> My thinking was that this function does important things besides setting
> the system time. It also sets the kernel's RTC timescale and the
> kernel's timezone. For systz it never sets the system time at all. So
> the current name seems misleading.

kernel_time_ctl() does not inform reader about any operation, as there
is no "set", "get", "read", "manipulate" or so in the name.

> It doesn't matter to me, I was changing it to help others. Do you want me
> to put it back to set_system_clock?

Please, or try something better (set_time(), set_kernel_time(), ...).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
