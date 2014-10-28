Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f169.google.com ([209.85.192.169]:61717 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbaJ1DZV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 27 Oct 2014 23:25:21 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so2571248pdj.28
        for <util-linux@vger.kernel.org>; Mon, 27 Oct 2014 20:25:21 -0700 (PDT)
Received: from [192.168.1.2] ([59.89.143.167])
        by mx.google.com with ESMTPSA id pl3sm186287pbb.50.2014.10.27.20.25.18
        for <util-linux@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 27 Oct 2014 20:25:20 -0700 (PDT)
Message-ID: <544F0C88.1080807@gmail.com>
Date: Tue, 28 Oct 2014 08:54:56 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: fdisk and 2048 sectors obsession.
References: <544E923E.6050406@gmail.com> <544E97ED.7040406@earthlink.net>
In-Reply-To: <544E97ED.7040406@earthlink.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 10/28/14 00:37, Felix Miata wrote:
> dE composed on 2014-10-28 00:13 (UTC+0530):
>
>> I was learning about GPT when I noticed this behavior of fdisk which I
>> never though about before.
>> Regardless of the partition table, fdisk always starts the first
>> partition at 2048. In reality, the maximum size required by the gap
>> between MBR and the 1st partition is a single sector, which's used by
>> GRUB 1.5. GPT doesn't need this space at all.
>> Then extended partitions too have a gap of 2048 sectors.
>> Why this behavior?
> http://www.seagate.com/tech-insights/advanced-format-4k-sector-hard-drives-master-ti/
> may provide some insight WRT performance issues ensuing from other start
> sector selections.

But that works even with multiples of 8. So we can start from sector 8 
in MBR and 40 in GPT.

Also I'm pretty sure fdisk uses 2048 even with -b 4096, but 
unfortunately I get --

*** Error in `fdisk': malloc(): memory corruption: 0x0000000002507330 ***

  with that switch.
