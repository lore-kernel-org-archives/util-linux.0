Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:36465 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055AbbJ3CPJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Oct 2015 22:15:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1ZrzDc-0006U4-0S
	for util-linux@vger.kernel.org; Fri, 30 Oct 2015 03:15:04 +0100
Received: from ip4d14b390.dynamic.kabel-deutschland.de ([77.20.179.144])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 30 Oct 2015 03:15:03 +0100
Received: from for-gmane by ip4d14b390.dynamic.kabel-deutschland.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 30 Oct 2015 03:15:03 +0100
To: util-linux@vger.kernel.org
From: "U.Mutlu" <for-gmane@mutluit.com>
Subject: unshare -m for non-root user
Date: Fri, 30 Oct 2015 03:09:15 +0100
Message-ID: <n0ujgc$tll$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,
I wonder why "unshare -m" doesn't work for an unpriviledged user:

$ unshare -m /bin/bash
unshare: unshare failed: Operation not permitted
$ echo $?
1
$ ls -l `which unshare`
-rwxr-xr-x 1 root root 14640 Mar 30  2015 /usr/bin/unshare

Funny thing: when making the binary setuid then it works.
But I would prefer a working original version in the OS repository.

OS: Debian 8

# dpkg -l | grep -i util-linux
ii  util-linux                                 2.25.2-6 
            amd64        Miscellaneous system utilities

Is this a bug, or is it not supposed to work for non-root users?

-- 
Thx

