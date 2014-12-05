Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-ch2-05v.sys.comcast.net ([69.252.207.37]:46000 "EHLO
	resqmta-ch2-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751838AbaLECJO convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 4 Dec 2014 21:09:14 -0500
From: worley@alum.mit.edu (Dale R. Worley)
To: Pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Fwd: Re: util-linux: libblkid: UDF superblock
In-Reply-To: <201412042042.06702@pali> (pali.rohar@gmail.com)
Date: Thu, 04 Dec 2014 21:09:11 -0500
Message-ID: <87oaric0fs.fsf@hobgoblin.ariadne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Pali Rohár <pali.rohar@gmail.com> writes:
>> So I think that it is better to use LogicalVolumeIdentifier
>> for libblkid LABEL. And not current VolumeIdentifier.
>> 
>> What do you think?

If you change how the LABEL value is read from the disk, every user will
see different LABEL values than they saw in the past.

Dale
