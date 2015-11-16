Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:49928 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbbKPPoB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Nov 2015 10:44:01 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1ZyLwj-0006kg-Bl
	for util-linux@vger.kernel.org; Mon, 16 Nov 2015 16:43:57 +0100
Received: from ip4d14b390.dynamic.kabel-deutschland.de ([77.20.179.144])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 16 Nov 2015 16:43:57 +0100
Received: from for-gmane by ip4d14b390.dynamic.kabel-deutschland.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 16 Nov 2015 16:43:57 +0100
To: util-linux@vger.kernel.org
From: "U.Mutlu" <for-gmane@mutluit.com>
Subject: user namespaces: user mapping
Date: Mon, 16 Nov 2015 16:43:44 +0100
Message-ID: <n2ctjg$1d0$1@ger.gmane.org>
References: <n2besp$j56$1@ger.gmane.org> <20151116041931.GC5949@vapier.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
In-Reply-To: <20151116041931.GC5949@vapier.lan>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mike Frysinger wrote on 11/16/2015 05:19 AM:
> On 16 Nov 2015 03:26, U.Mutlu wrote:
>
>> The other solution via user namespace is IMHO overkill and in my case
>> impractical and irritating because user gets a root-prompt (#)
>> eventhough it is only inside the user namespace.
>
> so remap it to your own user instead of to root

Sorry, I forgot the dangers of mounting into existing mount namespace.
Yes, user namespace seems to be the way to go, so I tried the sample from
man user_namespaces:

$ ./userns_child_exec -v -p -m -U -z bash
./userns_child_exec: PID of child created by clone() is 2950
ERROR: write /proc/2950/gid_map: Operation not permitted
About to exec bash

Am I on the right track with the above method for user remapping?

It's maybe that under Debian another sysctl-setting is needed
for this to work, I'll need to do some research on the net.
If someone here knows the solution let me know pls.



