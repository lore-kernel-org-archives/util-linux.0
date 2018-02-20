Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751524AbeBTMMy (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 20 Feb 2018 07:12:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 805C27D85D
        for <util-linux@vger.kernel.org>; Tue, 20 Feb 2018 12:12:54 +0000 (UTC)
Date: Tue, 20 Feb 2018 21:12:52 +0900 (JST)
Message-Id: <20180220.211252.1939053639097649578.yamato@redhat.com>
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org
Subject: Re: RFC: watchdog
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <20180220104833.iqhixj4vwh34sk6b@ws.net.home>
References: <20180220.161909.2152980892049665100.yamato@redhat.com>
        <20180220104833.iqhixj4vwh34sk6b@ws.net.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Oh, thank you.

Masatake YAMATO

> On Tue, Feb 20, 2018 at 04:19:09PM +0900, Masatake YAMATO wrote:
>> As far as I know, there is no enough popular tool to inspect the
>> current status of /dev/watchdog. watchdog device provides ioctl
>> commands to return timeout value and timeleft value. The tool
>> I assume is reports the values for given device.
>> 
>> /sys/class/watchdog is provided. However, whether it
>> is available or not is up to kernel build-configuration.
>> 
>> How do you think about adding such tool to util-linux?
>> Do you think such command should be in a separate project?
>> If the answer is yes, what command name do you prefer to for
>> the command? ("watchdog" is not good name).
>> 
>> If the answer is no, could you tell me a project or person
>> I should talk to about this command?
> 
> man wdctl :-)
> 
> # wdctl
> Device:        /dev/watchdog
> Identity:      iTCO_wdt [version 0]
> Timeout:       30 seconds
> Pre-timeout:    0 seconds
> Timeleft:       2 seconds
> FLAG           DESCRIPTION               STATUS BOOT-STATUS
> KEEPALIVEPING  Keep alive ping reply          1           0
> MAGICCLOSE     Supports magic close char      0           0
> SETTIMEOUT     Set timeout (in seconds)       0           0
> 
>     Karel
> 
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
