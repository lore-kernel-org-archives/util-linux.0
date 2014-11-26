Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:64401 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbaKZAT1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 25 Nov 2014 19:19:27 -0500
Received: by mail-wg0-f43.google.com with SMTP id l18so2347827wgh.2
        for <util-linux@vger.kernel.org>; Tue, 25 Nov 2014 16:19:25 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 25 Nov 2014 16:19:25 -0800
Message-ID: <CAF+0mvmE_i0P350hT4E4a-ZTTuuS5PdZ2vw1siQ2HowpB2Xn-g@mail.gmail.com>
Subject: fdisk units size
From: Matthew Eaton <m.eaton82@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello, I have a quick question regarding recent fdisk.

I noticed fdisk -l now uses base 2 (GiB) instead of base 10 (GB) to
calculate device size.  This is good, but sometimes it is nice to see
the base 10 calculation, can this be toggled with a switch?  I can't
find a recent man page for fdisk.
