Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.187]:59330 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054AbaGGNXI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 7 Jul 2014 09:23:08 -0400
Message-ID: <53BA9DDE.20500@bernhard-voelker.de>
Date: Mon, 07 Jul 2014 15:17:18 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Ruediger Meier <sweet_f_a@gmx.de>
CC: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: fdisk -b segfaults
References: <53BA8537.2090504@bernhard-voelker.de> <201407071451.14305.sweet_f_a@gmx.de>
In-Reply-To: <201407071451.14305.sweet_f_a@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 07/07/2014 02:51 PM, Ruediger Meier wrote:
> On Monday 07 July 2014, Bernhard Voelker wrote:
>> I can't have a look myself right now, because UL's autogen.sh
>> doesn't work here on openSUSE-13.1 anymore.
>
> What is the problem with autogen.sh on openSUSE-13.1?

ah, I had a bad autopoint in ~/bin/ - it was 0.18.3, too,
but different from /usr/bin/autopoint.  I think it was from
the time back last year when older versions had problems.

Thanks & have a nice day,
Berny
