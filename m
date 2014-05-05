Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vc0-f175.google.com ([209.85.220.175]:58784 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756894AbaEEW7L (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 May 2014 18:59:11 -0400
Received: by mail-vc0-f175.google.com with SMTP id lh4so9103vcb.6
        for <util-linux@vger.kernel.org>; Mon, 05 May 2014 15:59:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201405052250.s45Monxm008110@hobgoblin.ariadne.com>
References: <CALCETrUbaFwpdiLBv7G8GbkgUuiEgyyBWn0dr8R57NzCdSL9gg@mail.gmail.com>
 <201405022221.s42MLpT4015462@hobgoblin.ariadne.com> <CALCETrUU6ziKYA3RSb_6nEW4HyeR5BLGQ_3SgcnnnLnBX1us0g@mail.gmail.com>
 <201405052250.s45Monxm008110@hobgoblin.ariadne.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 5 May 2014 15:58:50 -0700
Message-ID: <CALCETrXTJpkA-EqzS=kvSfS4QEO5Gc3TV42+FFrUbQN3ALfuCw@mail.gmail.com>
Subject: Re: getting rid of "mount: only root can ..."
To: "Dale R. Worley" <worley@alum.mit.edu>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, May 5, 2014 at 3:50 PM, Dale R. Worley <worley@alum.mit.edu> wrote:
>> From: Andy Lutomirski <luto@amacapital.net>
>
>> What if mount determined that the requested option wasn't allowed by
>> fstab and instead fell back to dropping privileges and trying anyway?
>
> I'm not envisioning the problem that you're addressing very well.

If I set up a user namespace in which non-root users can call mount
(the system call), it's annoying to work with because mount (the
util-linux program) just assumes that uid != 0 means that mount won't
work.

The issue here is that there are two conflicting sets of policy: the
in-kernel policy of who may mount/umount and the userspace policy of
who may use the setuid mount tool to mount as euid == 0 despite their
actual (kernel) privileges.
