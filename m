Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44189 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757481Ab1ANNcS convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 14 Jan 2011 08:32:18 -0500
Received: by bwz15 with SMTP id 15so2513132bwz.19
        for <util-linux@vger.kernel.org>; Fri, 14 Jan 2011 05:32:17 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?UHJ6ZW15c8WCYXcgJ1ByemVtb2MnIFBhd2XFgmN6eWs=?=
	<przemoc@gmail.com>
Date: Fri, 14 Jan 2011 14:31:55 +0100
Message-ID: <AANLkTimJJDm-9vu_xcMjh0uQSghZE44Miz1XaHcx=p7j@mail.gmail.com>
Subject: sfdisk enhancement proposal - offset/shift support
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

I have following suggestion for sfdisk:
- adding offset/shift support for cumbersome raw disk images (like
fixed-size VDI), that don't start at the beginning of the file.

Required changes?
IMO straightforward way is just adding another option (below is an
example), global variable (e.g. shift) and fixing sseek() code and
R.total_size in get_geometry() to take it into account.

    -t# [or --offset #]  ignore the number of bytes at the beginning

FWIW such option is rather useless for working on many files at the
same time, unless offsets are really the same. In case of fixed-size
VDI, offset depends on the image size.

Alternatives?
Some time ago I wrote a simple workaround for fixed-size VDIs (doing a
bit more than is needed here, i.e. finding also an offset of the raw
disk image) using LD_PRELOAD technique. It can be found here:
https://gist.github.com/571086. Now I think that having plain offset
option in sfdisk would be still useful. I even regret that I did not
mail about it back then in 2009, because maybe it would be available
in sfdisk for a long time already...

Anyway I'd like to know your opinions before making any patches. After
all I am not sure whether such functionality is acceptable in sfdisk
according to your rules.

Regards.

P.S. Please CC me (I am not on the list).

-- 
Przemysław 'Przemoc' Pawełczyk
http://przemoc.net/
