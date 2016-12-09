Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:54626 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933045AbcLICJj (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 8 Dec 2016 21:09:39 -0500
Subject: Re: [PATCH 1/2] Revert "hwclock: don't allow non-root access"
To: marian.vomir@ni.com, Karel Zak <kzak@redhat.com>
References: <1481047580-28284-1-git-send-email-marian.vomir@ni.com>
 <c0ddbe5a-caa4-c8ad-0d86-9b13c3277edc@gmx.com>
 <20161207112541.2g3trc26tcvcghio@ws.net.home>
 <58498435.6715.66655AF@marian.vomir.ni.com>
From: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Message-ID: <269f09de-6a3f-5eaf-be4c-a9ca37e38403@gmx.com>
Date: Thu, 8 Dec 2016 21:09:28 -0500
MIME-Version: 1.0
In-Reply-To: <58498435.6715.66655AF@marian.vomir.ni.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 12/08/2016 11:03 AM, marian.vomir@ni.com wrote:
> Should user space utilities be checking permissions?
> Is that not the role of the kernel?
> 
> Why the difference between setting the hardware clock and setting the 
> system time?

I think this is a valid point, Marian. One System Clock analog is
coreutils date(1) command. It can set the System Clock, which is
arguably a worse thing to do on a running system then setting he
Hardware Clock, and it does not make any permission checks. It simply
allows anyone to run it and relies on the system being configured to
block a normal user from setting it:

 $ date 01010000
date: cannot set date: Operation not permitted
Fri Jan  1 00:00:00 EST 2016

It is not a utilities job to babysit the system administrator. Nor
should it dictate what the administrator is allowed to do.

I said previously that hwclock(8) historically has never allowed system
altering functions to anyone accept root... but that does not necessarily
make it the correct thing to do.


> A normal user can set the system time from any binary 
> with CAP_SYS_TIME, and a normal user can reboot, and rebooting on 
> some distros (eg. Ubuntu) updates the hardware clock from the system 
> time from an init script. So there is still a way around the 
> restriction in these distros.
> 
> Or is a user with CAP_SYS_TIME not considered "normal"?
> 
> 
> On 7 Dec 2016 at 12:25, Karel Zak wrote:
> 
>> On Tue, Dec 06, 2016 at 06:40:32PM -0500, J William Piggott wrote:
>>>
>>>
>>> On 12/06/2016 01:06 PM, Marian Vomir wrote:
>>>> This reverts commit 687cc5d58942b24a9f4013c68876d8cbea907ab1.
>>>>
>>>> There are cases when an unprivileged user wants to set the hardware clock.
>>>
>>> This has never been allowed in over two decades of hwclock. I cannot
>>> think of a legitimate reason to allow setting the Hardware Clock by a
>>> normal user.
>>
>> Yes. It seems Marian has missed the goal of the commit
>> 687cc5d58942b24a9f4013c68876d8cbea907ab1. It's not about permissions
>> detection. 
>>
>> We don't want to support use-case where hwclock(8) has extra
>> permissions (setuid or CAP_<something>) to set system time. The binary
>> is not designed for this purpose and it does not make sense to support
>> it -- less utils with extra permissions is better.
>>
>>> Having said that, while I agree with Karel's desire to remove all
>>> mention of running hwclock with setuid, IMO the code should not have
>>> been removed. Despite the comment directly above it, that code has
>>> nothing to do with hwclock being run with setuid.
>>
>> Maybe my patch seems too strict, but change docs is not enough, the
>> code matters. We want to be sure nobody uses hwclock as setuid,
>> especially if man page and code comments promised this non-sense.
>>
>>> I would argue that there are some hwclock options intended for normal
>>> users. A normal users should at least be able to display the Hardware
>>> Clock time.
>>
>> We can change it to support --show for non-root users, but the
>> question is if such change will have any practical effect, because for
>> example on Fedora we have:
>>
>>   $ ll /dev/rtc0
>>   crw------- 1 root root 251, 0 Nov 28 10:46 /dev/rtc0
>>
>> so
>>
>>   $ hwclock --debug --show
>>   hwclock from util-linux 2.29.44-a99c0
>>   hwclock: cannot open /dev/rtc: Permission denied
>>   No usable clock interface found.
>>   hwclock: Cannot access the Hardware Clock via any known method.
>>
>> with the untested patch below. IMHO it's waste of time to try to be
>> smart in this area... ;-)
>>
>>     Karel
>>
>>
>>
>> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
>> index 21caeb2..ede6cfa 100644
>> --- a/sys-utils/hwclock.c
>> +++ b/sys-utils/hwclock.c
>> @@ -1859,11 +1859,6 @@ int main(int argc, char **argv)
>>  	argc -= optind;
>>  	argv += optind;
>>  
>> -	if (getuid() != 0) {
>> -		warnx(_("Sorry, only the superuser can use the Hardware Clock."));
>> -		hwclock_exit(EX_NOPERM);
>> -	}
>> -
>>  #ifdef HAVE_LIBAUDIT
>>  	if (testing != TRUE) {
>>  		if (adjust == TRUE || hctosys == TRUE || systohc == TRUE ||
>> @@ -1906,6 +1901,11 @@ int main(int argc, char **argv)
>>  		show = 1;	/* default to show */
>>  
>>  
>> +	if (!show && getuid() != 0) {
>> +		warnx(_("Sorry, only --show is allowed for non-root users."));
>> +		hwclock_exit(EX_NOPERM);
>> +	}
>> +
>>  #ifdef __linux__
>>  	if (getepoch || setepoch) {
>>  		manipulate_epoch(getepoch, setepoch, epoch_option, testing);
>>
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
