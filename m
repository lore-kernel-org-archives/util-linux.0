Return-Path: linux-kernel-owner@vger.kernel.org
Message-ID: <4FE2F51C.1060106@gmail.com>
Date: Thu, 21 Jun 2012 18:19:08 +0800
From: "gnehzuil.lzheng@gmail.com" <gnehzuil.lzheng@gmail.com>
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
CC: Sami Kerola <kerolasa@gmail.com>, Sami Kerola <kerolasa@iki.fi>,
        Jens Axboe <axboe@kernel.dk>,
        Bernhard Voelker <mail@bernhard-voelker.de>,
        Zheng Liu <wenqing.lz@taobao.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, util-linux@vger.kernel.org
Subject: Re: [PATCH] docs: block: update ioprio.txt
References: <1340095897-9014-1-git-send-email-wenqing.lz@taobao.com> <CAG27Bk2tXprRfMfYOVdWtwSbjw5Rw9Kxs6Wns+Gm65m3hoJawg@mail.gmail.com> <20120619102706.GA9273@gmail.com> <4FE2A825.1060103@landley.net>
In-Reply-To: <4FE2A825.1060103@landley.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 06/21/2012 12:50 PM, Rob Landley wrote:

> On 06/19/2012 05:27 AM, Zheng Liu wrote:
>> Hi Sami,
>>
>> [You forgot to CC'd other developers and mailing list]
>>
>> On Tue, Jun 19, 2012 at 10:54:41AM +0200, Sami Kerola wrote:
>>> Hi Zheng,
>>>
>>> Wouldn't a patch such as below be better?
>>
>> Looks good to me.  But, IMHO, if reader cannot access Internet, my patch
>> maybe is better for them.  The original writer is not me.  So I don't
>> understand the original idea that puts ionice source code in here.  I
>> think that Jens can do the final decision.
>>
>> Hi Jens,
>>
>> What's your opintion about Sami's and my patch?
> 
> I note that it's nice to have a reference implementation for nontrivial
> things. Also, util-linux isn't the end-all and be-all of linux
> userspace: busybox has an ionice, and I plan to add an ionice
> implementation to toybox as well.
> 
> So fixing reference code is good. That said, this isn't a "fix", this is
> a rewrite adding all sorts of unnecessary complexity
> (internationalization? strtos32_or_error() instead of strtol()?) that
> makes it much _less_ effective as reference code.


OK.  I will repost a second version later.

Regards,
Zheng
