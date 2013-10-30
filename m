Return-Path: util-linux-owner@vger.kernel.org
Received: from mailout07.t-online.de ([194.25.134.83]:49517 "EHLO
	mailout07.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab3J3Thi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 30 Oct 2013 15:37:38 -0400
Date: 30 Oct 2013 18:04:00 +0100
From: Hullen@t-online.de (Helmut Hullen)
To: util-linux@vger.kernel.org
Message-ID: <CgqsHWQuCXB@helmut.hullen.de>
In-Reply-To: <20131030164546.GL735@rampage>
Subject: Re: Bind mounts record fstype of none
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: helmut@hullen.de
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hallo, Dave,

Du meintest am 30.10.13:

[...]

>>> Where do you see 'none'?

>>         df -a -T
>>
>> Maybe that problem is related to the option "-type"; "bind" is no
>> allowed "type".

> The fstype of "none" only shows up on older systems where mtab is a
> regular file and not a symlink to /proc/self/mounts.

Yes - that's the difference on my system ("mtab" is a regular file).

Viele Gruesse!
Helmut
