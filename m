Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f51.google.com ([209.85.160.51]:64093 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbaCKMNV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 11 Mar 2014 08:13:21 -0400
Received: by mail-pb0-f51.google.com with SMTP id uo5so8720300pbc.38
        for <util-linux@vger.kernel.org>; Tue, 11 Mar 2014 05:13:20 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <531EB96C.4040500@bernhard-voelker.de>
References: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
	<1394397023-7050-6-git-send-email-kerolasa@iki.fi>
	<531EB96C.4040500@bernhard-voelker.de>
Date: Tue, 11 Mar 2014 07:13:20 -0500
Message-ID: <CAG27Bk30eyRtTTKkyJ293Cmjv=BWn7KF+D0HtD1D5zdvr5wRuw@mail.gmail.com>
Subject: Re: [PATCH 06/10] kill: leeway deprecation of --pid invocation as
 command name
From: Sami Kerola <kerolasa@iki.fi>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 11 March 2014 02:21, Bernhard Voelker <mail@bernhard-voelker.de> wrote:
> On 03/09/2014 09:30 PM, Sami Kerola wrote:
>> diff --git a/misc-utils/kill.c b/misc-utils/kill.c
>> index 2fecda3..11c8cd2 100644
>> --- a/misc-utils/kill.c
>> +++ b/misc-utils/kill.c
>> @@ -170,6 +170,8 @@ int main(int argc, char **argv)
>>
>>       numsig = SIGTERM;
>>       do_pid = (!strcmp(program_invocation_short_name, "pid"));       /* Yecch */
>> +     if (do_pid)
>> +             warnx(_("use of 'kill --pid' option as command name will be deprecated in future"));
>
> You deprecate now:
>   s/will .* future/is deprecated/
>
>
> Another minor note:
> Shouldn't there be something like a
>
>   +  /* FIXME: remove in March 2016.  */
>
> together with deprecations like that?
> It would be easier to find and fix then.

Hi Bernhard,

Thank you for comment. Now when I think about deprecation it does
happen immediately, while removal follows later. Both the time change,
and FIXME are available in github, with corrections to two later
commits are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2014wk09

for you to fetch changes up to 2b0dda54bda3ecd24ca1de4cfd7eb662438204cc.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
