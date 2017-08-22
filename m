Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.virtlab.unibo.it ([130.136.161.50]:33064 "EHLO
        mail.virtlab.unibo.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932148AbdHVI2q (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 22 Aug 2017 04:28:46 -0400
Date: Tue, 22 Aug 2017 10:20:47 +0200
From: Renzo Davoli <renzo@cs.unibo.it>
To: util-linux@vger.kernel.org
Subject: muont(1) does not support cap_sys_admin
Message-ID: <20170822082047.eczufv3naqlvulsn@cs.unibo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

mount command does not seem to support the cap_sys_admin capability.

In fact the command fails when the mount system call would succeeds
for operation permitted to users (e.g. bind mounts in user-namespaces)

For example using userbindmount
https://github.com/rd235/userbindmount

$ userbindmount -s --
$ mount --bind /tmp/resolv.conf /etc/resolv.conf 
mount: only root can use "--bind" option
$ busybox mount --bind /tmp/resolv.conf /etc/resolv.conf 
$

As it can be seen from the example above, busybox mount
succeeds on the same command where mount(1) fails.

"Mount" erroneously checks that the effective user is root
and returns an error prior to invoke the system call mount(2),
forbidding in this way permitted operations.

thank you

	renzo
