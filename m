Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:38824 "EHLO
	Ishtar.hs.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754533AbaHFWz7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 6 Aug 2014 18:55:59 -0400
Received: from [192.168.4.12] (athenae [192.168.4.12])
	by Ishtar.hs.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id s76MtuaD034005
	for <util-linux@vger.kernel.org>; Wed, 6 Aug 2014 15:55:59 -0700
Message-ID: <53E2B27C.9020305@tlinx.org>
Date: Wed, 06 Aug 2014 15:55:56 -0700
From: "Linda A. Walsh" <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Specifying a generic and per-fs mount line in /etc/fstab as well as no-canonicalize.
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Karel Zak wrote:
>
> Well, I'm trying to help you, so it would be nice to have more
> information about your use-case...
I think I explained that it was the default to follow user-specified
symbolic link names in following and echoing a path -- notable in shells
like bash.

if "/usr/src" is a symlink pointing to /home/src,

and under /home/src, packages points to ../packages, then when I
switch to /usr/src/packages, I see my path listed as /usr/src/packages:

>  cd /usr/src/packages
/usr/src/packages> pwd
/usr/src/packages

Only by asking an external util can I find the real name:
>  /bin/pwd
/home/packages

It's a display choice for *user-convenience* that was made over
years of feedback.

Why not allow the same paradigm in /etc/fstab and allow nocanonicalize as
an option with mounts in /etc/fstab?


