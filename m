Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ve0-f172.google.com ([209.85.128.172]:51449 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556AbaEFMGT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 6 May 2014 08:06:19 -0400
Received: by mail-ve0-f172.google.com with SMTP id oz11so2718496veb.17
        for <util-linux@vger.kernel.org>; Tue, 06 May 2014 05:06:18 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20140506092650.GC5962@x2.net.home>
References: <1398847941.19293.112034049.7CA00422@webmail.messagingengine.com>
	<CAG27Bk0A3cHh1v6Q6yPOqorZ8AkxpxRr3rj_jCnW8NB=FcsmKQ@mail.gmail.com>
	<20140506092650.GC5962@x2.net.home>
Date: Tue, 6 May 2014 13:06:18 +0100
Message-ID: <CAG27Bk111VDqEXCPeOxPyC7uyXFf+9EWTDi7Z1EaT45SiH63Aw@mail.gmail.com>
Subject: Re: cytune: misnamed long options
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 6 May 2014 10:26, Karel Zak <kzak@redhat.com> wrote:
> On Wed, Apr 30, 2014 at 12:25:49PM +0100, Sami Kerola wrote:
>> On 30 April 2014 09:52, Benno Schulenberg <bensberg@justemail.net> wrote:
>> > According to the code and the man page of cytune, the option -g
>> > shows the current values of the threshold and the flush timeout,
>> > and option -G shows the default values.  But the corresponding
>> > long options of those two are: --get-threshold and --get-flush.
>> > Confusing.  Shouldn't those be changed to --get-current and
>> > --get-defaults?  (Or the first one maybe just --get?)  However,
>> > the docs say not to change any options.  What to do?  Sami?
>>
>> Hi Benno,
>>
>> The recommendation never to change options tries to protect a Random J
>> Developer in breaking existing scripts. If options are deprecated at
>> least there should be a backwards compatibility with a deprecation
>> warning for some time (couple years).
>>
>> Looking the kernel interface
>>
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/cyclades.c#n2639
>>
>> the 'threshold' keyword seems to be ok. Use of word 'flush' is a bit
>> odd, and 'timeout' would be closer match with what the kernel is
>> doing. Karel, are you OK with s/flush/timeout/ ABI change?
>
>  NACK, it seems better to be backwardly compatible than perfect.

The NACK seems to indicate the change

https://github.com/kerolasa/lelux-utiliteetit/commit/2453ab9f64de49bb5a1b9a0bcd3653cd761a22b2

should not warnx(), nor be marked deprecated. Or to say other way, the
old long options should be silently accepted until end of universe.
Let me fix that (later the day when I'm not in office).

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
