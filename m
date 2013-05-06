Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-da0-f51.google.com ([209.85.210.51]:64321 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab3EFKoK convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 May 2013 06:44:10 -0400
Received: by mail-da0-f51.google.com with SMTP id h15so1711887dan.24
        for <util-linux@vger.kernel.org>; Mon, 06 May 2013 03:44:10 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <5186F533.2060905@draigBrady.com>
References: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
	<1367520701-14962-10-git-send-email-kerolasa@iki.fi>
	<5186F533.2060905@draigBrady.com>
Date: Mon, 6 May 2013 11:44:10 +0100
Message-ID: <CAG27Bk19HRiqgdOr=wwVCBw0VOoUEbT-V6ZpcZKH48-Kfv0UrQ@mail.gmail.com>
Subject: Re: [PATCH 09/16] cal: add --highligth option which uses argmatch
From: Sami Kerola <kerolasa@iki.fi>
To: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigbrady.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 6 May 2013 01:11, Pádraig Brady <P@draigbrady.com> wrote:

Hi Pádraig,

> I'd have it as an optional arg, defaulting to auto.

Good point. That would result to more consistent interface, which is a
virtue in itself.

>> +     case HIGHLIGHT_ALWAYS:
>> +             if (day == 0)
>> +                     day = local_time->tm_yday + 1;;
>
> s/;;/;/ shellism :)

Oops, I will push a fix to my git within next 48 hours. I have slight
problem with my programming environment at the moment which I need to
sort out first.

>> +             break;
>> +     default:
>> +             abort();
>> +     }
>>
>>       if (yflag)
>>               yearly(day, year, julian);
>>
>
> s/highligth/highlight/ in the subject line

Oh dear, me and my finglish.

> Also I'd s/--highlight/--color/ to align with dmesg and other utils.
> Only highlighting is done at present, but that could be set up
> to use color in the user's environment.  Also in future other parts
> of the output could be colored etc.
>
> BTW, dmesg could get the same support for specifying "always" and "never".

Karel earlier mentioned the same, and I wrote some sort of change
which will add --when to dmesg. Allowing user to choose dmesg colors
etc highlights using facilities & priorities as criteria would
probably be quite neat feature.

--
   Sami Kerola
   http://www.iki.fi/kerolasa/
