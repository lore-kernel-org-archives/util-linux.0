Return-Path: util-linux-owner@vger.kernel.org
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58370 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933873AbcECSVH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 3 May 2016 14:21:07 -0400
Message-ID: <1462299656.16133.51.camel@HansenPartnership.com>
Subject: bind mounting namespace inodes for unprivileged users
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Linux Containers <containers@lists.linux-foundation.org>,
        util-linux@vger.kernel.org
Date: Tue, 03 May 2016 14:20:56 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Right at the moment, unprivileged users cannot call mount --bind to
create a permanent copy of any of their namespaces.  This is annoying
because it means that for entry to long running containers you have to
spawn an undying process and use nsenter via the /proc/<pid>/ns files.

The first question is:  assuming we restrict it to bind mounting only
nsfs inodes, is there any reason an unprivileged user shouldn't be able
to bind a namespace they've created to a file they own in the initial
mount namespace?

Assuming the answer to this is no, then how to implement it becomes the
next problem.  Right at the moment, util-linux/mount will deny a non
-root user the ability to use --bind.  This check could be relaxed and,
since mount is setuid root, it could be modified to force the binding
as root meaning this could be implemented entirely within the util
-linux package.

Doing this from within the kernel sys_mount is much more problematic:
no root users are forbidden from calling any type of mount by the
may_mount() check, which makes sure you only have root capability in
the user_ns attached to the current mnt_ns.  Overriding that simply to
allow nsfs binding looks like a recipe for introducing unexpected
security problems.

So, does anyone have any strong (or even weak) opinions about this
before I start coding patches?

James

