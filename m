Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-po-07v.sys.comcast.net ([96.114.154.166]:57480 "EHLO
	resqmta-po-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933239AbaJ2O21 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 29 Oct 2014 10:28:27 -0400
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.7/8.14.7) with ESMTP id s9TESPKd031304
	for <util-linux@vger.kernel.org>; Wed, 29 Oct 2014 10:28:25 -0400
Date: Wed, 29 Oct 2014 10:28:24 -0400
Message-Id: <201410291428.s9TESOrd031303@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: util-linux@vger.kernel.org
In-reply-to: <544FCE46.2090709@tlinx.org> (lkml@tlinx.org)
Subject: Re: fdisk and 2048 sectors obsession.
References: <544E923E.6050406@gmail.com> <544E97ED.7040406@earthlink.net> <544F0C88.1080807@gmail.com> <544F3B20.7090109@gmail.com> <544FA923.5080205@gmail.com> <544FCE46.2090709@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It seems quite obvious to me -- New technologies are likely to make
the natural block size larger over time.  Where by "natural block
size", I mean the block alignment necessary to get highest performance
out of the device/system.  You don't want to have to keep modifying
your disk structuring software every time a new technology comes out
that has a larger natural block size -- and then discover you've got
to reorganize all your disk images.  By going to 1 MiB alignment now,
we may be able to keep the alignment and allocation policies stable
for ten or twenty years.

If you have a good reason to use a smaller alignment, the software
lets you override the default.  But the default minimizes the trouble
you risk in the future.

Dale
