Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:53191 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755234AbdDEPYe (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 5 Apr 2017 11:24:34 -0400
Subject: Re: [PATCH 3/3] agetty: make --remote to forward --nohostname as -H
 to login
To: Karel Zak <kzak@redhat.com>
References: <20170402081436.861-1-kerolasa@iki.fi>
 <20170402081436.861-3-kerolasa@iki.fi>
 <bb07f30a-74e6-0961-758a-67383ae417bf@gmx.com>
 <CAG27Bk36WxLCGDtWk+WHrK4eDqsjoQcNdc1sKxhpN4BmAEFmWA@mail.gmail.com>
 <CAG27Bk2_YT8jEOrxb4ANwH59CAw-ramfZkpCBDHbAqkkDHOfwQ@mail.gmail.com>
 <35c0fb17-6b6e-35df-fe2f-18dd14f3987c@gmx.com>
 <20170405085151.beeuqeovoqrkumjx@ws.net.home>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <f1bf7cee-1cf3-6ac9-1ba9-7c604ea7f1f5@gmx.com>
Date: Wed, 5 Apr 2017 11:24:23 -0400
MIME-Version: 1.0
In-Reply-To: <20170405085151.beeuqeovoqrkumjx@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 04/05/2017 04:51 AM, Karel Zak wrote:
> On Tue, Apr 04, 2017 at 09:03:08PM -0400, J William Piggott wrote:
>>
>> I don't understand this:
>>
>>  8< ---
>>
>>        -o, --login-options "/path/command --option argument -- \u"
>>               Options   that  are passed to the login program.  \u is replaced
>>               by the login name.  The default is "/bin/login -- \u".
>>  8< ---
>>
>> Is this saying the argument must include the login command? Is that what
>> "/path/command" represents? If yes, then the second line is incorrect.
>> If no, then the last sentence is incorrect.
> 
> from code:
> 
>     login_argv[login_argc++] = options.login; 
>     ...
> 
>     login_options_to_argv(login_argv, &login_argc,
>                         options.logopt, username);
>     ...
>     execv(options.login, login_argv);
> 
> 
> where:
>     options.login is --login-program
>     login-options is --login-options
> 
> so the man page is wrong, --login-options should be without the path.
> 
> I'll fix it.

The man-page quote is from Sami's working branch (which I'm reviewing).

PS It looks like your email didn't make it to the list for some reason.

> 
>     Karel
> 
