Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f178.google.com ([74.125.82.178]:39493 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbbBUP24 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 21 Feb 2015 10:28:56 -0500
Received: by wesx3 with SMTP id x3so10554963wes.6
        for <util-linux@vger.kernel.org>; Sat, 21 Feb 2015 07:28:55 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1424518665.2638628.230488493.69A940D7@webmail.messagingengine.com>
References: <20150220100647.GA2624@jue.netz>
	<20150220104106.GB19430@ws.net.home>
	<20150220124436.GA18236@jue.netz>
	<CAG27Bk0UnAhjfyw+EoXZmXXLG+egVFJrDY0cvkGmhFKezY78dQ@mail.gmail.com>
	<1424518665.2638628.230488493.69A940D7@webmail.messagingengine.com>
Date: Sat, 21 Feb 2015 15:28:54 +0000
Message-ID: <CAG27Bk0HQBGK_bhXhRcyxq9QmumMK4mBo402V4HirhRKcssM=g@mail.gmail.com>
Subject: Re: [bug] logger 2.26: regression, option -i not combinable with
 other options
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 21 February 2015 at 11:37, Benno Schulenberg <bensberg@justemail.net> wrote:
> On Fri, Feb 20, 2015, at 21:12, Sami Kerola wrote:
>> Clearly the 'logger -is' should keep on working the same way it always
>> has. Here's my proposal how regression could be fixed.
>>
>> https://github.com/kerolasa/lelux-utiliteetit/commit/bfe6c5d2381b510a4a0330c1c809a63e49b26840
>
> The fix looks fine, of course.  Just about the commit message:
>
> s/loggerit's/logger it's/
> s/options such as:/options, such as -s.  But currently:/
>
> Also, to make the fix complete the -i and -id options have
> to be separated in the usage text and the man page.

Cheers Benno,

Improvements you mentioned are included in

https://github.com/kerolasa/lelux-utiliteetit/commit/87a34e69ff79ef5c2b81cee33902885e2255ac39

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
