Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53689 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab2CXJJb convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 24 Mar 2012 05:09:31 -0400
Received: by obbeh20 with SMTP id eh20so3148409obb.19
        for <util-linux@vger.kernel.org>; Sat, 24 Mar 2012 02:09:30 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 24 Mar 2012 09:09:30 +0000
Message-ID: <CA+eR4cHKY8uVHbARbsJpUQ_gHgMm7qpU_0Dt-E0pmZ16PND8nA@mail.gmail.com>
Subject: Removing trailing slash breaks SSHFS
From: Martin Panter <vadmium+floss@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi

I am using the util-linux version 2.21 on Arch Linux:

https://www.archlinux.org/packages/core/x86_64/util-linux

They have patched the 2.21-6 package to include the following commit
“lib/canonicalize: always remove tailing slash”:

https://git.kernel.org/?p=utils/util-linux/util-linux.git;a=commitdiff;h=28074a0

The result of this is that my SSHFS entry in my “fstab” file no longer
works properly. To demonstrate, this “mount” command

sudo mount -t fuse 'sshfs#marty@thee:/' /media/thee

strips the trailing slash and calls

/sbin/mount.fuse sshfs#marty@thee: /media/thee -o rw

which mounts the home directory rather than the entire remote file
system. A workaround seems to be to specify a double slash (e.g.
“thee://”), but it doesn’t seem healthy and I was wondering if either
this recent slash-removal could be avoided in the “mount” command, or
if my magic SSHFS usage was abusing how “mount” is meant to work.

-Martin
