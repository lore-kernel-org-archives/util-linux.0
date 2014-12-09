Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-po-08v.sys.comcast.net ([96.114.154.167]:52216 "EHLO
	resqmta-po-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751689AbaLIVQ1 convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 9 Dec 2014 16:16:27 -0500
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.7/8.14.7) with ESMTP id sB9L89Ds013284
	for <util-linux@vger.kernel.org>; Tue, 9 Dec 2014 16:08:09 -0500
From: worley@alum.mit.edu (Dale R. Worley)
To: util-linux@vger.kernel.org
Subject: Re: Fwd: Re: util-linux: libblkid: UDF superblock
In-Reply-To: <201412091211.01584@pali> (pali.rohar@gmail.com)
Date: Tue, 09 Dec 2014 16:08:03 -0500
Message-ID: <87iohk8rbg.fsf@hobgoblin.ariadne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Pali Rohár <pali.rohar@gmail.com> writes:
> [...] All other 
> implementations which I saw are using LogicalVolumeIdentifier for 
> LABEL (it is also written in specification). And more... grub2 
> read LABEL from LogicalVolumeIdentifier, so you cannot specify 
> UDF disk by its LABEL from linux for grub2. I think this is bug 
> in util-linux which needs to be fixed. I understand that there 
> could be regressions, but current implementation is not correct 
> (it show wrong labels "555e3160"; show different as other 
> systems; is not correct according to specification).

This is a messy problem to handle correctly, and I think that to bring
about a good solution will take a considerable amount of research.  The
ultimate goal is to make things work as well as possible.  So it would
be quite helpful to accumulate information:

1) Talk to people who work on various Un*x kernels to identify what they
use for the LABEL value of UDF partitions.  This includes auxiliary
programs like Grub which function as their own kernel.

2) Start conversations with users and system packagers to identify how
much disruption would be caused by changing the util-linux behavior.

3) Start conversations to find out what would be the ideal behavior if
we were not constrained by history -- We want to move toward ideal
behavior rather than away from it.

In many situations, conversations like this gradually come to a
consensus as to what is the best direction of progress.

Dale
