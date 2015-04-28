Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:56264 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965244AbbD1L1N (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 28 Apr 2015 07:27:13 -0400
Message-ID: <553F6E87.8030303@gmx.com>
Date: Tue, 28 Apr 2015 07:27:03 -0400
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Alexey Galakhov <agalakhov@gmail.com>
CC: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] hwclock: flush stdout in hwclock -c
References: <1429197987-8751-1-git-send-email-agalakhov@gmail.com>	<20150427082729.GK27969@ws.net.home>	<553EA9AB.1000608@gmx.com> <20150427234218.587e5435.agalakhov@gmail.com>
In-Reply-To: <20150427234218.587e5435.agalakhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 04/27/2015 05:42 PM, Alexey Galakhov wrote:
> On Mon, 27 Apr 2015 17:27:07 -0400
> J William Piggott <elseifthen@gmx.com> wrote:
> 
>> I do not understand what this patch accomplishes. stdout is line
>> buffered. All of hwclock -c output ends with \n, which flushes
>> the buffer. Then we flush it again with fflush? What am I missing?
> 
> stdout is line buffered only if it is not redirected.

Thanks for the explanation, I wasn't aware of that.

> Using the pipe
> symbol in shell to redirect the output i.e. to awk results in not
> flushing the buffer until it's full.
> 
> A quick test:
> $ hwclock -c | cat
> 
> 
> Regards,
> Alexey
> 
