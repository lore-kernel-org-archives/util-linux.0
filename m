Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:33874 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754495AbbKRRR3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 18 Nov 2015 12:17:29 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1Zz6MH-0004YW-8i
	for util-linux@vger.kernel.org; Wed, 18 Nov 2015 18:17:25 +0100
Received: from ip4d14b390.dynamic.kabel-deutschland.de ([77.20.179.144])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 18 Nov 2015 18:17:25 +0100
Received: from for-gmane by ip4d14b390.dynamic.kabel-deutschland.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 18 Nov 2015 18:17:25 +0100
To: util-linux@vger.kernel.org
From: "U.Mutlu" <for-gmane@mutluit.com>
Subject: RFC: usermount - a secure mount for unpriviledged users
Date: Wed, 18 Nov 2015 18:17:12 +0100
Message-ID: <n2ibqp$ui6$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Currently no responsible admin can grant permission to the mount pgm
to his users, because of the dangers inherent with bind-mounting etc.

I suggest there should be an additional mount program destined for
unpriviledged users (to be used via sudo).

It should be a stripped down version of the mount pgm, with only some
basic options for mounting, but without the dangerous options like bind-mount.

The new program should of course have a different name, for example "usermount".

I think this is the most clean solution to this problem.

Users are intessted in mounting their own filesystems into
their own mountpoints, ie. they don't neccesserily need fstab or mtab etc.:
   $ mkdir mymnt1 mymnt2
   $ sudo usermount myfs.img ./mymnt1
   $ sudo usermount my.iso   ./mymnt2

I think the current author(s)/maintainer(s) of the mount pgm (Karel?)
should make and add such a stripped down usermount pgm to util-linux,
since they know mount the best.



