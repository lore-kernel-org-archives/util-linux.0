Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33326 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360AbbBTUMN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 20 Feb 2015 15:12:13 -0500
Received: by mail-wi0-f174.google.com with SMTP id em10so5405432wid.1
        for <util-linux@vger.kernel.org>; Fri, 20 Feb 2015 12:12:12 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20150220124436.GA18236@jue.netz>
References: <20150220100647.GA2624@jue.netz>
	<20150220104106.GB19430@ws.net.home>
	<20150220124436.GA18236@jue.netz>
Date: Fri, 20 Feb 2015 20:12:12 +0000
Message-ID: <CAG27Bk0UnAhjfyw+EoXZmXXLG+egVFJrDY0cvkGmhFKezY78dQ@mail.gmail.com>
Subject: Re: [bug] logger 2.26: regression, option -i not combinable with
 other options
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 20 February 2015 at 12:44, Juergen Daubert <jue@jue.li> wrote:
> On Fri, Feb 20, 2015 at 11:41:06AM +0100, Karel Zak wrote:
>> On Fri, Feb 20, 2015 at 11:06:47AM +0100, Juergen Daubert wrote:
>> > with logger from util-linux 2.25.x it's possible to combine the option
>> > -i with other options like:
>> >
>> >  logger -is
>> >
>> > with 2.26 I get the following error message:
>> >
>> >  $:~> logger -is
>> >  logger: failed to parse id: 's'
>> >
>> > The changed behaviour breaks existing scripts like dhcpcd-run-hooks [1]
>> > from dhcpcd [2].
>>
>> Hmm... stupid regression, next time it would be probably better to
>> introduce optional arguments for long options only.

I agree about both; stupid regression and the --id should not be mixed
with -i option.

>> Anyway, always use long options in scripts. It's more robust and more
>> readable.
>
> here's the response from dhcpcd's author:
>
>  The original BSD sources from which logger is clearly based don't support
>  long options .... and dhcpcd needs to work with them.

Technically speaking assigning short options is against POSIX.

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/logger.html

But removing short options would be so user unfriendly that proposing
such change would lead to immediate tosspot of the year nomination.
Clearly the 'logger -is' should keep on working the same way it always
has. Here's my proposal how regression could be fixed.

https://github.com/kerolasa/lelux-utiliteetit/commit/bfe6c5d2381b510a4a0330c1c809a63e49b26840

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
