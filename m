Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-ch2-03v.sys.comcast.net ([69.252.207.35]:56760 "EHLO
	resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752224AbaJCOix (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 3 Oct 2014 10:38:53 -0400
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.7/8.14.7) with ESMTP id s93EUdA7014848
	for <util-linux@vger.kernel.org>; Fri, 3 Oct 2014 10:30:39 -0400
Date: Fri, 3 Oct 2014 10:30:39 -0400
Message-Id: <201410031430.s93EUddT014847@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: util-linux@vger.kernel.org
Subject: Error in losetup man page
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fedora 19, the man page for losetup says:

       Delete all used loop devices:

            losetup -D

That should be "Delete all *unused* loop devices:", I'm sure.

Dale
