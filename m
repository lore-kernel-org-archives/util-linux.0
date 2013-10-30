Return-Path: util-linux-owner@vger.kernel.org
Received: from mailout06.t-online.de ([194.25.134.19]:56932 "EHLO
	mailout06.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180Ab3J3QjN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 30 Oct 2013 12:39:13 -0400
Date: 30 Oct 2013 17:31:00 +0100
From: Hullen@t-online.de (Helmut Hullen)
To: util-linux@vger.kernel.org
Message-ID: <CgqsAZmPCXB@helmut.hullen.de>
In-Reply-To: <345614206.235496.1383150183769.open-xchange@email.1und1.de>
Subject: Re: Bind mounts record fstype of none
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: helmut@hullen.de
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hallo, Bernhard,

Du meintest am 30.10.13:

>> So is mount wrong for recording the filesystem type as 'none' or
>> not?

> Where do you see 'none'?

        df -a -T

Maybe that problem is related to the option "-type"; "bind" is no  
allowed "type".

Viele Gruesse!
Helmut
