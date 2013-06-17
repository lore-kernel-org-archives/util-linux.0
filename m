Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f49.google.com ([209.85.160.49]:35225 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971Ab3FQUO6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 17 Jun 2013 16:14:58 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so3107166pbb.22
        for <util-linux@vger.kernel.org>; Mon, 17 Jun 2013 13:14:58 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20130617123120.GC20507@x2.net.home>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
	<20130617123120.GC20507@x2.net.home>
Date: Mon, 17 Jun 2013 21:14:57 +0100
Message-ID: <CAG27Bk0yGz5nk91BxsE+VE+xnnUmJPVWZPm6L7ki+vkZHe6HSQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] pull: sfdisk and dmesg resubmission, plus bits and bobs
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 17 June 2013 13:31, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Jun 16, 2013 at 07:53:41PM +0100, Sami Kerola wrote:
>> Unfortunately the most troubling dmesg patch is now dropped by me.  I had
>> a look how systemd determines boot time, and it seem very early at
>> execution clock_gettime() is called, and results are saved.  If dmesg
>> should agree with systemd when startup happen I see two possible options;
>>
>> 1. Make dmesg to get system startup time from systemd using dbus.
>>
>> 2. Make both dmesg and systemd to ask start up time from kernel.
>>
>> I feel first option is not great.  The systemd boot time stamp is similar
>> sort of approximation as reading fstat from /proc/1.  Also asking when
>> system started from system itself feels more neutral than consulting a
>> software the system started.
>>
>> If the second option is favored a kernel patch, such as the one below, is
>> needed and a bit coordination to make various programs to use the
>> boottime from kernel.  Meanwhile it migth be fine that differnt programs
>> using differnet time stamps for klog messages.
>
>  Note that the current dmesg(1) code uses sysinfo(2) which provides
>  uptime in seconds. It would be probably better to use /proc/uptime
>  where is uptime in sec.xx precision.

I am aware of the sysinfo()'s limit to one second, which originally
started to annoy me.

http://markmail.org/message/zjp43ecruh5vduza

Unfortunately I were a bit vague what seems to be the problem. With
one second uptime resolution the seconds will start to flicker due
rounding error/feature. If uptime value is less precise than delta
time the small numbers of delta time start to affect rounding time
dependant way. Because of this rounding happening the way it does I
guess it is almost impossible to have all dmesg time stamps such way
that the following would not differ.

diff -q <(dmesg --ctime) <(sleep 0.5 ; dmesg --ctime)

I gave a shot to /proc/uptime value, and with it the new ISO 8601
format differed less than with just a second precision. But, IMHO,
having time stamps to flicker at all is not correct. Unstable output
will also cause trouble if someone intends to analyse system log with
for example logstash.

>> Any opinions about klog time stamps?
>>
>>
>> --- a/kernel/ksysfs.c
>> +++ b/kernel/ksysfs.c
>> @@ -157,6 +157,16 @@ static ssize_t rcu_expedited_store(struct kobject
>> *kobj,
>>  }
>>  KERNEL_ATTR_RW(rcu_expedited);
>>
>> +/* High precision timestamp of the system boot. */
>> +static ssize_t boottime_show(struct kobject *kobj,
>> +                            struct kobj_attribute *attr, char *buf)
>> +{
>> +       struct timespec ts;
>> +       getboottime(&ts);
>> +       return sprintf(buf, "%ld.%ld\n", ts.tv_sec, ts.tv_nsec);
>> +}
>> +KERNEL_ATTR_RO(hp_uptime);
>> +
>>  /*
>>   * Make /sys/kernel/notes give the raw contents of our kernel .notes
>>   * section.
>>   */
>> @@ -197,6 +207,7 @@ static struct attribute * kernel_attrs[] = {
>>         &vmcoreinfo_attr.attr,
>>  #endif
>>         &rcu_expedited_attr.attr,
>> +       &hp_uptime_attr.attr,
>>         NULL
>>  };
>
>  Would be better to use /proc (where is 'uptime' file) rather than
>  /sys/kernel ?

Isn't the /sys new /proc? More seriously, I don't mind to where the
value is added if the idea itself is generally accepted as a
reasonable solution.

--
   Sami Kerola
   http://www.iki.fi/kerolasa/
