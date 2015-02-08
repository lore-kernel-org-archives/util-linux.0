Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-po-07v.sys.comcast.net ([96.114.154.166]:43306 "EHLO
	resqmta-po-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750747AbbBHChl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 7 Feb 2015 21:37:41 -0500
From: worley@alum.mit.edu (Dale R. Worley)
To: Felix Miata <mrmazda@earthlink.net>
Cc: util-linux@vger.kernel.org
Subject: Re: fdisk -l hits floppy drive
In-Reply-To: <54D5126A.3020308@earthlink.net> (mrmazda@earthlink.net)
Date: Sat, 07 Feb 2015 21:37:39 -0500
Message-ID: <87zj8pm8lo.fsf@hobgoblin.ariadne.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Felix Miata <mrmazda@earthlink.net> writes:
> fdisk -l is causing the floppy drive to get hit, which reflects the 4 kernel
> messages onto the tty running fdisk. Is this expected or intended?

I see in the manual page:

       -l     List the partition tables for the  specified  devices  and  then
              exit.   If no devices are given, those mentioned in /proc/parti-
              tions (if that exists) are used.

Is the floppy listed in /proc/partitions?

Dale
