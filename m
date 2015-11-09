Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-ch2-06v.sys.comcast.net ([69.252.207.38]:53863 "EHLO
	resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751863AbbKIT7I (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 9 Nov 2015 14:59:08 -0500
From: worley@alum.mit.edu (Dale R. Worley)
To: Felix Miata <mrmazda@earthlink.net>
Cc: util-linux@vger.kernel.org
Subject: Re: what does "drive" mean in mlable man page?
In-Reply-To: <562570F9.40401@earthlink.net> (mrmazda@earthlink.net)
Date: Mon, 09 Nov 2015 14:59:06 -0500
Message-ID: <871tbz0ws5.fsf@hobgoblin.ariadne.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Felix Miata <mrmazda@earthlink.net> writes:
> Like in most man pages, examples that would explain ambiguous term meanings
> are absent. blkid [mlabel?] doesn't say what the existing "drive" is. How does one find
> out? Can "drive" be a synonym for device name? The mtools man page is
> ambiguous by lack of adequate example as well. I wish to change the labels on
> /dev/sdc3, /dev/sdc5 and /dev/sdc6.

You're right, an example would help.  But if you read closely, the page
says that mlabel is part of the mtools suite, which means that "drive"
is a single-letter simulated MS-DOS drive name, which is mapped into
/dev/... via /etc/mtools.conf (which is not mentioned in the "drive
letters" section of the mtools man page, but rather in the 2nd paragraph
of the introduction).

IIRC, there's an mtools mailing list.

Dale
