Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42662 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053Ab1FLUYa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 12 Jun 2011 16:24:30 -0400
Received: by qwk3 with SMTP id 3so1941659qwk.19
        for <util-linux@vger.kernel.org>; Sun, 12 Jun 2011 13:24:27 -0700 (PDT)
Message-ID: <4DF5206F.1070308@tds.net>
Date: Sun, 12 Jun 2011 16:24:15 -0400
From: John Lindgren <john.lindgren@tds.net>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Typo in blkid manpage
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I think there is a typo in the blkid manpage.  Under the section for "-n
list", there is this example:

    blkid -p -u nominix /dev/sda1

This should be:

    blkid -p -n nominix /dev/sda1

-- John Lindgren
