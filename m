Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41816 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752561AbbAaJ6k (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 31 Jan 2015 04:58:40 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 5A6E0206B0
	for <util-linux@vger.kernel.org>; Sat, 31 Jan 2015 04:58:39 -0500 (EST)
Message-Id: <1422698319.1391339.221285309.35047434@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: cfdisk will happily create a partition of size zero
Date: Sat, 31 Jan 2015 10:58:39 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hi,

My disk is configured like this:

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

When I delete sda5 to sda8 and then sda4, and then recreate sda4,
and then in the free space create a partition of 1 sector, things
look like this:

    /dev/sda4               93755392  312581807  218826416  104.4G   5 Extended
    |-/dev/sda5             93757440   93757440          0      0B  83 Linux    
    `-Free space            93759488  312581807  218822320  104.4G

Strange.  Start and end of sda5 are on the same sector?

Anyway, if I then in the free space try to create a partition of
say 123M, the response on the bottombar is (in red):

Start sector 93759488 out of range.

??

Benno

-- 
http://www.fastmail.com - Access your email from home and the web

