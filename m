Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751052AbeBTKsg (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 20 Feb 2018 05:48:36 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80962402290A
        for <util-linux@vger.kernel.org>; Tue, 20 Feb 2018 10:48:36 +0000 (UTC)
Date: Tue, 20 Feb 2018 11:48:33 +0100
From: Karel Zak <kzak@redhat.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: RFC: watchdog
Message-ID: <20180220104833.iqhixj4vwh34sk6b@ws.net.home>
References: <20180220.161909.2152980892049665100.yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180220.161909.2152980892049665100.yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 20, 2018 at 04:19:09PM +0900, Masatake YAMATO wrote:
> As far as I know, there is no enough popular tool to inspect the
> current status of /dev/watchdog. watchdog device provides ioctl
> commands to return timeout value and timeleft value. The tool
> I assume is reports the values for given device.
> 
> /sys/class/watchdog is provided. However, whether it
> is available or not is up to kernel build-configuration.
> 
> How do you think about adding such tool to util-linux?
> Do you think such command should be in a separate project?
> If the answer is yes, what command name do you prefer to for
> the command? ("watchdog" is not good name).
> 
> If the answer is no, could you tell me a project or person
> I should talk to about this command?

man wdctl :-)

# wdctl
Device:        /dev/watchdog
Identity:      iTCO_wdt [version 0]
Timeout:       30 seconds
Pre-timeout:    0 seconds
Timeleft:       2 seconds
FLAG           DESCRIPTION               STATUS BOOT-STATUS
KEEPALIVEPING  Keep alive ping reply          1           0
MAGICCLOSE     Supports magic close char      0           0
SETTIMEOUT     Set timeout (in seconds)       0           0

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
