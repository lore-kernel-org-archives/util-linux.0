Return-Path: util-linux-owner@vger.kernel.org
Received: from mondschein.lichtvoll.de ([194.150.191.11]:36721 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeHEKjZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 5 Aug 2018 06:39:25 -0400
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 69A08382149
        for <util-linux@vger.kernel.org>; Sun,  5 Aug 2018 10:35:35 +0200 (CEST)
From: Martin Steigerwald <martin@lichtvoll.de>
To: util-linux@vger.kernel.org
Subject: =?UTF-8?B?RGViaWFuwrRz?= change of "su" to the one in util-linux
Date: Sun, 05 Aug 2018 10:35:34 +0200
Message-ID: <1734536.DseMWcvaqb@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello.

A new version of the util-linux package for Debian switched the "su" 
implementation from the one from the "shadow" package to the one in the 
"util-linux" package.

Now "su" from "util-linux" preserves PATH and IFS unless you use "su -" 
login shell mode. An item in the NEWS.Debian file explains that change:

https://sources.debian.org/src/util-linux/2.32-0.4/debian/util-linux.NEWS/

This difference broke an existing work-flow for me: I have a backup 
script that backups my laptop and my remote servers. It needs root 
access for creating BTRFS snapshots and for storing the actual data with 
ownership preserved. However, for accessing the remote servers it needs
access to the SSH agent running in the user session. The backup scripts 
uses commands that are in "sbin" related directories.

As the explanation was in the NEWS file was not there initially the 
first thing I did was to hard code the path in the backup script. Then 
even with the explanation I am not all that satisfied with the change in 
behavior and for now just set "ALWAYS_SET_PATH yes" in "login.defs".

Now people say, including Debian maintainer of util-linux, in above NEWS 
file entry: Using "su" without initializing new environment is a bad 
idea and should never be done. For many reasons. However, nowhere I saw 
these reasons actually mentioned. That is not enough for an informed 
decision about it. I already opened a bug report for util-linux package 
about no concrete reasons provided:

util-linux: su from util-linux: no reason why su without setting new 
environment is bad idea
https://bugs.debian.org/905478

And then: How to implement a backup script that needs root access for 
most operations, but also requires access to SSH agent from a user 
setup? Dig out the environment variables of the SSH agent myself? Let 
the script run as a user and use "setprivs" that is mentioned as 
recommend in the "su" manpage, yet is in a different package altogether 
and not part of "util-linux".

Also… login.defs manpage from shadow project does not mention 
"ALWAYS_SET_PATH", but manpage of su from util-linux does mention it. 
And there does not appear to be a manpage about "login.defs" in "util-
linux" package at all. (I found before that there appears to be a huge, 
big mess about some things in "util-linux", some in "shadow" and some in 
both).

http://man7.org/linux/man-pages/man5/login.defs.5.html

http://man7.org/linux/man-pages/man1/su.1.html

And it does not say why it would be a bad idea to just use it. Also the 
manpage does not say anything bad about using "su" without login shell 
mode.

So what is up here from upstream point of view?

Why would "su" without initializing environment be a "bad" idea? And how 
else to implement a backup script with access to SSH agent in the 
"proper" way?

Now all the fuss might be difficult for you to understand since other 
distributions use su from util-linux for a long time already. But for me 
there are currently really quite some question marks about what to use, 
what not to use and most importantly *why* to do so. There is quite some 
confusion. Debian used "su" from "shadow" package since… ages.

I may share some of your insights with the Debian bug report I 
mentioned, to help the maintainer to improve the wording that explains 
the change.

Thanks,
-- 
Martin


