Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:54488 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752482AbdDEBDO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 4 Apr 2017 21:03:14 -0400
Subject: Re: [PATCH 3/3] agetty: make --remote to forward --nohostname as -H
 to login
To: kerolasa@gmail.com
References: <20170402081436.861-1-kerolasa@iki.fi>
 <20170402081436.861-3-kerolasa@iki.fi>
 <bb07f30a-74e6-0961-758a-67383ae417bf@gmx.com>
 <CAG27Bk36WxLCGDtWk+WHrK4eDqsjoQcNdc1sKxhpN4BmAEFmWA@mail.gmail.com>
 <CAG27Bk2_YT8jEOrxb4ANwH59CAw-ramfZkpCBDHbAqkkDHOfwQ@mail.gmail.com>
From: J William Piggott <elseifthen@gmx.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-ID: <35c0fb17-6b6e-35df-fe2f-18dd14f3987c@gmx.com>
Date: Tue, 4 Apr 2017 21:03:08 -0400
MIME-Version: 1.0
In-Reply-To: <CAG27Bk2_YT8jEOrxb4ANwH59CAw-ramfZkpCBDHbAqkkDHOfwQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


I don't understand this:

 8< ---

       -o, --login-options "/path/command --option argument -- \u"
              Options   that  are passed to the login program.  \u is replaced
              by the login name.  The default is "/bin/login -- \u".
 8< ---

Is this saying the argument must include the login command? Is that what
"/path/command" represents? If yes, then the second line is incorrect.
If no, then the last sentence is incorrect.


On 04/03/2017 05:20 PM, Sami Kerola wrote:
> On 3 April 2017 at 09:40, Sami Kerola <kerolasa@iki.fi> wrote:
>> On 3 April 2017 at 02:13, J William Piggott <elseifthen@gmx.com> wrote:
>>>
>>> Hey Sami, since you're here you might want to fix this too?
>>
>> Hi JWP,
>>
>> Let me split the change in two:
>>
>> 1. --nohostname option forward + minimal manual change
>> 2. manual page update
>>
>> Karel, please hold on with these three changes. I will push changes to
>> a some branch in my git and tell when the stuff is fast forwardable.
> 
> Here are the updated changes, first one is the minimal option forwarding
> and second tries to make manual page better.
> 
> https://github.com/kerolasa/lelux-utiliteetit/commit/343cc275591327bc2094f88387f09702a542dc8c
> https://github.com/kerolasa/lelux-utiliteetit/commit/c9151874b67a652b7095243fde2203ab8cd7d107
> 
> Branch name is: 2017wk13
> 
