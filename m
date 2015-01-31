Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47431 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751189AbbAaKHo (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 31 Jan 2015 05:07:44 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 4574920985
	for <util-linux@vger.kernel.org>; Sat, 31 Jan 2015 05:07:41 -0500 (EST)
Message-Id: <1422698861.1394092.221286633.65F82E93@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: cfdisk segfaults after trying to use unusable free space
Date: Sat, 31 Jan 2015 11:07:41 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


My disk still looks like this:

                                 Disk: /dev/sda
             Size: 149.1 GiB, 160041885696 bytes, 312581808 sectors
                       Label: dos, identifier: 0x5ef35ef3

    Device      Boot     Start       End   Sectors   Size Id Type
    /dev/sda1             2048  31262489  31260442  14.9G 83 Linux              
    /dev/sda2   *     31262490  62508914  31246425  14.9G 83 Linux
    /dev/sda3         62508915  93755339  31246425  14.9G 83 Linux
    /dev/sda4         93755401 312576704 218821304 104.4G  5 Extended
    |-/dev/sda5       93755403  94767434   1012032 494.2M 82 Linux swap / Solari
    |-/dev/sda6       94767498 252975554 158208057  75.5G 83 Linux
    |-/dev/sda7      252975618 282776129  29800512  14.2G 83 Linux
    `-/dev/sda8      282776193 312576704  29800512  14.2G 83 Linux
    Free space       312578048 312581807      3760   1.9M

If, with the pointer on the Free space, I do the following:
<N> <Backspace> <Backspace> <Backspace> <K> <Enter>
(which requests a new partition of 1K size)
the response on the bottombar is:

No free sectors available.

If I stubbornly try the same again
(<N> <Backspace> <Backspace> <Backspace> <K> <Enter>)
the response on the bottombar is now (in red):

Partition 8 is already defined.  Delete it before re-adding it.

Okay, I do what it says:
<Up> <D>

Segmentation fault

Benno

-- 
http://www.fastmail.com - IMAP accessible web-mail

