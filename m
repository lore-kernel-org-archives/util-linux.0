Return-Path: linux-kernel-owner@vger.kernel.org
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <4FE2A825.1060103@landley.net>
References: <1340095897-9014-1-git-send-email-wenqing.lz@taobao.com>
	<CAG27Bk2tXprRfMfYOVdWtwSbjw5Rw9Kxs6Wns+Gm65m3hoJawg@mail.gmail.com>
	<20120619102706.GA9273@gmail.com>
	<4FE2A825.1060103@landley.net>
Date: Thu, 21 Jun 2012 08:50:25 +0200
Message-ID: <CAG27Bk1_q+fBvG49TO1TjwwALVjwhNoEWTOaiiUJt65=-3+7Kg@mail.gmail.com>
Subject: Re: [PATCH] docs: block: update ioprio.txt
From: Sami Kerola <kerolasa@iki.fi>
To: Rob Landley <rob@landley.net>
Cc: Jens Axboe <axboe@kernel.dk>, Bernhard Voelker <mail@bernhard-voelker.de>,
        Zheng Liu <wenqing.lz@taobao.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 21, 2012 at 6:50 AM, Rob Landley <rob@landley.net> wrote:
> On 06/19/2012 05:27 AM, Zheng Liu wrote:
>> Hi Sami,
>>
>> [You forgot to CC'd other developers and mailing list]

Some times I do that intentionally. Oh, well now when my opinion is public...

>> On Tue, Jun 19, 2012 at 10:54:41AM +0200, Sami Kerola wrote:
>>> Hi Zheng,
>>>
>>> Wouldn't a patch such as below be better?
>>
>> Looks good to me.  But, IMHO, if reader cannot access Internet, my patch
>> maybe is better for them.  The original writer is not me.  So I don't
>> understand the original idea that puts ionice source code in here.  I
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

That makes sense. How about having simple example in linux
Documentation/ and note with reference link to util-linux
implementation. The note could tell something like 'version various
distributions package comes from util-linux, please see [git link]'.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
