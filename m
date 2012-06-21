Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60616 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753392Ab2FUEuv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 21 Jun 2012 00:50:51 -0400
Received: by obbuo13 with SMTP id uo13so380951obb.19
        for <util-linux@vger.kernel.org>; Wed, 20 Jun 2012 21:50:49 -0700 (PDT)
Message-ID: <4FE2A825.1060103@landley.net>
Date: Wed, 20 Jun 2012 23:50:45 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
To: Sami Kerola <kerolasa@gmail.com>, Sami Kerola <kerolasa@iki.fi>,
        Jens Axboe <axboe@kernel.dk>,
        Bernhard Voelker <mail@bernhard-voelker.de>,
        Zheng Liu <wenqing.lz@taobao.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, util-linux@vger.kernel.org
Subject: Re: [PATCH] docs: block: update ioprio.txt
References: <1340095897-9014-1-git-send-email-wenqing.lz@taobao.com> <CAG27Bk2tXprRfMfYOVdWtwSbjw5Rw9Kxs6Wns+Gm65m3hoJawg@mail.gmail.com> <20120619102706.GA9273@gmail.com>
In-Reply-To: <20120619102706.GA9273@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 06/19/2012 05:27 AM, Zheng Liu wrote:
> Hi Sami,
> 
> [You forgot to CC'd other developers and mailing list]
> 
> On Tue, Jun 19, 2012 at 10:54:41AM +0200, Sami Kerola wrote:
>> Hi Zheng,
>>
>> Wouldn't a patch such as below be better?
> 
> Looks good to me.  But, IMHO, if reader cannot access Internet, my patch
> maybe is better for them.  The original writer is not me.  So I don't
> understand the original idea that puts ionice source code in here.  I
> think that Jens can do the final decision.
> 
> Hi Jens,
> 
> What's your opintion about Sami's and my patch?

I note that it's nice to have a reference implementation for nontrivial
things. Also, util-linux isn't the end-all and be-all of linux
userspace: busybox has an ionice, and I plan to add an ionice
implementation to toybox as well.

So fixing reference code is good. That said, this isn't a "fix", this is
a rewrite adding all sorts of unnecessary complexity
(internationalization? strtos32_or_error() instead of strtol()?) that
makes it much _less_ effective as reference code.

Rob
-- 
GNU/Linux isn't: Linux=GPLv2, GNU=GPLv3+, they can't share code.
Either it's "mere aggregation", or a license violation.  Pick one.
