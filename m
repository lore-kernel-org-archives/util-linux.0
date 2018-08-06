Return-Path: util-linux-owner@vger.kernel.org
Received: from mondschein.lichtvoll.de ([194.150.191.11]:53153 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeHFKcl (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 6 Aug 2018 06:32:41 -0400
From: Martin Steigerwald <martin@lichtvoll.de>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: util-linux@vger.kernel.org
Subject: Re: =?UTF-8?B?RGViaWFuwrRz?= change of "su" to the one in util-linux
Date: Mon, 06 Aug 2018 10:24:43 +0200
Message-ID: <1642971.4ZBaquOb5i@merkaba>
In-Reply-To: <20180805150557.GC26138@thunk.org>
References: <1734536.DseMWcvaqb@merkaba> <20180805150557.GC26138@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Theodore Y. Ts'o - 05.08.18, 17:05:
> On Sun, Aug 05, 2018 at 10:35:34AM +0200, Martin Steigerwald wrote:
> > Now people say, including Debian maintainer of util-linux, in above
> > NEWS file entry: Using "su" without initializing new environment is
> > a bad idea and should never be done. For many reasons. However,
> > nowhere I saw these reasons actually mentioned. That is not enough
> > for an informed decision about it. I already opened a bug report
> > for util-linux package about no concrete reasons provided:
> > 
> > util-linux: su from util-linux: no reason why su without setting new
> > environment is bad idea
> > https://bugs.debian.org/905478
> 
> The reason why preserving the environment across a su or a sudo can be
> dangerous is that environments that are meant for use by an
> unprivileged process might not be appropriate at all when running as
> root.  There are lots of potential reasons why.  Here are some:
> 
> * The PATH might include the current directory, and so a script
[…]
> So for that reason, it makes sense that a "sudo" or "su" command
> should default to something safe.

Thank you, Ted. This is the best explanation I saw so far. I accept it 
for default.

In my specific case I still do not see any big issue with that cause the 
backup script runs on my laptop, the user I "su" from and "root" are 
both users only I have access to. So the risk in my case may mostly be 
that the script would pick an an inappropriate command. Due to me 
installing it. Someone who would get access to an regular user account 
could set up a bogus path as the user and install a malicious command 
there in order to gain "root" access or so. In my understanding of 
security it would be already too late if someone gained access to an 
user account on my laptop without my permission.

However I just tested on Debian by logging in as "root" on "tty1" and it 
still gives me "~/bin" and the "local" binary directories. Its "~/bin" 
which would be "/root/bin", not writable to by a regular user.

Interestingly enough it also prints the following error after entering 
the user name:

"configuration error – unknown item 'ALWAYS_SET_PATH' (notify 
administrator)"

The "login" command which is in the "login" package in Debian, which is 
part of the "shadow" source package, does not understand the option.

It appears to me that sharing a configuration file like this is not such 
a good idea. However, it continues and I can still login.

> > And then: How to implement a backup script that needs root access
> > for
> > most operations, but also requires access to SSH agent from a user
> > setup? Dig out the environment variables of the SSH agent myself?
> > Let
> > the script run as a user and use "setprivs" that is mentioned as
> > recommend in the "su" manpage, yet is in a different package
> > altogether and not part of "util-linux".
> 
> You might want to look at the man page for sudo, and its configuration
> files, especially sudoers.  It has a *huge* amount of fine-grained
> controls over which environment variables should be reset, and which
> ones which should be preserved, and whether or not a particular user
> should be trusted to override environment variable processing on the
> command line.

I knew it has a *huge* amount of fine-grained controls, but I did not 
know off hand whether I can also specify what environment variables to 
take over, thank you for telling me. I think I will go that route. I 
intend to make sudo -i / sudo -s just always give SSH agent environment 
variables to the "root" shell on my laptop.

However I likely do that when I feel like it. Its holiday time for me 
currently. And I do feel comfortable enough with using the 
"ALWAYS_SET_PATH" option on my laptop for now.

Thanks,
-- 
Martin


