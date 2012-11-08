Return-Path: util-linux-owner@vger.kernel.org
Received: from quantum.linuxfromscratch.org ([216.171.237.234]:33945 "EHLO
	quantum.linuxfromscratch.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751505Ab2KHNyo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 8 Nov 2012 08:54:44 -0500
MIME-Version: 1.0
Date: Thu, 8 Nov 2012 6:54:37 -0700
From: Matthew Burgess <matthew@linuxfromscratch.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Discrepancies between real and symlinked mtab
In-Reply-To: <20121108134801.GA1983@x2.net.home>
References: <20121108134801.GA1983@x2.net.home>
Message-ID: <9805a886552733f461b2186bf1911363@quantum.linuxfromscratch.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, 8 Nov 2012 14:48:01 +0100, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Oct 30, 2012 at 11:03:59PM +0000, Matt Burgess wrote:
>> 1) mount(8)
>>
>> /dev/root on / type ext3 (rw,relatime,data=ordered)
> 
>  I have improved libmount and now it returns the real device name if
>  the file /proc/cmdline contains root= option.

Thanks, Karel!

Regards,

Matt.

