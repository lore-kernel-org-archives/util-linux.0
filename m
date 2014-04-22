Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f48.google.com ([74.125.82.48]:43108 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbaDVH4R (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Apr 2014 03:56:17 -0400
Received: by mail-wg0-f48.google.com with SMTP id l18so3576507wgh.7
        for <util-linux@vger.kernel.org>; Tue, 22 Apr 2014 00:56:16 -0700 (PDT)
Received: from [172.16.3.2] (91-64-36-142-dynip.superkabel.de. [91.64.36.142])
        by mx.google.com with ESMTPSA id be3sm60702020wjc.5.2014.04.22.00.56.15
        for <util-linux@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Apr 2014 00:56:15 -0700 (PDT)
Message-ID: <5356209E.4040908@ezeep.com>
Date: Tue, 22 Apr 2014 09:56:14 +0200
From: Nicolas <nicolas.delaby@ezeep.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: nsenter: passing command arguments
References: <534F91FD.4020803@ezeep.com> <535052E2.2010705@bernhard-voelker.de>
In-Reply-To: <535052E2.2010705@bernhard-voelker.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 04/18/2014 12:17 AM, Bernhard Voelker wrote:
> On 04/17/2014 10:34 AM, Nicolas wrote:
>> Hi,
>> I'm struggling with nsenter to call commands with options because they
>> are caught by nsenter and complain this is an invalid option.
>>
>> How can I pass any arbitrary argument ?
>>
>> Thanks for reading,
>> Nicolas
>>
>> ```
>> $ nsenter --target $PID --mount --uts --ipc --net --pid ls -a
>> nsenter: invalid option -- 'a'
>
> Use '--' to tell nsenter to stop option parsing:
>    $ nsenter --target $PID --mount --uts --ipc --net --pid -- ls -a
>
> Although I think this can be considered a bug; nsenter should
> do this automatically when seeing the first non-option.

Thank you Bernhard,

It Worked like a charm :)
Have a nice day too.

Nicolas
-- 

Nicolas Delaby · Software Engineer · ezeep.com

ezeep GmbH · Ohlauer Str. 43 · 10999 Berlin · Germany

Registry Court: Charlottenburg · HRB133318 · Managing partner: Sascha 
Kellert
