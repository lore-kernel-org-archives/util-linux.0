Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:38315 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751122AbeCIPGK (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 9 Mar 2018 10:06:10 -0500
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lip2P-1eOZHY1Foz-00cwWe for <util-linux@vger.kernel.org>; Fri, 09 Mar 2018
 16:06:09 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: debug parallel root checks
Date: Fri, 9 Mar 2018 16:06:08 +0100
References: <201803091547.40271.sweet_f_a@gmx.de>
In-Reply-To: <201803091547.40271.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201803091606.08473.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Friday 09 March 2018, Ruediger Meier wrote:
> Hi,
>
> Our parallel root checks look already nice on the first view.
> On the second view they fail the stress test, at least on my
> system.

Just an arbitrary example. Sometimes I get this failure

$ cat  tests/diff/mount/uuid
--- /tmp/ul2/tests/expected/mount/uuid  2018-03-09 11:04:54.992654305 +0100
+++ /tmp/ul2/tests/output/mount/uuid    2018-03-09 15:55:00.168028810 +0100
@@ -1 +1,2 @@
-Success
+mount: /tmp/ul2/tests/output/mount/uuid-mnt: can't find UUID="f102445a-f6f3-4657-bc58-81ff164fc0d9".
+A) Cannot find /dev/loop10 in /proc/mounts


So mount can't find that UUID although it was found before by
ts_uuid_by_devname, i.e. by blkid(1).

What could be the problem:
   - another test thread removed the UUID
   - invalid blkid cache
   - a bug?


cu,
Rudi
