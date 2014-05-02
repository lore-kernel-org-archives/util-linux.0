Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vc0-f176.google.com ([209.85.220.176]:63981 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbaEBWhL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 2 May 2014 18:37:11 -0400
Received: by mail-vc0-f176.google.com with SMTP id lg15so3308298vcb.35
        for <util-linux@vger.kernel.org>; Fri, 02 May 2014 15:37:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201405022221.s42MLpT4015462@hobgoblin.ariadne.com>
References: <CALCETrUbaFwpdiLBv7G8GbkgUuiEgyyBWn0dr8R57NzCdSL9gg@mail.gmail.com>
 <201405022221.s42MLpT4015462@hobgoblin.ariadne.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 2 May 2014 15:36:50 -0700
Message-ID: <CALCETrUU6ziKYA3RSb_6nEW4HyeR5BLGQ_3SgcnnnLnBX1us0g@mail.gmail.com>
Subject: Re: getting rid of "mount: only root can ..."
To: "Dale R. Worley" <worley@alum.mit.edu>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, May 2, 2014 at 3:21 PM, Dale R. Worley <worley@alum.mit.edu> wrote:
>> From: Andy Lutomirski <luto@amacapital.net>
>>
>> This isn't really true any more.  Can we get rid of those checks or at
>> least have an option to turn them off?
>
> My understanding is that whether the user has to be root when running
> mount depends on the "user" and "users" options in fstab.  I assume
> that "those checks" haven't changed recently because the required
> behavior hasn't changed recently.

Blech.  I forgot that mount is setuid root.

What if mount determined that the requested option wasn't allowed by
fstab and instead fell back to dropping privileges and trying anyway?

--Andy
