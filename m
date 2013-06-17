Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43128 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753995Ab3FQMbb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 17 Jun 2013 08:31:31 -0400
Date: Mon, 17 Jun 2013 14:31:20 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/15] pull: sfdisk and dmesg resubmission, plus bits and
 bobs
Message-ID: <20130617123120.GC20507@x2.net.home>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 16, 2013 at 07:53:41PM +0100, Sami Kerola wrote:
> Unfortunately the most troubling dmesg patch is now dropped by me.  I had
> a look how systemd determines boot time, and it seem very early at
> execution clock_gettime() is called, and results are saved.  If dmesg
> should agree with systemd when startup happen I see two possible options;
> 
> 1. Make dmesg to get system startup time from systemd using dbus.
> 
> 2. Make both dmesg and systemd to ask start up time from kernel.
> 
> I feel first option is not great.  The systemd boot time stamp is similar
> sort of approximation as reading fstat from /proc/1.  Also asking when
> system started from system itself feels more neutral than consulting a
> software the system started.
> 
> If the second option is favored a kernel patch, such as the one below, is
> needed and a bit coordination to make various programs to use the
> boottime from kernel.  Meanwhile it migth be fine that differnt programs
> using differnet time stamps for klog messages.

 Note that the current dmesg(1) code uses sysinfo(2) which provides
 uptime in seconds. It would be probably better to use /proc/uptime
 where is uptime in sec.xx precision.

> Any opinions about klog time stamps?
> 
> 
> --- a/kernel/ksysfs.c
> +++ b/kernel/ksysfs.c
> @@ -157,6 +157,16 @@ static ssize_t rcu_expedited_store(struct kobject
> *kobj,
>  }
>  KERNEL_ATTR_RW(rcu_expedited);
>  
> +/* High precision timestamp of the system boot. */
> +static ssize_t boottime_show(struct kobject *kobj,
> +                            struct kobj_attribute *attr, char *buf)
> +{
> +       struct timespec ts;
> +       getboottime(&ts);
> +       return sprintf(buf, "%ld.%ld\n", ts.tv_sec, ts.tv_nsec);
> +}
> +KERNEL_ATTR_RO(hp_uptime);
> +
>  /*
>   * Make /sys/kernel/notes give the raw contents of our kernel .notes
>   * section.
>   */
> @@ -197,6 +207,7 @@ static struct attribute * kernel_attrs[] = {
>         &vmcoreinfo_attr.attr,
>  #endif
>         &rcu_expedited_attr.attr,
> +       &hp_uptime_attr.attr,
>         NULL
>  };

 Would be better to use /proc (where is 'uptime' file) rather than
 /sys/kernel ?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
