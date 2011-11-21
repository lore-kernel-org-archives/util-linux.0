Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58900 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756583Ab1KUTsx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 21 Nov 2011 14:48:53 -0500
Received: by qadc14 with SMTP id c14so527190qad.19
        for <util-linux@vger.kernel.org>; Mon, 21 Nov 2011 11:48:53 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 21 Nov 2011 20:40:41 +0100
Message-ID: <CAMtsiiDWF3xCiFtENTaYS36zKOJjRHML0x2nk1P0d0zeU3qi0A@mail.gmail.com>
Subject: mkfs.minix V3 is broken
From: Maurizio Lombardi <m.lombardi85@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi all,

I noticed a lot of bugs in the mkfs.minix program when dealing with V3
filesystems.
I did a lot of fixes in the source code and then I decided to set up a
github repository to make the review easier:

git@github.com:maurizio-lombardi/util-linux.git

Can the mkfs.minix mantainer review the patches please?

Please cc me because I'm not subscribed to the list.

Regards,
-- 
--------------------
Maurizio Lombardi
