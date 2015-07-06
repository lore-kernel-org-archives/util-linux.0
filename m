Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f48.google.com ([209.85.218.48]:35255 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492AbbGFS6N (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Jul 2015 14:58:13 -0400
Received: by oihr66 with SMTP id r66so68884759oih.2
        for <util-linux@vger.kernel.org>; Mon, 06 Jul 2015 11:58:12 -0700 (PDT)
Received: from [192.168.0.75] (cpe-70-123-244-133.satx.res.rr.com. [70.123.244.133])
        by mx.google.com with ESMTPSA id y5sm10440920oes.15.2015.07.06.11.58.11
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2015 11:58:12 -0700 (PDT)
Message-ID: <559ACFC3.6050303@gmail.com>
Date: Mon, 06 Jul 2015 13:58:11 -0500
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: Reprompt once the network addresses
 change if address displayed
References: <1435928288-25644-1-git-send-email-stefw@redhat.com> <20150706140711.GF17734@vapier>
In-Reply-To: <20150706140711.GF17734@vapier>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mike Frysinger wrote:
> On 03 Jul 2015 14:58, Stef Walter wrote:
>    #ifdef AGETTY_RELOAD
>>   # include <sys/inotify.h>
>> +# include <linux/netlink.h>
>> +# include <linux/rtnetlink.h>
>
> why not use libmnl instead ?
> 	http://netfilter.org/projects/libmnl

That would not work for the LinuxFromScratch project.  At the time 
util-linux is built, libmnl is not available.

   -- Bruce


